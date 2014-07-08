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
    NSAssert(self.data, @"Achievement data must be set before presenting");
    
    if(!self.alertView) {
        NSString *message = [NSString stringWithFormat:@"%@\n+%lu", self.data.message, (unsigned long)self.data.mpointValue];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:self.data.name message:message delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Claim", nil];
        self.alertView = alertView;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
        UIImage *image = [UIImage imageNamed:@"Reward.png"];
        imageView.backgroundColor = [UIColor blueColor];
        
        [imageView setImage:image];
        [alertView setValue:imageView forKey:@"accessoryView"];
        [alertView show];
    }
    else {
        // This is here for testing purposes only to check negative case of extraneous present notification
        self.isLastCallSuccessful = [super notifyPresented];
    }
}

- (void)dismiss {
    // If programmatically dismissing while custom alert is displayed - (1) notify super about dismissal and (2) clear the alert UI
    if(self.alertView) {
        [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
    }
    // If programmatically dismissing while claim UI is displayed - check that current activity if this activity and dismiss it using general SessionM API.
    else {
        SessionM *sessionM = [SessionM sharedInstance];
        if(sessionM.currentActivity == self) {
            [sessionM dismissActivity];
        }
    }
}

- (void)claim {
    [self dismiss];
}

#pragma mark -
#pragma UIAlertViewDelegate

- (void)didPresentAlertView:(UIAlertView *)alertView {
    self.isLastCallSuccessful = [super notifyPresented];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    self.alertView = nil;
    
    if(buttonIndex == 0) {
        [super notifyDismissed:SMAchievementDismissTypeCanceled];
    }
    else if(buttonIndex == 1) {
        [super notifyDismissed:SMAchievementDismissTypeCanceled];
    }
}

@end
