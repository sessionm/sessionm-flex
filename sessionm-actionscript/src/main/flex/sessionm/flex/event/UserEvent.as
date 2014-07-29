package sessionm.flex.event {
import flash.events.Event;

import sessionm.flex.data.User;

/**
 * Dispatched when user data such as the number of unclaimed achievements is
 * updated.
 *
 * @see sessionm.flex.data.User
 */
public class UserEvent extends Event {
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>userUpdated</code> event.
     *
     * @eventType userUpdated
     */
    public static const USER_UPDATED:String = "userUpdated";

    /**
     * The user of the current session.
     *
     * @private
     * @default null
     */
    private var _user:User;

    /**
     * The <code>UserEvent</code> constructor.
     *
     * @public
     * @param type the event type.
     * @param user the user of the current session.
     */
    public function UserEvent(type:String, user:User) {
        super(type);

        this._user = user;
    }

    /**
     * The user of the current session.
     *
     * @public
     * @default null
     * @see sessionm.flex.data.User
     */
    public function get user():User {
        return _user;
    }
}
}
