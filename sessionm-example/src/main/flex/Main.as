package {

import flash.display.StageAlign;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;

/*doc-start*/
import flash.display.Sprite;
import ludia.sessionm.ActivityType;
import ludia.sessionm.SessionM;
import ludia.sessionm.event.AchievementEvent;
import ludia.sessionm.event.ActivityEvent;
import ludia.sessionm.event.SessionEvent;
import ludia.sessionm.event.UserEvent;

public class Main extends Sprite {

    private var sessionM:SessionM;

    // Replace this by your SessionM App ID
    private var appID:String = "3f07ab1fa36c7232fd7f8d9c39abd4ba77336fe3";

    public function Main()
    {
        // This extension is not supported in the AIR emulator
        if(!SessionM.isSupported) {
            throw new Error("SessionM is not supported on this platform!");
        }
        sessionM = new SessionM();

        createUI();
    }

    /**
    * There are two versions that can be read : this extension version and
    * the underlying SessionM SDK version (which differs on Android and iOS)
    */
    public function getVersions():void {
        prependText("SDK: " + sessionM.getSDKVersion() + ", extension: " + sessionM.getExtensionVersion());
    }

    /**
    * Some olders mobile OS versions might not be supported by SessionM
    * This would not provoke errors but you can check for this in your app
    */
    public function isSupportedPlatform():void {
        prependText("Is supported platform: " + sessionM.isSupportedPlatform());
    }

    /**
    * Starting a session is mandatory before calling activity methods.
    */
    private function startSession():void {
        sessionM.addEventListener(SessionEvent.SESSION_STATE_CHANGED, sessionM_sessionStateChangedHandler);
        sessionM.addEventListener(UserEvent.USER_UPDATED, sessionM_userUpdatedHandler);
        sessionM.addEventListener(AchievementEvent.UNCLAIMED_ACHIEVEMENT, sessionM_unclaimedAchievementHandler);
        sessionM.startSession(appID);
    }

    /**
    * When a session is started, you will receive SessionEvent.SESSION_STATE_CHANGED
    */
    protected function sessionM_sessionStateChangedHandler(event:SessionEvent):void {
        prependText("Session state updated: " + event.state);
    }

    /**
     * When SessionM user data changes, you will receive UserEvent.USER_UPDATED
     */
    protected function sessionM_userUpdatedHandler(event:UserEvent):void {
        prependText("User updated: " + event.user.pointBalance + " mPOINTS, " + event.user.unclaimedAchievementCount + " unclaimed achievement(s)");
    }

    /**
     * When a user can claim a new achievement, you will receive AchievementEvent.UNCLAIMED_ACHIEVEMENT
     */
    private function sessionM_unclaimedAchievementHandler(event:AchievementEvent):void {
        prependText("Unclaimed achievement: " + event.achievement.name);
    }

    /**
     * When using custom achievements, this instructs SessionM that a user performed a specific action that would
     * eventually reward him with an achievement
     */
    public function logAction():void {
        sessionM.logAction("example");
    }

    /**
     * Returns the value for isSupportedPlatform() in the native SDK
     */
    public function isSupportedPlatform():void {
        prependText("Is supported platform: " + sessionM.isSupportedPlatform());
    }

    /**
     * Read both extension version and SDK version, for instance to construct a User-Agent string
     */
    public function getVersions():void {
        prependText("SDK: " + sessionM.getSDKVersion() + ", extension: " + sessionM.getExtensionVersion());
    }

    /**
     * You can retrieve user data at anytime
     */
    public function getUserInfo():void {
        prependText("User: " + sessionM.getUser());
        prependText("Unclaimed achievement: " + sessionM.getUnclaimedAchievement());
    }

    /**
     * Calling presentActivity() with ActivityType.PORTAL opens the main SessionM overlay,
     * where the user can engage with various offers.
     * You can subscribe to events of the ActivityEvent class to perform some custom logic.
     */
    private function presentPortal():void {
        sessionM.addEventListener(ActivityEvent.ACTIVITY_DISMISSED, sessionM_activityDismissedHandler);
        sessionM.addEventListener(ActivityEvent.ACTIVITY_PRESENTED, sessionM_activityPresentedHandler);
        sessionM.addEventListener(ActivityEvent.ACTIVITY_UNAVAILABLE, sessionM_activityUnavailableHandler);
        sessionM.addEventListener(ActivityEvent.USER_ACTION, sessionM_userActionHandler);
        sessionM.presentActivity(ActivityType.PORTAL);
    }

    /**
     * Calling presentActivity() with ActivityType.ACHIEVEMENT opens an achievement popup,
     * if the user has unclaimed achievements.
     * You can subscribe to events of the ActivityEvent class to perform some custom logic.
     */
    private function presentAchievement():void {
        sessionM.addEventListener(ActivityEvent.ACTIVITY_DISMISSED, sessionM_activityDismissedHandler);
        sessionM.addEventListener(ActivityEvent.ACTIVITY_PRESENTED, sessionM_activityPresentedHandler);
        sessionM.addEventListener(ActivityEvent.ACTIVITY_UNAVAILABLE, sessionM_activityUnavailableHandler);
        sessionM.addEventListener(ActivityEvent.USER_ACTION, sessionM_userActionHandler);
        sessionM.presentActivity(ActivityType.ACHIEVEMENT);
    }

    protected function sessionM_activityDismissedHandler(event:ActivityEvent):void {
        prependText("Activity dismissed");
    }

    protected function sessionM_activityPresentedHandler(event:ActivityEvent):void {
        prependText("Activity presented");
    }

    protected function sessionM_activityUnavailableHandler(event:ActivityEvent):void {
        prependText("Activity unavailable");
    }

    protected function sessionM_userActionHandler(event:ActivityEvent):void {
        prependText("User action: " + event.userAction);
    }

    /*doc-end*/

    private function clearLog():void {
        txtStatus.text = "";
    }

    private function prependText(text:String):void {
        txtStatus.text = text + "\n" + txtStatus.text;
    }


    /** Status */
    private var txtStatus:TextField;

    /** Buttons */
    private var buttonContainer:Sprite;

    /** Create UI */
    public function createUI():void
    {
        stage.align = StageAlign.TOP_LEFT;
        txtStatus=new TextField();
        txtStatus.defaultTextFormat=new TextFormat("Arial",20);
        txtStatus.width=stage.stageWidth;
        txtStatus.height=300;
        txtStatus.multiline=true;
        txtStatus.wordWrap=true;
        txtStatus.text="Press \"Start session\"";
        txtStatus.y = 10;
        addChild(txtStatus);

        buttonContainer=new Sprite();
        buttonContainer.y=txtStatus.height;
        addChild(buttonContainer);

        var uiRect:Rectangle=new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
        var layout:ButtonLayout=new ButtonLayout(uiRect,14);
        layout.addButton(new SimpleButton(new Command("Start session",startSession)));
        layout.addButton(new SimpleButton(new Command("Log Action",logAction)));
        layout.addButton(new SimpleButton(new Command("Present portal", presentPortal)));
        layout.addButton(new SimpleButton(new Command("Present achievement", presentAchievement)));
        layout.addButton(new SimpleButton(new Command("Get user info", getUserInfo)));
        layout.addButton(new SimpleButton(new Command("Is supported platform", isSupportedPlatform)));
        layout.addButton(new SimpleButton(new Command("Get versions", getVersions)));
        layout.addButton(new SimpleButton(new Command("Clear log", clearLog)));

        layout.attach(buttonContainer);
        layout.layout();
    }
}
}
