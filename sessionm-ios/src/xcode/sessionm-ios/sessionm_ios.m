/*
 
 Copyright (c) 2012, DIVIJ KUMAR
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met: 
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer. 
 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution. 
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those
 of the authors and should not be interpreted as representing official policies, 
 either expressed or implied, of the FreeBSD Project.
 
 
 */

/*
 * sessionm_ios.m
 * sessionm-ios
 *
 * Created by Antoine Lassauzay on 1/30/2014.
 * Copyright (c) 2014 Ludia. All rights reserved.
 */

#import "sessionm_ios.h"
#import "SessionM.h"
#import "FlashRuntimeExtensions.h"
#import "CustomAchievementActivity.h"
#import <Foundation/Foundation.h>
#import <string.h>

FREContext context = nil;
CustomAchievementActivity *customActivity = nil;


/* sessionm-iosExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml 
 */
void SessionMExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    NSLog(@"Entering sessionm-iosExtInitializer()");

    *extDataToSet = NULL;
    *ctxInitializerToSet = &ContextInitializer;
    *ctxFinalizerToSet = &ContextFinalizer;

    NSLog(@"Exiting sessionm-iosExtInitializer()");
}

/* sessionm-iosExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml 
 */
void SessionMExtFinalizer(void* extData)
{
    NSLog(@"Entering sessionm-iosExtFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting sessionm-iosExtFinalizer()");
    return;
}

/* ContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
 */
void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    NSLog(@"Entering ContextInitializer()");
    
    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
     */
    static FRENamedFunction func[] = 
    {
        MAP_FUNCTION(startSession, NULL),
        MAP_FUNCTION(isSupportedPlatform, NULL),
        MAP_FUNCTION(logAction, NULL),
        MAP_FUNCTION(logDebug, NULL),
        MAP_FUNCTION(initActivity, NULL),
        MAP_FUNCTION(initCustomActivity, NULL),
        MAP_FUNCTION(notifyDismissedAchievement, NULL),
        MAP_FUNCTION(dismissActivity, NULL),
        MAP_FUNCTION(getSDKVersion, NULL),
        MAP_FUNCTION(getUser, NULL),
        MAP_FUNCTION(setUserIsOptedOut, NULL),
        MAP_FUNCTION(getUnclaimedAchievement, NULL)
    };
    
    *numFunctionsToTest = sizeof(func) / sizeof(FRENamedFunction);
    *functionsToSet = func;
    
    context = ctx;
    
    NSLog(@"Exiting ContextInitializer()");
}

/* ContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void ContextFinalizer(FREContext ctx) 
{
    NSLog(@"Entering ContextFinalizer()");

    NSLog(@"Exiting ContextFinalizer()");
    return;
}

@implementation SessionMHandler

{
    NSMutableDictionary *actionToStr;
}
- (id)init
{
    self = [super init];
    
    if(self) {
        actionToStr = [[NSMutableDictionary alloc] init];
        [actionToStr setObject:@"ACHIEVEMENT_VIEWED" forKey:[[NSNumber alloc] initWithInt:SMAchievementViewAction]];
        [actionToStr setObject:@"ACHIEVEMENT_DISMISSED" forKey:[[NSNumber alloc] initWithInt:SMAchievementDismissedAction]];
        [actionToStr setObject:@"ACHIEVEMENT_ENGAGED" forKey:[[NSNumber alloc] initWithInt:SMAchievementEngagedAction]];
        [actionToStr setObject:@"SPONSOR_CONTENT_VIEWED" forKey:[[NSNumber alloc] initWithInt:SMSponsorContentViewedAction]];
        [actionToStr setObject:@"SPONSOR_CONTENT_ENGAGED" forKey:[[NSNumber alloc] initWithInt:SMSponsorContentEngagedAction]];
        [actionToStr setObject:@"SPONSOR_CONTENT_DISMISSED" forKey:[[NSNumber alloc] initWithInt:SMSponsorContentDismissedAction]];
        [actionToStr setObject:@"PORTAL_VIEWED" forKey:[[NSNumber alloc] initWithInt:SMPortalViewedAction]];
        [actionToStr setObject:@"PORTAL_DISMISSED" forKey:[[NSNumber alloc] initWithInt:SMPortalDismissedAction]];
        [actionToStr setObject:@"SIGN_IN" forKey:[[NSNumber alloc] initWithInt:SMSignInAction]];
        [actionToStr setObject:@"SIGN_OUT" forKey:[[NSNumber alloc] initWithInt:SMSignOutAction]];
        [actionToStr setObject:@"REGISTERED" forKey:[[NSNumber alloc] initWithInt:SMRegisteredAction]];
        [actionToStr setObject:@"REDEEMED_REWARD" forKey:[[NSNumber alloc] initWithInt:SMRedeemedRewardAction]];
    }
    
    return self;
}

/*!
 @abstract Notifies about @link SessionM @/link state transition.
 @param sessionM SessionM service object.
 @param state SessionM state.
 */
