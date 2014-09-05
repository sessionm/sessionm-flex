package sessionm.flex.data {
/**
 * Stores the data associated with the user of the current session.
 */
public class User {
    /**
     * The user's claimed achievement points total.
     *
     * @private
     * @default <code>NaN</code>
     */
    private var _pointBalance:Number;
    /**
     * Represents whether the user has opted out of rewards.
     *
     * @private
     * @default <code>false</code>
     */
    private var _optedOut:Boolean;
    /**
     * The user's unclaimed achievement points total.
     *
     * @private
     * @default <code>Nan</code>
     */
    private var _unclaimedAchievementValue:Number;
    /**
     * The user's unclaimed achievements total.
     *
     * @private
     * @default <code>NaN</code>
     */
    private var _unclaimedAchievementCount:Number;

    /**
     * The <code>User</code> constructor.
     *
     * @public
     * @param source the JSON source used to initialize the <code>User</code>
     * instance.
     */
    public function User(source:Object) {
        this._pointBalance = Number(source.pointBalance);

        if (source.optedOut == "true") {
          this._optedOut = true;
        }
        else {
          this._optedOut = false;
        }

        this._unclaimedAchievementValue = Number(source.unclaimedAchievementValue);
        this._unclaimedAchievementCount = Number(source.unclaimedAchievementCount);
    }

    /**
     * The user's claimed achievement points total.
     *
     * @public
     * @default <code>NaN</code>
     */
    public function get pointBalance():Number {
        return _pointBalance;
    }

    /**
     * Represents whether the user has opted out of rewards.
     *
     * @public
     * @default <code>false</code>
     */
    public function get optedOut():Boolean {
        return _optedOut;
    }

    /**
     * Sets whether the user has opted out of rewards.
     *
     * @public
     * @param optOut the new opted-out status.
     */
    public function set optedOut(optOut:Boolean):void {
        _optedOut = optOut;
    }

    /**
     * The user's unclaimed achievement points total.
     *
     * @public
     * @default <code>NaN</code>
     */
    public function get unclaimedAchievementValue():Number {
        return _unclaimedAchievementValue;
    }

    /**
     * The user's unclaimed achievements total.
     *
     * @public
     * @default <code>NaN</code>
     */
    public function get unclaimedAchievementCount():Number {
        return _unclaimedAchievementCount;
    }


    /**
     * Converts the user data into a <code>String</code> representation.
     *
     * @public
     * @return the <code>String</code> representation of the user.
     */
    public function toString():String {
        return "User{pointBalance=" + String(pointBalance) + ",optedOut=" + String(optedOut) + ",unclaimedAchievementValue=" + String(unclaimedAchievementValue) + ",unclaimedAchievementCount=" + String(unclaimedAchievementCount) + "}";
    }
}
}
