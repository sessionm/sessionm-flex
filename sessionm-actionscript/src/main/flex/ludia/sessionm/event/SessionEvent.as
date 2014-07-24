package ludia.sessionm.event {
import flash.events.Event;

/**
 * Dispatched when the session state changes.
 *
 * @see ludia.sessionm.data.State
 */
public class SessionEvent extends Event {
    /**
     * Defines the value of the <code>type</code> property for a
     * <code>sessionStateChanged</code> event.
     *
     * @eventType sessionStateChanged
     */
    public static const SESSION_STATE_CHANGED:String = "sessionStateChanged";

    /**
     * The session state.
     *
     * @private
     * @default null
     */
    private var _state:String;

    /**
     * The <code>SessionEvent</code> constructor.
     *
     * @public
     * @param type the event type.
     * @param state the session state.
     */
    public function SessionEvent(type:String, state:String) {
        super(type);

        this._state = state;
    }

    /**
     * The session state.
     *
     * @public
     * @default null
     * @see ludia.sessionm.data.State
     */
    public function get state():String {
        return _state;
    }
}
}
