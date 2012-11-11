//
//  OKUser.m
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 20/10/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import "OKUser.h"

@implementation OKUser

@synthesize delegate;
@synthesize key;
@synthesize name;
@synthesize pendingTasks;
@synthesize currentTask;
@synthesize taskProcess;
@synthesize overwork;
@synthesize specialty;
@synthesize overworkRemaining;
@synthesize startTime;
@synthesize timer;
@synthesize progressTimer;
@synthesize working;

-(id)initWithKey:(NSString*)uKey{
    self = [super init];
    if(self){
        [self setKey:uKey];
        NSDictionary *properties = [OKGameProperties userPropertiesByKey:key];
        name = [properties objectForKey:OK_USER_PARAM_NAME];
        specialty = [[properties objectForKey:OK_USER_PARAM_SPECIALTY] intValue];
        
        pendingTasks = 0;
        overwork = NO;
        working = NO;
        overworkRemaining = 0;
        
        pendingTasks = [[NSMutableArray alloc] initWithCapacity:OK_MAX_USER_TASKS];
    }
    return self;
}


-(BOOL)asignTask:(OKTask*)task{
    if([task type] == OK_TASK_WONT_FIX){
        if([pendingTasks count] > 1){
            [pendingTasks removeLastObject];
            NSLog(@"%@ got an %@ task. Removing his last pending task",name,[OKGameProperties taskTypeName:[task type]]);
        }else{
            NSLog(@"You waisted an %@ task on %@! Use those wisely!",[OKGameProperties taskTypeName:[task type]],name);
        }
        [delegate userAssignedToTask];
        return YES;
    }
    if([pendingTasks count] < (OK_MAX_USER_TASKS-1)){
        [pendingTasks addObject:task];
        NSLog(@"%@ added an %@ task to his pending tasks list",name,[OKGameProperties taskTypeName:[task type]]);
        [delegate userAssignedToTask];
        if(!working){
            [self startTasks];
        }
        return YES;
    }else if([pendingTasks count] == (OK_MAX_USER_TASKS-1)){
        [pendingTasks addObject:task];
        [self overWorkedUser];
        return YES;
    }else{
        [self overWorkedUser];
        return NO;
    }
}

-(void)overWorkedUser{
    if(timer)[timer invalidate];
    if(progressTimer) [progressTimer invalidate];
    [delegate taskProgress:0.0];
    
    NSLog(@"%@ is in overflow mode",name);
    NSTimeInterval interval = OVERWORK_TIME;
    timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                             target:self
                                           selector:@selector(overWorkEnded)
                                           userInfo:nil
                                            repeats:NO];
    overwork = YES;
    [delegate userOverWork];
}

-(void)startTasks{
    if(currentTask == nil)
        currentTask = [pendingTasks objectAtIndex:0];
    if(currentTask){
        NSLog(@"%@ started a %@ task",name,[OKGameProperties taskTypeName:[currentTask type]]);
        working = YES;
        [delegate userStartedATask];
        taskProcess = ([currentTask type] == [self specialty]) ? EASY_TASK_TIME : HARD_TASK_TIME;
        if([self specialty] == OK_TASK_WONT_FIX) taskProcess = RIC_SOLVING_TIME;
        startTime = [NSDate date];
        timer = [NSTimer scheduledTimerWithTimeInterval:taskProcess
                                                 target:self
                                               selector:@selector(endTask)
                                               userInfo:nil
                                                repeats:NO];
        progressTimer = [NSTimer scheduledTimerWithTimeInterval:OK_LOW_COUNTDOWN_TIMER
                                                         target:self
                                                       selector:@selector(taskProgress)
                                                       userInfo:nil
                                                        repeats:YES];
    }
}

-(void)taskProgress{
    [delegate taskProgress:(-[startTime timeIntervalSinceNow])/taskProcess];
}

-(void)endTask{
    NSLog(@"%@ ended a %@ task",name,[OKGameProperties taskTypeName:[currentTask type]]);
    [pendingTasks removeObject:currentTask];
    currentTask = nil;
    [timer invalidate];
    [progressTimer invalidate];
    [delegate taskProgress:0.0];
    if([pendingTasks count] > 0){
        [self startTasks];
    }else{
        working = NO;
    }
    [delegate userEndedATask];
}

-(void)overWorkEnded{
    NSLog(@"%@'s overflow mode ended",name);
    overwork = NO;
    [delegate userReady];
    if([pendingTasks count] > 0){
        [self startTasks];
    }
}

@end
