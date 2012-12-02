//
//  OKUser.h
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 20/10/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OKTask.h"
#import "OKGameProperties.h"

@protocol OKUserDelegate <NSObject>

-(void)userOverWork;
-(void)userReady;
-(void)userAssignedToTask;
-(void)userEndedATask;
-(void)userStartedATask;

-(void)taskProgress:(CGFloat)progress;

@end


@interface OKUser : NSObject

-(id)initWithKey:(NSString*)uKey;

-(BOOL)asignTask:(OKTask*)task;
-(void)pauseUser:(NSNumber*)pause;
-(void)removeUser;
-(void)resetUser;

@property (nonatomic, assign) id<OKUserDelegate>delegate;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) OKJiraType specialty;


@property (nonatomic, strong) NSMutableArray *pendingTasks;
@property (nonatomic, strong) OKTask *currentTask;
@property (nonatomic, assign) CGFloat taskProcess;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *overflowTime;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *progressTimer;
@property (nonatomic, assign) BOOL working;

@property (nonatomic, assign) BOOL overwork;
@property (nonatomic, assign) CGFloat overworkRemaining;

@property (nonatomic, assign) BOOL paused;
@property (nonatomic, strong) NSDate *pausedTime;

@end
