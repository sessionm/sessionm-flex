package ludia.sessionm {
import flash.events.IEventDispatcher;

import ludia.sessionm.data.Achievement;

import ludia.sessionm.data.User;

public interface ISessionM extends IEventDispatcher {
    function logAction(action:String):void;
    function presentActivity(type:String):void;
    function startSession(appID:String):void;
    function getUser():User;
    function getAchievement():Achievement;
    function isSupportedPlatform():Boolean;
}
}
