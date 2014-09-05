package sessionm.flex {
import flash.events.IEventDispatcher;

import sessionm.flex.data.Achievement;

import sessionm.flex.data.User;

/**
 * Provides access to the SessionM Adobe AIR native extension package's
 * functions to an ActionScript application (implemented by
 * <code>SessionM</code>).
 *
 * @see SessionM
 */
public interface ISessionM extends IEventDispatcher {
    function shouldDisplayRewardsBadge():Boolean;
    function shouldDisplayRewardsBadgeEx(testOptedOut:Boolean):Boolean;
    function logAction(action:String):void;
    function logDebug(msg:String):void;
    function initActivity(type:String):void;
    function initCustomActivity():void;
    function notifyDismissedAchievement(dismissType:String):void;
    function startSession(appID:String):void;
    function getUser():User;
    function setUserIsOptedOut(optedOut:Boolean):void;
    function getUnclaimedAchievement():Achievement;
    function isSupportedPlatform():Boolean;
    function getSDKVersion():String;
    function getExtensionVersion():String;
    function getPlatform():String;
}
}
