package ludia.sessionm.event {
import flash.events.Event;

import ludia.sessionm.data.UserAction;

public class ActivityEvent extends Event {

    public static const ACTIVITY_PRESENTED:String = "activityPresented";
    public static const ACTIVITY_DISMISSED:String = "activityDismissed";
    public static const ACTIVITY_UNAVAILABLE:String = "activityUnavailable";
    public static const USER_ACTION:String = "userAction";

    private var _userAction:UserAction;

    public function ActivityEvent(type:String, userAction:UserAction = null) {
        super(type);

        this._userAction = userAction;
    }

    public function get userAction():UserAction {
        return _userAction;
    }
}
}
