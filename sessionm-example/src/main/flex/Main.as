package {

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;

import ludia.sessionm.ActivityType;

import ludia.sessionm.SessionM;
import ludia.sessionm.event.AchievementEvent;
import ludia.sessionm.event.ActivityEvent;
import ludia.sessionm.event.SessionEvent;
import ludia.sessionm.event.UserEvent;


public class Main extends Sprite {

    private var sessionM:SessionM;

    /** Status */
    private var txtStatus:TextField;

    /** Buttons */
    private var buttonContainer:Sprite;


    public function Main()
    {
        if(!SessionM.isSupported) {
            throw new Error("SessionM is not supported on this platform!");
        }
        sessionM = new SessionM();

        createUI();
    }

    private function startSession():void {
        sessionM.addEventListener(SessionEvent.SESSION_STATE_CHANGED, sessionM_sessionStateChangedHandler);
        sessionM.addEventListener(UserEvent.USER_UPDATED, sessionM_userUpdatedHandler);
        sessionM.addEventListener(AchievementEvent.UNCLAIMED_ACHIEVEMENT, sessionM_unclaimedAchievementHandler);
        sessionM.startSession("3f07ab1fa36c7232fd7f8d9c39abd4ba77336fe3");
    }

    protected function sessionM_sessionStateChangedHandler(event:SessionEvent):void {
        prependText("Session state updated: " + event.state);
    }

    protected function sessionM_userUpdatedHandler(event:UserEvent):void {
        prependText("User updated: " + event.user.pointBalance + " mPOINTS, " + event.user.unclaimedAchievementCount + " unclaimed achievement(s)");
    }

    private function sessionM_unclaimedAchievementHandler(event:AchievementEvent):void {
        prependText("Unclaimed achievement: " + event.achievement.name);
    }

    public function logAction():void {
        sessionM.logAction("example");
    }

    private function presentPortal():void {
        sessionM.addEventListener(ActivityEvent.ACTIVITY_DISMISSED, sessionM_activityDismissedHandler);
        sessionM.addEventListener(ActivityEvent.ACTIVITY_PRESENTED, sessionM_activityPresentedHandler);
        sessionM.addEventListener(ActivityEvent.ACTIVITY_UNAVAILABLE, sessionM_activityUnavailableHandler);
        sessionM.addEventListener(ActivityEvent.USER_ACTION, sessionM_userActionHandler);
        sessionM.presentActivity(ActivityType.PORTAL);
    }

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

    private function clearLog():void {
        txtStatus.text = "";
    }

    private function prependText(text:String):void {
        txtStatus.text = text + "\n" + txtStatus.text;
    }

    /** Create UI */
    public function createUI():void
    {
        stage.align = StageAlign.TOP_LEFT;
        txtStatus=new TextField();
        txtStatus.defaultTextFormat=new TextFormat("Arial",20);
        txtStatus.width=stage.stageWidth;
        txtStatus.height=400;
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
        layout.addButton(new SimpleButton(new Command("Clear log", clearLog)));

        layout.attach(buttonContainer);
        layout.layout();
    }
}
}
