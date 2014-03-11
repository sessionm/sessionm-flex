package ludia.sessionm.data {
public class UserAction {

    public static const ACHIEVEMENT_VIEWED:String = "ACHIEVEMENT_VIEWED";
    public static const ACHIEVEMENT_ENGAGED:String = "ACHIEVEMENT_ENGAGED";
    public static const ACHIEVEMENT_DISMISSED:String = "ACHIEVEMENT_DISMISSED";
    public static const SPONSOR_CONTENT_VIEWED:String = "SPONSOR_CONTENT_VIEWED";
    public static const SPONSOR_CONTENT_ENGAGED:String = "SPONSOR_CONTENT_ENGAGED";
    public static const SPONSOR_CONTENT_DISMISSED:String = "SPONSOR_CONTENT_DISMISSED";
    public static const PORTAL_VIEWED:String = "PORTAL_VIEWED";
    public static const PORTAL_DISMISSED:String = "PORTAL_DISMISSED";
    public static const SIGN_IN:String = "SIGN_IN";
    public static const SIGN_OUT:String = "SIGN_OUT";
    public static const REGISTERED:String = "REGISTERED";
    public static const REDEEMED_REWARD:String = "REDEEMED_REWARD";
    public static const OTHER:String = "OTHER";

    private var _achievementName:String;
    private var _pageName:String;
    private var _sponsorContentName:String;
    private var _rewardName:String;

    private var _type:String;

    public function UserAction(source:Object) {
        this._type = source.userAction;

        this._achievementName = source.achievementName;
        this._pageName = source.pageName;
        this._sponsorContentName = source.sponsorContentName;
        this._rewardName = source.rewardName;
    }

    public function get type():String {
        return _type;
    }

    public function get achievementName():String {
        return _achievementName;
    }

    public function get pageName():String {
        return _pageName;
    }

    public function get sponsorContentName():String {
        return _sponsorContentName;
    }

    public function get rewardName():String {
        return _rewardName;
    }


    public function toString():String {
        return "UserAction{achievementName=" + String(achievementName) + ",pageName=" + String(pageName) + ",sponsorContentName=" + String(sponsorContentName) + ",rewardName=" + String(rewardName) + ",type=" + String(type) + "}";
    }
}
}
