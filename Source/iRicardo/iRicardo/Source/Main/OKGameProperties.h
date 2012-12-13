//
//  OKGameProperties.h
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 20/10/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OKTask.h"

#define OK_USER_KEY_ADIAZ           @"adiaz"
#define OK_USER_KEY_AQUEROL         @"aquerol"
#define OK_USER_KEY_DSORO           @"dsoro"
#define OK_USER_KEY_MPONS           @"mpons"
#define OK_USER_KEY_PJORQUERA       @"pjorquera"
#define OK_USER_KEY_RGIL            @"rgil"
#define OK_USER_KEY_VQUEROL         @"vquerol"

#define OK_USER_PARAM_NAME          @"name"
#define OK_USER_PARAM_SPECIALTY     @"specialty"

#define OK_AUDIO_MUSIC              @"music"
#define OK_AUDIO_ASSIGN_TASK        @"coin"
#define OK_AUDIO_ASSIGN_FAILED      @"breakblock"
#define OK_AUDIO_GAMEOVER           @"gameover"

#define RIC_SOLVING_TIME            30.0
#define OVERWORK_TIME               20.0
#define HARD_TASK_TIME              12.0
#define EASY_TASK_TIME              8.0
#define DEFAULT_ASSIGN_TASK_TIME    4.0
#define LEVEL_PERCENT_DECREASE      0.95
#define DEFAULT_MAX_POINTS          10.0
#define UP_LEVEL_POINTS             250.0

#define OK_COUNTDOWN_TIMER          0.01
#define OK_LOW_COUNTDOWN_TIMER      0.1

#define OK_MAX_USER_TASKS           5

#define OK_HIGH_SCORE_NAMES             @"highNames"
#define OK_HIGH_SCORE_POINTS            @"highPoints"

@interface OKGameProperties : NSObject

+(NSDictionary*)userPropertiesByKey:(NSString*)key;

+(NSDictionary*)adiazProperties;
+(NSDictionary*)aquerolProperties;
+(NSDictionary*)dsoroProperties;
+(NSDictionary*)mponsProperties;
+(NSDictionary*)pjorqueraProperties;
+(NSDictionary*)rgilProperties;
+(NSDictionary*)vquerolProperties;

+(NSInteger)getRandomWeightedTaskType;
+(NSString*)taskTypeName:(OKJiraType)type;

+(NSArray*)getHighScorePoints;
+(NSArray*)getHighScoreNames;
+(BOOL)isHighScore:(NSInteger)points;
+(void)saveHighScore:(NSInteger)points withName:(NSString*)name;
+(void)removeHighScores;

@end
