package ludia.sessionm.event {
import flash.events.Event;

import ludia.sessionm.data.User;

public class UserEvent  extends Event {

    public static const USER_UPDATED:String = "userUpdated";

    private var _user:User;

    public function UserEvent(type:String, user:User) {
        super(type);

        this._user = user;
    }

    public function get user():User {
        return _user;
    }
}
}
