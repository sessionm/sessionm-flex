package ludia.sessionm.data {

public class Achievement {
    private var _achievementIconURL:String;
    private var _action:String;
    private var _message:String;
    private var _lastEarnedDate:Date;
    private var _isCustom:Boolean;
    private var _name:String;

    public function Achievement(source:Object) {
        this._achievementIconURL = String(source.achievementIconURL);
        this._action = String(source.action);
        this._message = String(source.message);
        this._lastEarnedDate = new Date(int(source.lastEarnedDate));
        this._isCustom = Boolean(source.isCustom);
        this._name = String(source.name);
    }

    public function get achievementIconURL():String {
        return _achievementIconURL;
    }

    public function get action():String {
        return _action;
    }

    public function get message():String {
        return _message;
    }

    public function get lastEarnedDate():Date {
        return _lastEarnedDate;
    }

    public function get isCustom():Boolean {
        return _isCustom;
    }

    public function get name():String {
        return _name;
    }


    public function toString():String {
        return "Achievement{achievementIconURL=" + String(achievementIconURL) + ",action=" + String(action) + ",message=" + String(message) + ",lastEarnedDate=" + String(lastEarnedDate) + ",isCustom=" + String(isCustom) + ",name=" + String(name) + "}";
    }
}
}
