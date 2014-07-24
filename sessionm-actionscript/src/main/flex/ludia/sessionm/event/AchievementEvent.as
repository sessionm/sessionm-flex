package ludia.sessionm.event {
import flash.events.Event;

import ludia.sessionm.data.Achievement;

/**
 * Dispatched when the user has an unclaimed achievement that has not already
 * been presented.
 *
 * @see ludia.sessionm.data.Achievement
 */
public class AchievementEvent extends Event {
    /**
     * Defines the value of the <code>type</code> property for an
     * <code>unclaimedAchievement</code> event.
     *
     * @eventType unclaimedAchievement
     */
    public static const UNCLAIMED_ACHIEVEMENT:String = "unclaimedAchievement";

    /**
     * The unclaimed achievement.
     *
     * @private
     * @default null
     */
    private var _achievement:Achievement;

    /**
     * The <code>AchievementEvent</code> constructor.
     *
     * @public
     * @param type the event type.
     * @param achievement the unclaimed achievement.
     */
    public function AchievementEvent(type:String, achievement:Achievement) {
        super(type);

        this._achievement = achievement;
    }

    /**
     * The unclaimed achievement.
     *
     * @public
     * @default null
     * @see ludia.sessionm.data.Achievement
     */
    public function get achievement():Achievement {
        return _achievement;
    }
}
}
