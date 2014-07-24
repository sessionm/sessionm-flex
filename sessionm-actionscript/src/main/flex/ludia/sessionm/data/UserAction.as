package ludia.sessionm.data {
/**
 * Stores the data associated with a user action.
 */
public class UserAction {
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>achievementViewed</code> event.
     *
     * @eventType achievementViewed
     */
    public static const ACHIEVEMENT_VIEWED:String = "ACHIEVEMENT_VIEWED";
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>achievementEngaged</code> event.
     *
     * @eventType achievementEngaged
     */
    public static const ACHIEVEMENT_ENGAGED:String = "ACHIEVEMENT_ENGAGED";
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>achievementDismissed</code> event.
     *
     * @eventType achievementDismissed
     */
    public static const ACHIEVEMENT_DISMISSED:String = "ACHIEVEMENT_DISMISSED";
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>sponsorContentViewed</code> event.
     *
     * @eventType sponsorContentViewed
     */
    public static const SPONSOR_CONTENT_VIEWED:String = "SPONSOR_CONTENT_VIEWED";
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>sponsorContentEngaged</code> event.
     *
     * @eventType sponsorContentEngaged
     */
    public static const SPONSOR_CONTENT_ENGAGED:String = "SPONSOR_CONTENT_ENGAGED";
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>sponsorContentDismissed</code> event.
     *
     * @eventType sponsorContentDismissed
     */
    public static const SPONSOR_CONTENT_DISMISSED:String = "SPONSOR_CONTENT_DISMISSED";
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>portalViewed</code> event.
     *
     * @eventType portalViewed
     */
    public static const PORTAL_VIEWED:String = "PORTAL_VIEWED";
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>portalDismissed</code> event.
     *
     * @eventType portalDismissed
     */
    public static const PORTAL_DISMISSED:String = "PORTAL_DISMISSED";
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>signIn</code> event.
     *
     * @eventType signIn
     */
    public static const SIGN_IN:String = "SIGN_IN";
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>signOut</code> event.
     *
     * @eventType signOut
     */
    public static const SIGN_OUT:String = "SIGN_OUT";
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>registered</code> event.
     *
     * @eventType registered
     */
    public static const REGISTERED:String = "REGISTERED";
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>redeemedReward</code> event.
     *
     * @eventType redeemedReward
     */
    public static const REDEEMED_REWARD:String = "REDEEMED_REWARD";
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>other</code> event.
     *
     * @eventType other
     */
    public static const OTHER:String = "OTHER";

    /**
     * The name of the achievement that the user has interacted with.
     *
     * @public
     * @default <code>null</code>
     */
    private var _achievementName:String;
    /**
     * The name of the page that the user has interacted with.
     *
     * @private
     * @default <code>null</code>
     */
    private var _pageName:String;
    /**
     * The name of the sponsor content that the user has interacted with.
     *
     * @private
     * @default <code>null</code>
     */
    private var _sponsorContentName:String;
    /**
     * The name of the reward that the user has redeemed.
     *
     * @private
     * @default <code>null</code>
     */
    private var _rewardName:String;

    /**
     * The user action's event type.
     *
     * @private
     * @default <code>null</code>
     */
    private var _type:String;

    /**
     * The <code>UserAction</code> constructor.
     *
     * @public
     * @param source the JSON source used to initialize the
     * <code>UserAction</code> instance.
     */
    public function UserAction(source:Object) {
        this._type = source.userAction;

        this._achievementName = source.achievementName;
        this._pageName = source.pageName;
        this._sponsorContentName = source.sponsorContentName;
        this._rewardName = source.rewardName;
    }

    /**
     * The user action's event type.
     *
     * @public
     * @default <code>null</code>
     */
    public function get type():String {
        return _type;
    }

    /**
     * The name of the achievement that the user has interacted with.
     *
     * @public
     * @default <code>null</code>
     */
    public function get achievementName():String {
        return _achievementName;
    }

    /**
     * The name of the page that the user has interacted with.
     *
     * @public
     * @default <code>null</code>
     */
    public function get pageName():String {
        return _pageName;
    }

    /**
     * The name of the sponsor content that the user has interacted with.
     *
     * @public
     * @default <code>null</code>
     */
    public function get sponsorContentName():String {
        return _sponsorContentName;
    }

    /**
     * The name of the reward that the user has redeemed.
     *
     * @public
     * @default <code>null</code>
     */
    public function get rewardName():String {
        return _rewardName;
    }


    /**
     * Converts the user action data into a <code>String</code> representation.
     *
     * @public
     * @return the <code>String</code> representation of the user action.
     */
    public function toString():String {
        return "UserAction{achievementName=" + String(achievementName) + ",pageName=" + String(pageName) + ",sponsorContentName=" + String(sponsorContentName) + ",rewardName=" + String(rewardName) + ",type=" + String(type) + "}";
    }
}
}
