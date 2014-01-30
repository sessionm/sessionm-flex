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
        MAP_FUNCTION(presentActivity, NULL),
        MAP_FUNCTION(dismissActivity, NULL),
    };
    
    *numFunctionsToTest = sizeof(func) / sizeof(FRENamedFunction);
    *functionsToSet = func;
    
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
                SMStart([NSString stringWithUTF8String:(char *)token]);
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


ANE_FUNCTION(presentActivity)
{
    NSLog(@"Entering presentActivity()");
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
    
    FREObject* returnVal = malloc(sizeof(FREObject));
    
    if(FRE_OK == FRENewObjectFromBool(isSupported,returnVal))
    {
        return returnVal;
    }
    else
    {
        return NULL;
    }
}

