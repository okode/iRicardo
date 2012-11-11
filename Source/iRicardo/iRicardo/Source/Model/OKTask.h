//
//  OKTask.h
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 20/10/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    OK_TASK_IOS,
    OK_TASK_ANDROID,
    OK_TASK_WEB,
    OK_TASK_DESIGN,
    OK_TASK_MEETING,
    OK_TASK_TCI,
    OK_TASK_WONT_FIX
} OKJiraType;

@interface OKTask : NSObject

-(id)initRandomTask;

@property (nonatomic, assign) OKJiraType type;

@end