- (void)sessionM:(SessionM *)sessionM didTransitionToState:(SessionMState)state
{
    NSLog(@"didTransitionToState %i", state);
    
    NSString *stateName;
    
    if(state == SessionMStateStopped) {
        stateName = @"STOPPED";
    }
    else if(state == SessionMStateStartedOnline) {
        stateName = @"STARTED_ONLINE";
        SessionM *instance = [SessionM sharedInstance];
        
        if(instance && instance.user)
        {
            dispatchUser(instance.user);
        }
        
        if(instance && instance.unclaimedAchievement)
        {
            dispatchAchievement(instance.unclaimedAchievement);
        }
    }
    else if(state == SessionMStateStartedOffline) {
        stateName = @"STARTED_OFFLINE";
    }
    
    NSString *eventName = @"SESSION_STATE_CHANGED";
    
    NSLog(@"Will dispatch %@:%@", eventName, stateName);
    
    int code = FREDispatchStatusEventAsync(context, (const uint8_t *)[eventName UTF8String], (const uint8_t *)[stateName UTF8String]);
    if(FRE_OK != code)
    {
        NSLog(@"Could not dispatch async event, code %i", code);
    }
}
/*!
 @abstract Notifies that @link SessionM @/link service is permanently unavailable.
 @discussion This method indicates permanent failure to start SessionM service. This can be the case when invalid application ID is supplied by the application or when SessionM service is not available in current device locale or
 session has been refused for security or other reasons. Application should use this method to remove or disable SessionM related UI elements.
 @param sessionM SessionM service object.
 @param error Error object.
 */
//- (void)sessionM:(SessionM *)sessionM didFailWithError:(NSError *)error;
/*!
 @abstract Indicates if newly earned achievement UI activity should be presented.
 @discussion This method is called when achievement is earned and will occur when application calls @link logAction: @/link or starts a session.
 By default, SessionM displays the achievement UI immediately after it is earned. Application can customize this behavior to defer the display until appropriate application state is reached.
 @param sessionM SessionM service object.
 @param achievement Achievement data object.
 @result Boolean indicating if achievement activity should be presented.
 */
- (BOOL)sessionM:(SessionM *)sessionM shouldAutopresentAchievement:(SMAchievementData *)achievement
{
    return YES;
}
/*!
 @abstract Returns UIView to use as a superview for SessionM view objects.
 @param sessionM SessionM service object.
 @param type Activity type.
 @result UIView object.
 */
