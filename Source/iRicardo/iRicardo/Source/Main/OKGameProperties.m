//
//  OKGameProperties.m
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 20/10/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import "OKGameProperties.h"

#define ARC4RANDOM_MAX      0x100000000

@implementation OKGameProperties

+(NSDictionary*)adiazProperties{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Alex",OK_USER_PARAM_NAME,
            [NSNumber numberWithInt:OK_TASK_WEB],OK_USER_PARAM_SPECIALTY,nil];
}

+(NSDictionary*)aquerolProperties{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Alicia",OK_USER_PARAM_NAME,
            [NSNumber numberWithInt:OK_TASK_DESIGN],OK_USER_PARAM_SPECIALTY,nil];
}

+(NSDictionary*)dsoroProperties{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Dani",OK_USER_PARAM_NAME,
            [NSNumber numberWithInt:OK_TASK_IOS],OK_USER_PARAM_SPECIALTY,nil];
}

+(NSDictionary*)mponsProperties{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Marcos",OK_USER_PARAM_NAME,
            [NSNumber numberWithInt:OK_TASK_TCI],OK_USER_PARAM_SPECIALTY,nil];
}

+(NSDictionary*)pjorqueraProperties{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Pedro",OK_USER_PARAM_NAME,
            [NSNumber numberWithInt:OK_TASK_MEETING],OK_USER_PARAM_SPECIALTY,nil];
}

+(NSDictionary*)rgilProperties{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Ricardo",OK_USER_PARAM_NAME,
            [NSNumber numberWithInt:OK_TASK_WONT_FIX],OK_USER_PARAM_SPECIALTY,nil];
}

+(NSDictionary*)vquerolProperties{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Victor",OK_USER_PARAM_NAME,
            [NSNumber numberWithInt:OK_TASK_ANDROID],OK_USER_PARAM_SPECIALTY,nil];
}

+(NSDictionary*)userPropertiesByKey:(NSString*)key{
    if([key isEqualToString:OK_USER_KEY_AQUEROL]) return [OKGameProperties aquerolProperties];
    if([key isEqualToString:OK_USER_KEY_ADIAZ]) return [OKGameProperties adiazProperties];
    if([key isEqualToString:OK_USER_KEY_DSORO]) return [OKGameProperties dsoroProperties];
    if([key isEqualToString:OK_USER_KEY_MPONS]) return [OKGameProperties mponsProperties];
    if([key isEqualToString:OK_USER_KEY_PJORQUERA]) return [OKGameProperties pjorqueraProperties];
    if([key isEqualToString:OK_USER_KEY_RGIL]) return [OKGameProperties rgilProperties];
    if([key isEqualToString:OK_USER_KEY_VQUEROL]) return [OKGameProperties vquerolProperties];
    return nil;
}

+(NSString*)taskTypeName:(OKJiraType)type{
    switch (type) {
        case OK_TASK_ANDROID:   return @"ANDROID";
        case OK_TASK_DESIGN:    return @"DESIGN";
        case OK_TASK_IOS:       return @"IOS";
        case OK_TASK_MEETING:   return @"MEETING";
        case OK_TASK_TCI:       return @"TCI";
        case OK_TASK_WEB:       return @"WEB";
        case OK_TASK_WONT_FIX:  return @"WON'T FIX";
    }
}

+(NSInteger)getRandomWeightedTaskType{
    CGFloat totalWeights = 0.0;
    NSArray *weights = [NSArray arrayWithObjects:[NSNumber numberWithFloat:25],   //IOS
                        [NSNumber numberWithFloat:25],                            //ANDROID
                        [NSNumber numberWithFloat:25],                            //WEB
                        [NSNumber numberWithFloat:25],                            //DESIGN
                        [NSNumber numberWithFloat:25],                            //MEETING
                        [NSNumber numberWithFloat:25],                            //TCI
                        [NSNumber numberWithFloat:5],                            //WON'T FIX
                        nil];
    for(NSInteger index =0; index < [weights count]; index++){
        totalWeights += [[weights objectAtIndex:index] floatValue];
    }
    
    CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX)*totalWeights;
    totalWeights = 0.0;
    for(NSInteger i = 0; i < [weights count];i++){
        totalWeights += [[weights objectAtIndex:i] floatValue];
        if( random < totalWeights ) return i;
    }
    // if random num is exactly = weightsTotal
    return [weights count] - 1;
}


@end
