//
//  OKGameViewController.h
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 20/10/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKGameProperties.h"
#import "OKTask.h"
#import "OKUser.h"
#import "OKUserView.h"
#import "OKRicView.h"

@interface OKGameViewController : UIViewController <OKUserViewDelegate, OKRicViewDelegate>

@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, assign) CGFloat assignTime;

@property (nonatomic, strong) UIView *currentTaskView;
@property (nonatomic, strong) UILabel *currentTaskLabel;

@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, assign) NSInteger level;

@property (nonatomic, strong) UILabel *pointsLabel;
@property (nonatomic, assign) NSInteger points;

@property (nonatomic, strong) NSTimer *gameTimer;

@property (nonatomic, strong) NSDate *taskCreatedTime;
@property (nonatomic, strong) OKRicView *ricView;
@property (nonatomic, strong) OKTask *assignTask;

@property (nonatomic, assign) BOOL gameOver;


@end