//- (UIView *)sessionM:(SessionM *)session viewForActivity:(SMActivityType)type;
/*!
 @abstract Returns UIViewController to use as a presenting controller for SessionM view controller.
 @discussion This method is only called when application's root view controller is nil. In this case SessionM tries to determine appropriate view controller in the view hierarchy to use as a 'presenting controller'.
 This method provides a mechanism for the application to explicitely specify which view controller should be used in this case. It is recommended that application implement this method when root view controller is not set.
 Note, that UIViewController based presentation is only applicable for full screen activities, e.g. user portal.
 @param sessionM SessionM service object.
 @param type Activity type.
 @result UIViewController object.
 */
//- (UIViewController *)sessionM:(SessionM *)session viewControllerForActivity:(SMActivityType)type;
/*!
 @abstract Notifies that UI activity will be presented.
 @param sessionM SessionM service object.
 @param activity Activity object.
 */
//- (void)sessionM:(SessionM *)sessionM willPresentActivity:(SMActivity *)activity
/*!
 @abstract Notifies that UI activity was presented.
 @param sessionM SessionM service object.
 @param activity Activity object.
 */
- (void)sessionM:(SessionM *)sessionM didPresentActivity:(SMActivity *)activity
{
    NSString *eventName = @"ACTIVITY_PRESENTED";
    NSString *level = @"";
    
    NSLog(@"Will dispatch %@:%@", eventName, level);
    
    int code = FREDispatchStatusEventAsync(context, (const uint8_t *)[eventName UTF8String], (const uint8_t *)[level UTF8String]);
    if(FRE_OK != code)
    {
        NSLog(@"Could not dispatch async event, code %i", code);
    }
}
/*!
 @abstract Notifies that UI activity will be dismissed.
 @param sessionM SessionM service object.
 @param activity Activity object.
 */
//- (void)sessionM:(SessionM *)sessionM willDismissActivity:(SMActivity *)activity;
/*!
 @abstract Notifies that UI activity was dismissed.
 @param sessionM SessionM service object.
 @param activity Activity object.
 */
- (void)sessionM:(SessionM *)sessionM didDismissActivity:(SMActivity *)activity
{
    NSString *eventName = @"ACTIVITY_DISMISSED";
    NSString *level = @"";
    
    NSLog(@"Will dispatch %@:%@", eventName, level);
    
    int code = FREDispatchStatusEventAsync(context, (const uint8_t *)[eventName UTF8String], (const uint8_t *)[level UTF8String]);
    if(FRE_OK != code)
    {
        NSLog(@"Could not dispatch async event, code %i", code);
    }
}
/*!
 @abstract Notifies that user info was updated.
 @discussion User info is updated when earned achievement count, opt out status or other user relevant state changes.
 @param sessionM SessionM service object.
 @param user User object.
 */
- (void)sessionM:(SessionM *)sessionM didUpdateUser:(SMUser *)user
{
    dispatchUser(user);
}

/*!
 @abstract Notifies that media (typically video) will start playing.
 @discussion Application should use this method to suspend its own media playback if any.
 @param sessionM SessionM service object.
 @param activity Activity object.
 */
//- (void)sessionM:(SessionM *)sessionM willStartPlayingMediaForActivity:(SMActivity *)activity;
/*!
 @abstract Notifies that media (typically video) finished playing
 @discussion Application should use this method to resume its own media playback if any.
 @param sessionM SessionM service object.
 @param activity Activity object.
 */
//- (void)sessionM:(SessionM *)sessionM didFinishPlayingMediaForActivity:(SMActivity *)activity;
/*!
 @abstract Notifies that user performed an action in currently presented UI activity.
 @param sessionM SessionM service object.
 @param user User object.
 @param action User action type.
 @param activity Activity object.
 @param data NSDictionary object with action specific data.
 */

