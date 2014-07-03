package ludia.sessionm.data {
public class User {

    private var _pointBalance:Number;
    private var _optedOut:Boolean;
    private var _unclaimedAchievementValue:Number;
    private var _unclaimedAchievementCount:Number;

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

    public function get pointBalance():Number {
        return _pointBalance;
    }

    public function get optedOut():Boolean {
        return _optedOut;
    }

    public function get unclaimedAchievementValue():Number {
        return _unclaimedAchievementValue;
    }

    public function get unclaimedAchievementCount():Number {
        return _unclaimedAchievementCount;
    }


    public function toString():String {
        return "User{pointBalance=" + String(pointBalance) + ",optedOut=" + String(optedOut) + ",unclaimedAchievementValue=" + String(unclaimedAchievementValue) + ",unclaimedAchievementCount=" + String(unclaimedAchievementCount) + "}";
    }
}
}
