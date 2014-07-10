//
//  CustomAchievement.h
//  sessionm-ios
//
//  Created by Tristan Daniels on 7/7/14.
//
//

#ifndef sessionm_ios_CustomAchievementActivity_h
#define sessionm_ios_CustomAchievementActivity_h

#import "SessionM.h"

@interface CustomAchievementActivity : SMAchievementActivity

@property(nonatomic) BOOL isLastCallSuccessful;

- (void)present;
- (void)claim;
- (void)dismiss;

@end

#endif