- (void)sessionM:(SessionM *)sessionM user:(SMUser *)user didPerformAction:(SMActivityUserAction)action forActivity:(SMActivity *)activity withData:(NSDictionary *)data
{
    NSString *userAction = [actionToStr objectForKey:[[NSNumber alloc] initWithInt:action]];
    
    if(!userAction)
    {
        userAction = @"OTHER";
    }
    
    NSString *eventName = @"USER_ACTION";
    
    NSError *jsonError = nil;
    
    NSLog(@"User action data : %@", [data allKeys]);
    
    NSString *achievementName = [data objectForKey:SMUserActionAchievementNameKey];
    NSString *pageName = [data objectForKey:SMUserActionPageNameKey];
    NSString *sponsorContentName = [data objectForKey:SMUserActionSponsorContentNameKey];
    NSString *rewardName = [data objectForKey:SMUserActionRewardNameKey];
    
    NSDictionary *dict = @{@"userAction": userAction,
                           @"achievementName": achievementName ? achievementName : @"null",
                           @"pageName": pageName ? pageName : @"null",
                           @"sponsorContentName": sponsorContentName ? sponsorContentName : @"null",
                           @"rewardName": rewardName ? rewardName : @"null",
                          };
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:(id)dict options:0 error:&jsonError];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Will dispatch %@:%@", eventName, jsonStr);
    
    int code = FREDispatchStatusEventAsync(context, (const uint8_t *)[eventName UTF8String], (const uint8_t *)[jsonStr UTF8String]);
    if(FRE_OK != code)
    {
        NSLog(@"Could not dispatch async event, code %i", code);
    }
}
/*!
 * @abstract Returns center point to use when presenting built-in achievement alert UIView.
 * @discussion Application can use this method to refine the positioning of achievement alert UIView. The default layout is specified in the developer portal as part of achievement configuration.
 * However, this method provides additional flexibility if application interface is dynamic and requires adjustments to alert positioning in order to ensure it does not cover important UI elements.
 * @param sessionM SessionM service object.
 * @param activity Activity object.
 * @param size Activity UIView size.
 * @result CGPoint UIView center.
 */
//- (CGPoint)sessionM:(SessionM *)sessionM centerForActivity:(SMActivity *)activity withSize:(CGSize)size;



/*!
 @abstract Deprecated. Notifies that UI activity is not available for presentation.
 @discussion This method is called in response to @link presentActivity: @/link call when activity of specified type cannot be presented.
 @param sessionM SessionM service object.
 @param type Activity type.
 @deprecated This method is deprecated. Use boolean value returned from @link presentActivity: @/link as an indicator if activity will be presented or not.
 */
- (void)sessionM:(SessionM *)sessionM activityUnavailable:(SMActivityType)type __attribute__((deprecated))
{
    NSString *eventName = @"ACTIVITY_UNAVAILABLE";
    NSString *level = @"";
    
    NSLog(@"Will dispatch %@:%@", eventName, level);
    
    int code = FREDispatchStatusEventAsync(context, (const uint8_t *)[eventName UTF8String], (const uint8_t *)[level UTF8String]);
    if(FRE_OK != code)
    {
        NSLog(@"Could not dispatch async event, code %i", code);
    }
}
/*!
 @abstract Deprecated. Notifies that unclaimed achievement is available or not, if nil, for presentation.
 @discussion This method should be used by application to customize an achievement presentation. SessionM service invokes this method when new achievement is earned or to notify about one of the previously earned
 unclaimed achievements. Achievement object supplied by this method is also available via SessionM @link unclaimedAchievement @/link property.
 This notification, in conjunction with @link unclaimedAchievement @/link property, allows application to present user achievements at convenient time during application lifecycle.
 @param sessionM SessionM service object.
 @param achievement Achievement data object or nil if no unclaimed achievement is available.
 @deprecated This method is deprecated. Use @link sessionM:shouldAutopresentAchievement: @/link to get notified about new achievements.
 */
- (void)sessionM:(SessionM *)sessionM didUpdateUnclaimedAchievement:(SMAchievementData *)achievement __attribute__((deprecated))
{
    dispatchAchievement(achievement);
}
/*!
 @abstract Deprecated. Indicates if newly earned achievement UI activity should be presented.
 @param sessionM SessionM service object.
 @param type Activity type.
 @result Boolean indicating if achievement activity should be presented.
 @deprecated This method is deprecated - use @link sessionM:shouldAutopresentAchievement: @/link instead.
 */
