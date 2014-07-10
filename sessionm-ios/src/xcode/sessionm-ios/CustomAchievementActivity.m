//
//  CustomAchievement.m
//  sessionm-ios
//
//  Created by Tristan Daniels on 7/7/14.
//
//

#import "CustomAchievementActivity.h"

@implementation CustomAchievementActivity

- (id)initWithAchievmentData:(SMAchievementData *)theData {
    if(self = [super initWithAchievmentData:theData]) {
    }
    return self;
}

- (void)present {
    if(self.data) {
        [super notifyPresented];
    }
    else {
        // This is here for testing purposes only to check negative case of extraneous claim notification
        self.isLastCallSuccessful = [super notifyPresented];
    }
}

- (void)dismiss {
    SessionM *sessionM = [SessionM sharedInstance];
    
    if(self.data) {
        [super notifyDismissed:SMAchievementDismissTypeClaimed];
    }
    else {
        [sessionM dismissActivity];
    }
}

- (void)claim {
    if(self.data) {
        [super notifyDismissed:SMAchievementDismissTypeClaimed];
    } else {
        // This is here for testing purposes only to check negative case of extraneous claim notification
        self.isLastCallSuccessful = [super notifyDismissed:SMAchievementDismissTypeClaimed];
    }
}

@end
