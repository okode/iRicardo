//
//  OKTask.m
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 20/10/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import "OKTask.h"
#import "OKGameProperties.h"

@implementation OKTask

@synthesize type;

-(id)initRandomTask{
    self = [super init];
    if(self){
        type = [OKGameProperties getRandomWeightedTaskType];
        //NSLog(@"Created task type: %@",[OKGameProperties taskTypeName:type]);
    }
    return self;
}

@end