//- (BOOL)sessionM:(SessionM *)sessionM shouldAutopresentActivity:(SMActivityType)type __attribute__((deprecated));

@end

SessionMHandler *handler = NULL;

NSString* userToJSON(SMUser *user)
{
    NSDictionary *dict = @{
                           @"pointBalance": [[NSNumber alloc] initWithInteger:user.pointBalance],
                           @"optedOut": user.isOptedOut ? @"true" : @"false",
                           @"unclaimedAchievementValue": [[NSNumber alloc] initWithInteger:user.unclaimedAchievementValue],
                           @"unclaimedAchievementCount": [[NSNumber alloc] initWithInteger:user.unclaimedAchievementCount]
                           };
    NSError *jsonError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:(id)dict options:0 error:&jsonError];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

NSString* achievementToJSON(SMAchievementData *achievementData)
{
    NSDate *date = achievementData.lastEarnedDate;
    double time = date ? date.timeIntervalSince1970 : 0;
    
    NSDictionary *dict = @{
                           @"achievementIconURL": achievementData.achievementIconURL,
                           @"action": achievementData.action,
                           @"name": achievementData.name,
                           @"message": achievementData.message,
                           @"isCustom": achievementData.isCustom ? @"true" : @"false",
                           @"lastEarnedDate": [[NSNumber alloc] initWithDouble:time]
                           };
    
    NSError *jsonError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:(id)dict options:0 error:&jsonError];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

void dispatchUser(SMUser *user)
{
    NSString *jsonStr = userToJSON(user);
    
    NSString *eventName = @"USER_UPDATED";
    NSLog(@"Will dispatch %@:%@", eventName, jsonStr);
    
    int code = FREDispatchStatusEventAsync(context, (const uint8_t *)[eventName UTF8String], (const uint8_t *)[jsonStr UTF8String]);
    if(FRE_OK != code)
    {
        NSLog(@"Could not dispatch async event, code %i", code);
    }
}

void dispatchAchievement(SMAchievementData *achievementData)
{
    NSString *jsonStr = achievementToJSON(achievementData);
    
    NSString *eventName = @"UNCLAIMED_ACHIEVEMENT";
    NSLog(@"Will dispatch %@:%@", eventName, jsonStr);
    
    int code = FREDispatchStatusEventAsync(context, (const uint8_t *)[eventName UTF8String], (const uint8_t *)[jsonStr UTF8String]);
    if(FRE_OK != code)
    {
        NSLog(@"Could not dispatch async event, code %i", code);
    }
}

ANE_FUNCTION(startSession)
{
    NSLog(@"Entering startSession()");

    SessionM *instance = [SessionM sharedInstance];
    
    if(instance)
    {
        if(argc > 0)
        {
            uint32_t len;
            const uint8_t* token = 0;
            if(FRE_OK == FREGetObjectAsUTF8(argv[0], &len, &token))
            {
                NSLog(@"Received appID %s", token);
                handler = [[SessionMHandler alloc] init];
                instance.logLevel = SMLogLevelInfo;
                instance.logCategories = SMLogCategorySession;
                instance.delegate = handler;
                SMStart([NSString stringWithUTF8String:(char *)token]);
                NSLog(@"SMStart called");
            }
            else
            {
                NSLog(@"Error when reading appID");
            }
        }
        else
        {
            NSLog(@"Missing appID argument");
        }
    }
    else
    {
        NSLog(@"SessionM is not supported on this platform");
    }
    
	return NULL;
}


