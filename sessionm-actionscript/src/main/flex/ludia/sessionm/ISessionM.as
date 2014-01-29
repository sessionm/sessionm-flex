package ludia.sessionm {
import flash.events.IEventDispatcher;

public interface ISessionM extends IEventDispatcher {
    function logAction(action:String):void;
    function presentActivity(type:String):void;
    function getSessionState():String;
    function startSession(appID:String):void;
}
}
