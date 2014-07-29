package sessionm.flex.event {
import flash.events.Event;

import sessionm.flex.data.UserAction;

/**
 * Dispatched when activity occurs that requires an update to the UI, or when
 * the user performs one of several pre-defined actions such as signing in.
 *
 * @see sessionm.flex.data.UserAction
 */
public class ActivityEvent extends Event {
    /**
     * Defines the value of the <code>type</code> property for an
     * <code>activityPresented</code> event (dispatched when either the rewards
     * portal or a standard (non-custom) achievement is presented).
     *
     * @eventType activityPresented
     */
    public static const ACTIVITY_PRESENTED:String = "activityPresented";
    /**
     * Defines the value of the <code>type</code> property for an
     * <code>activityDismissed</code> event (dispatched when the user dimisses
     * either the rewards portal or a standard (non-custom) achievement).
     *
     * @eventType activityDismissed
     */
    public static const ACTIVITY_DISMISSED:String = "activityDismissed";
    /**
     * Defines the value of the <code>type</code> property for an
     * <code>activityUnavailable</code> event (dispatched when the SessionM SDK
     * fails when dispatching another <code>ActivityEvent</code>).
     *
     * @eventType activityUnavailable
     */
    public static const ACTIVITY_UNAVAILABLE:String = "activityUnavailable";
    /**
     * Defines the value of the <code>type</code> property for an
     * <code>userAction</code> event (dispatched when the user performs one of
     * several pre-defined actions such as signing in).
     *
     * @eventType userAction
     */
    public static const USER_ACTION:String = "userAction";

    /**
     * The action performed by the user.
     *
     * @private
     * @default null
     */
    private var _userAction:UserAction;

    /**
     * The <code>ActivityEvent</code> constructor.
     *
     * @public
     * @param type the event type.
     * @param userAction the action performed by the user.
     */
    public function ActivityEvent(type:String, userAction:UserAction = null) {
        super(type);

        this._userAction = userAction;
    }

    /**
     * The action performed by the user.
     *
     * @public
     * @default null
     * @see sessionm.flex.data.UserAction
     */
    public function get userAction():UserAction {
        return _userAction;
    }
}
}