ANE_FUNCTION(logAction)
{
    NSLog(@"Entering logAction()");
    
    SessionM *instance = [SessionM sharedInstance];
    
    if(instance)
    {
        if(argc > 0)
        {
            uint32_t len;
            const uint8_t* token = 0;
            if(FRE_OK == FREGetObjectAsUTF8(argv[0], &len, &token))
            {
                NSLog(@"Received action name %s", token);
                SMAction([NSString stringWithUTF8String:(char *)token]);
            }
            else
            {
                NSLog(@"Error when reading action name");
            }
        }
        else
        {
            NSLog(@"Missing action name argument");
        }
    }
    else
    {
        NSLog(@"SessionM is not supported on this platform");
    }
    
	return NULL;
}

ANE_FUNCTION(logDebug)
{
    NSLog(@"Entering logDebug()");

    SessionM *instance = [SessionM sharedInstance];

    if(instance)
    {
        if(argc > 0)
        {
            uint32_t len;
            const uint8_t* token = 0;
            if(FRE_OK == FREGetObjectAsUTF8(argv[0], &len, &token))
            {
                NSLog(@"%s", token);
            }
            else
            {
                NSLog(@"Error when reading debug message");
            }
        }
        else
        {
            NSLog(@"Missing debug message argument");
        }
    }
    else
    {
        NSLog(@"SessionM is not supported on this platform");
    }

	return NULL;
}


ANE_FUNCTION(initActivity)
{
    NSLog(@"Entering initActivity()");
    SessionM *instance = [SessionM sharedInstance];

    if(instance)
    {
        if(argc > 0)
        {
            uint32_t len;
            const uint8_t* token = 0;
            if(FRE_OK == FREGetObjectAsUTF8(argv[0], &len, &token))
            {
                NSLog(@"Received activity type %s", token);
                NSString *type = [NSString stringWithUTF8String:(char *)token];
                
                // replace this switch/case or a dictionary
                if([type isEqualToString:@"ACHIEVEMENT"])
                {
                    [instance presentActivity:SMActivityTypeAchievement];
                }
                else if([type isEqualToString:@"PORTAL"])
                {
                    [instance presentActivity:SMActivityTypePortal];
                }
                else if([type isEqualToString:@"INTRODUCTION"])
                {
                    [instance presentActivity:SMActivityTypeIntroduction];
                }
                else
                {
                    NSLog(@"Invalid activity type %s", token);
                }
            }
            else
            {
                NSLog(@"Error when reading action name");
            }
        }
        else
        {
            NSLog(@"Missing action name argument");
        }
    }
    else
    {
        NSLog(@"SessionM is not supported on this platform");
    }
    
	return NULL;
}

ANE_FUNCTION(initCustomActivity)
{
    NSLog(@"Entering initCustomActivity()");
    SessionM *instance = [SessionM sharedInstance];
    
    if(instance)
    {
        NSLog(@"Presenting custom achievement");
        customActivity = [[CustomAchievementActivity alloc] initWithAchievmentData:instance.unclaimedAchievement];
        [customActivity performSelector:@selector(present)];
    }
    else
    {
        NSLog(@"SessionM is not supported on this platform");
    }
    
	return NULL;
}

ANE_FUNCTION(notifyDismissedAchievement)
{
    NSLog(@"Entering notifyDismissedAchievement()");
    SessionM *instance = [SessionM sharedInstance];
    
    if(instance)
    {
        if(argc > 0) {
            uint32_t len;
            const uint8_t* token = 0;
            
            if(FRE_OK == FREGetObjectAsUTF8(argv[0], &len, &token)) {
                NSLog(@"Received dismiss type %s", token);
                NSString *type = [NSString stringWithUTF8String:(char *)token];
                customActivity = [[CustomAchievementActivity alloc] initWithAchievmentData:instance.unclaimedAchievement];
                
                if([type isEqualToString:@"CANCELED"]) {
                    NSLog(@"Dismissing custom achievement");
                    [customActivity performSelector:@selector(dismiss)];
                }
                else if([type isEqualToString:@"CLAIMED"]) {
                    NSLog(@"Claiming custom achievement");
                    [customActivity performSelector:@selector(claim)];
                }
                else {
                    NSLog(@"Invalid dismiss type %s", token);
                    customActivity = nil;
                }
            }
            else {
                NSLog(@"Error when reading dismiss type");
            }
        }
        else {
            NSLog(@"Missing dismiss type argument");
        }
    }
    else
    {
        NSLog(@"SessionM is not supported on this platform");
    }
    
	return NULL;
}

