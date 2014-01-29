package ludia.sessionm.event {
import flash.events.Event;

import ludia.sessionm.data.Achievement;

public class AchievementEvent extends Event {

    public static const UNCLAIMED_ACHIEVEMENT:String = "unclaimedAchievement";

    private var _achievement:Achievement;

    public function AchievementEvent(type:String, achievement:Achievement) {
        super(type);

        this._achievement = achievement;
    }

    public function get achievement():Achievement {
        return _achievement;
    }
}
}
