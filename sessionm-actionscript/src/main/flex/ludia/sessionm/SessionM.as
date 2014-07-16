package ludia.sessionm {

import flash.events.EventDispatcher;
import flash.events.StatusEvent;
import flash.external.ExtensionContext;
import flash.system.Capabilities;

import ludia.sessionm.data.Achievement;
import ludia.sessionm.data.User;
import ludia.sessionm.data.UserAction;

import ludia.sessionm.event.AchievementEvent;
import ludia.sessionm.event.ActivityEvent;
import ludia.sessionm.event.SessionEvent;
import ludia.sessionm.event.UserEvent;

// import mx.logging.Log;

[Event(type="ludia.sessionm.event.AchievementEvent", name="unclaimedAchievement")]
[Event(type="ludia.sessionm.event.ActivityEvent", name="activityPresented")]
[Event(type="ludia.sessionm.event.ActivityEvent", name="activityDismissed")]
[Event(type="ludia.sessionm.event.ActivityEvent", name="userAction")]
[Event(type="ludia.sessionm.event.SessionEvent", name="sessionStateChanged")]
[Event(type="ludia.sessionm.event.UserEvent", name="userUpdated")]
public class SessionM extends EventDispatcher implements ISessionM {

    public static const ID:String = "com.ludia.client.sessionm";
    public var logger:* = null;

    private var context:ExtensionContext;
    private var globalState:String = "STARTED_OFFLINE";

    public function SessionM() {
        this.context = ExtensionContext.createExtensionContext(ID, null);
        logger = new FallbackLogger();

        /* try {
            logger = Log.getLogger(ID);
        }
        catch (error:Error) {
            logger = new FallbackLogger();
        } */
        if(!context) {
            throw new Error("Un-supported platform, use isSupported property before creating a SessionM object");
        }
        else {
            this.context.addEventListener(StatusEvent.STATUS, statusHandler);
        }
    }

    public function logAction(action:String):void {
        callExtension("logAction", action);
    }

    public function initActivity(activity:String):void {
    	callExtension("initActivity", activity);
    }

    public function initCustomActivity():void {
    	context.call("initCustomActivity");
    }

    public function dismissCustomAchievement(dismissalType:String):void {
    	callExtension("dismissCustomAchievement", dismissalType);
    }


    public function startSession(appID:String):void {
        callExtension("startSession", appID);
    }

    public function getUser():User {
        var user:User;
        var userString:String;
        try {
            var returnVal:* = context.call("getUser");
            if(returnVal) {
                userString = String(returnVal);
                user = new User(JSON.parse(userString));
            }
        }
        catch (error:Error) {
            logger.error("Unknown error: {0}", error);
            user = null;
        }
        return user;
    }

    public function getUnclaimedAchievement():Achievement {
        var achievement:Achievement;
        var achievementStr:String;
        try {
            var returnVal:* = context.call("getUnclaimedAchievement");
            if(returnVal) {
                achievementStr = String(returnVal);
                achievement = new Achievement(JSON.parse(achievementStr));
            }
        }
        catch (error:Error) {
            logger.error("Unknown error: {0}", error);
            achievement = null;
        }
        return achievement;
    }

    public function isSupportedPlatform():Boolean {
        var supported:Boolean = false;
        try {
            var returnVal:* = context.call("isSupportedPlatform");
            supported = Boolean(returnVal);
        }
        catch (error:Error) {
            logger.error("Unknown error: {0}", error);
            supported = false;
        }
        return supported;
    }


    public function getSDKVersion():String {
        var version:String = "unknown";
        try {
            var returnVal:* = context.call("getSDKVersion");
            logger.debug("getSDKVersion return value: {0}", returnVal);
            version = String(returnVal);
        }
        catch (error:Error) {
            logger.error("Unknown error: {0}", error);
        }
        return version;
    }

    public function getExtensionVersion():String {
        return "unknown";
    }

    /** 
     * @public
     * @returns Boolean
     *
     * Returns true if the rewards icon should be displayed, i.e. when the session state
     * is "STARTED_ONLINE" and the user has not opted out of rewards
     */
    public function shouldDisplayRewardsBadge():Boolean {
        var display:Boolean = false;
 
        if (globalState == "STARTED_ONLINE" && getUser().optedOut == false) {
            display = true;
        }
        else {
            display = false;
        }

        return display;
    }

    /**
     * @private
     * @param event
     */
    protected function statusHandler(event:StatusEvent):void {

        var code:String = event.code;

        logger.debug("StatusEvent code={0} level={1}", code, event.level);

        if(hasConstant(SessionEvent, code)) {
            manageStateChange(event);
        }
        else if(hasConstant(UserEvent, code)) {
            manageUser(event);
        }
        else if(hasConstant(AchievementEvent, code)) {
            manageAchievement(event);
        }
        else if(hasConstant(ActivityEvent, code)) {
            manageActivity(event);
        }
        else if(code == "LOG") {
            logger.debug(event.level);
        }
    }

    private function hasConstant(cls:Class, name:String):Boolean {
        return cls[name] != null;
    }

    private function manageStateChange(event:StatusEvent):void {
        var sessionEvent:SessionEvent = new SessionEvent(SessionEvent.SESSION_STATE_CHANGED, event.level);

        globalState = event.level;
        dispatchEvent(sessionEvent);
    }

    private function manageAchievement(event:StatusEvent):void {
        var achievement:Achievement = new Achievement(JSON.parse(event.level));
        dispatchEvent(new AchievementEvent(AchievementEvent.UNCLAIMED_ACHIEVEMENT, achievement));
    }

    private function manageActivity(event:StatusEvent):void {
        var userAction:UserAction;
        if(event.level) {
            userAction = new UserAction(JSON.parse(event.level));
        }
        var eventType:String = ActivityEvent[event.code];
        dispatchEvent(new ActivityEvent(eventType, userAction));
    }

    private function manageUser(event:StatusEvent):void {
        var user:User = new User(JSON.parse(event.level));
        dispatchEvent(new UserEvent(UserEvent.USER_UPDATED, user));
    }

    /**
     * Logs call to <code>ExtensionContext.call</code>
     *
     * @param method
     * @param args
     * @throws Error
     */
    protected function callExtension(method:String, ...args):* {
        try {
            if(args && args.length > 0) {
                logger.debug("Calling " + method + " with " + args);
            }
            else {
                logger.debug("Calling " + method + " with no arguments");
            }
            var ret:* = context.call.apply(null, [method].concat(args));

            if(ret) {
                logger.debug("Call " + method + " returned " + ret);
            }
            else {
                logger.debug("Call " + method + " returned nothing");
            }
        }
        catch (error:Error) {
            logger.error("Unknown error: {0}", error);
            return false;
        }
        return true;
    }

    public static function get isSupported():Boolean {
        return Capabilities.manufacturer.indexOf("Android") > -1 || Capabilities.manufacturer.indexOf("iOS") > -1;
    }

    public function dispose():void {
        if(context) {
            context.dispose();
            context =  null;
        }
    }
}
}