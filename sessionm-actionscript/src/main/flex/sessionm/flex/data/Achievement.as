package sessionm.flex.data {

/**
 * Stores the data associated with an achievement.
 */
public class Achievement {
    /**
     * The path to the achievement's icon.
     *
     * @private
     * @default <code>null</code>
     */
    private var _achievementIconURL:String;
    /**
     * The name of the action performed by the user to earn the achievement.
     *
     * @private
     * @default <code>null</code>
     */
    private var _action:String;
    /**
     * The message displayed when the achievement is earned.
     *
     * @private
     * @default <code>null</code>
     */
    private var _message:String;
    /**
     * The amount of mPoints earned when the achievement is claimed.
     *
     * @private
     * @default <code>NaN</code>
     */
    private var _mpointValue:Number;
    /**
     * The last date the achievement was earned.
     *
     * @private
     * @default <code>null</code>
     */
    private var _lastEarnedDate:Date;
    /**
     * Represents whether the achievement is a custom achievement.
     *
     * @private
     * @default <code>false</code>
     */
    private var _isCustom:Boolean;
    /**
     * The achievement's title (displayed when the achievement is earned).
     *
     * @private
     * @default <code>null</code>
     */
    private var _name:String;

    /**
     * The <code>Achievement</code> constructor.
     *
     * @public
     * @param source the JSON source used to initialize the
     * <code>Achievement</code> instance.
     */
    public function Achievement(source:Object) {
        this._achievementIconURL = String(source.achievementIconURL);
        this._action = String(source.action);
        this._message = String(source.message);
        this._mpointValue = Number(source.mpointValue)
        var timestamp:int = int(source.lastEarnedDate);
        if(timestamp > 0) {
            this._lastEarnedDate = new Date(timestamp);
        }
        this._isCustom = Boolean(source.isCustom);
        this._name = String(source.name);
    }

    /**
     * The path to the achievement's icon.
     *
     * @public
     * @default <code>null</code>
     */
    public function get achievementIconURL():String {
        return _achievementIconURL;
    }

    /**
     * The name of the action performed by the user to earn the achievement.
     *
     * @public
     * @default <code>null</code>
     */
    public function get action():String {
        return _action;
    }

    /**
     * The message displayed when the achievement is earned.
     *
     * @public
     * @default <code>null</code>
     */
    public function get message():String {
        return _message;
    }

    /**
     * The amount of mPoints earned when the achievement is claimed.
     *
     * @public
     * @default <code>NaN</code>
     */
    public function get mpointValue():Number {
        return _mpointValue;
    }

    /**
     * The last date the achievement was earned.
     *
     * @public
     * @default <code>null</code>
     */
    public function get lastEarnedDate():Date {
        return _lastEarnedDate;
    }

    /**
     * Represents whether the achievement is a custom achievement.
     *
     * @public
     * @default <code>false</code>
     */
    public function get isCustom():Boolean {
        return _isCustom;
    }

    /**
     * The achievement's title (displayed when the achievement is earned).
     *
     * @private
     * @default <code>null</code>
     */
    public function get name():String {
        return _name;
    }


    /**
     * Converts the achievement data into a <code>String</code> representation.
     *
     * @public
     * @return the <code>String</code> representation of the achievement.
     */
    public function toString():String {
        return "Achievement{achievementIconURL=" + String(achievementIconURL) + ",action=" + String(action) + ",message=" + String(message) + ",mpointValue=" + String(mpointValue) + ",lastEarnedDate=" + String(lastEarnedDate) + ",isCustom=" + String(isCustom) + ",name=" + String(name) + "}";
    }
}
}
