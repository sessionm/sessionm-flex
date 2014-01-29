package ludia.sessionm.event {
import flash.events.Event;

public class SessionEvent extends Event {

    public static const SESSION_STATE_CHANGED:String = "sessionStateChanged";

    private var _state:String;

    public function SessionEvent(type:String, state:String) {
        super(type);

        this._state = state;
    }

    public function get state():String {
        return _state;
    }
}
}
