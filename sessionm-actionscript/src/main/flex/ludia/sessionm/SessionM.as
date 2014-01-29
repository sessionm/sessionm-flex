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

import mx.logging.Log;

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

    public function SessionM() {
        this.context = ExtensionContext.createExtensionContext(ID, null);
        try {
            logger = Log.getLogger("ludia.sessionm.SessionM");
        }
        catch (error:Error) {
            logger = new FallbackLogger();
        }
        if(!context) {
            logger.debug("Context could not be created");
        }
        else {
            this.context.addEventListener(StatusEvent.STATUS, statusHandler);
        }
    }

    public function logAction(action:String):void {
        callExtension("logAction", action);
    }


    public function presentActivity(activity:String):void {
        callExtension("presentActivity", activity);
    }


    public function getSessionState():String {
        var stateString:String;
        try {
            stateString = String(context.call("getSessionState"));
        }
        catch (error:Error) {
            logger.error("Unknown error: {0}", error);
        }
        if(!stateString) {
            throw new Error("Missing state string");
        }
        return stateString;
    }


    public function startSession(appID:String):void {
        callExtension("startSession", appID);
    }

    /**
     * @private
     * @param event
     */
    protected function statusHandler(event:StatusEvent):void {

        var type:String = event.code;

        if(hasConstant(SessionEvent, type)) {
            manageStateChange(event);
        }
        else if(hasConstant(UserEvent, type)) {
            manageUser(event);
        }
        else if(hasConstant(AchievementEvent, type)) {
            manageAchievement(event);
        }
        else if(hasConstant(ActivityEvent, type)) {
            manageActivity(event);
        }
        else if(event.type == "LOG") {
            logger.debug(event.level);
        }
        else {
            logger.debug("Un-managed event code={0} level={1}", event.code, event.level);
        }
    }

    private function hasConstant(cls:Class, name:String):Boolean {
        return cls[name] != null;
    }

    private function manageStateChange(event:StatusEvent):void {
        dispatchEvent(new SessionEvent(SessionEvent.SESSION_STATE_CHANGED, event.level));
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
        dispatchEvent(new ActivityEvent(event.type, userAction));
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
        return Capabilities.manufacturer.indexOf("Android") > -1;
    }

    public function dispose():void {
        if(context) {
            context.dispose();
            context =  null;
        }
    }
}
}