ANE_FUNCTION(dismissActivity)
{
    SessionM *instance = [SessionM sharedInstance];
    if(instance)
    {
        [instance dismissActivity];
    }
    else
    {
        NSLog(@"SessionM is not supported on this platform");
    }
    
    return NULL;
}

ANE_FUNCTION(isSupportedPlatform)
{
    BOOL isSupported = [SessionM isSupportedPlatform];
    
    FREObject returnVal;
  
    if(FRE_OK == FRENewObjectFromBool(isSupported, &returnVal))
    {
        return returnVal;
    }
    else
    {
        return NULL;
    }
}

ANE_FUNCTION(getSDKVersion)
{
    const char* version = [__SESSIONM_SDK_VERSION__ UTF8String];

    FREObject returnVal;
    
    if(FRE_OK == FRENewObjectFromUTF8(strlen(version), (const uint8_t*)version, &returnVal))
    {
        return returnVal;
    }
    else
    {
        return NULL;
    }

}

ANE_FUNCTION(getUser)
{
    SessionM *instance = [SessionM sharedInstance];
    
    if(!instance)
    {
        NSLog(@"SessionM is not supported on this platform");
        return NULL;
    }
    
    if(!instance.user)
    {
        NSLog(@"SessionM instance has no user");
        return NULL;
    }
    
    
    NSString *jsonStr = userToJSON(instance.user);
    
    const char* version = [jsonStr UTF8String];
    FREObject returnVal;
    FREResult result = FRENewObjectFromUTF8(strlen(version), (const uint8_t*)version, &returnVal);
    
    if(FRE_OK == result)
    {
        return returnVal;
    }
    else
    {
        NSLog(@"Invalid FRE result code %i", result);
        return NULL;
    }
}

ANE_FUNCTION(setUserIsOptedOut)
{
    NSLog(@"Entering setUserIsOptedOut()");
    SessionM *instance = [SessionM sharedInstance];

    if(!instance)
    {
        NSLog(@"SessionM is not supported on this platform");
        return NULL;
    }

    if(!instance.user)
    {
        NSLog(@"SessionM instance has no user");
        return NULL;
    }

    if(argc > 0) {
        uint32_t optedOut = 0;

        if(FRE_OK == FREGetObjectAsBool(argv[0], &optedOut)) {
            NSLog(@"Received new opted-out status: %u", optedOut);
            instance.user.isOptedOut = optedOut;
        }
        else {
            NSLog(@"Error when reading new opted-out status");
        }
    }
    else {
        NSLog(@"Missing new opted-out status argument");
    }

    return NULL;
}

ANE_FUNCTION(getUnclaimedAchievement)
{
    SessionM *instance = [SessionM sharedInstance];
    
    if(!instance)
    {
        NSLog(@"SessionM is not supported on this platform");
        return NULL;
    }
    
    if(!instance.unclaimedAchievement)
    {
        NSLog(@"SessionM instance has no unclaimed achievement");
        return NULL;
    }
    
    NSString *jsonStr = achievementToJSON(instance.unclaimedAchievement);
   
    const char* version = [jsonStr UTF8String];
    FREObject returnVal;
    FREResult result = FRENewObjectFromUTF8(strlen(version), (const uint8_t*)version, &returnVal);
    
    if(FRE_OK == result)
    {
        return returnVal;
    }
    else
    {
        NSLog(@"Invalid FRE result code %i", result);
        return NULL;
    }
}
