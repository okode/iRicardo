//
//  OKGameViewController.m
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 20/10/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import "OKGameViewController.h"
#import "OKUserView.h"
#import <QuartzCore/QuartzCore.h>

@interface OKGameViewController ()

@end

@implementation OKGameViewController

@synthesize timerLabel;
@synthesize assignTime;

@synthesize currentTaskView;
@synthesize currentTaskLabel;

@synthesize levelLabel;
@synthesize level;
@synthesize pointsLabel;
@synthesize points;
@synthesize ricView;

@synthesize gameTimer;
@synthesize assignTask;
@synthesize taskCreatedTime;

@synthesize gameOver;

@synthesize sound;

@synthesize pause;
@synthesize pauseView;
@synthesize pauseButton;

-(id)init{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [self loadUsers];
        pause = NO;
        
        timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2,0,self.view.frame.size.width/2,20)];
        [timerLabel setTextAlignment:UITextAlignmentCenter];
        [timerLabel setText:[NSString stringWithFormat:@"%.0f:000",DEFAULT_ASSIGN_TASK_TIME]];
        [self.view addSubview:timerLabel];
        levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2,20,self.view.frame.size.width/2,20)];
        [levelLabel setTextAlignment:UITextAlignmentCenter];
        [levelLabel setText:[NSString stringWithFormat:@"Level: %d",level]];
        [self.view addSubview:levelLabel];
        
        pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2,40,self.view.frame.size.width/2,20)];
        [pointsLabel setTextAlignment:UITextAlignmentCenter];
        [pointsLabel setText:[NSString stringWithFormat:@"Points: %d",points]];
        [self.view addSubview:pointsLabel];
        
        currentTaskView = [[UILabel alloc] initWithFrame:CGRectMake(200,60,80,80)];
        [currentTaskView setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
        [currentTaskView.layer setShadowColor:[[UIColor blackColor] CGColor]];
        [currentTaskView.layer setShadowOffset:CGSizeMake(1,2)];
        [currentTaskView.layer setShadowOpacity:0.8];
        
        currentTaskLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,30,70,20)];
        [currentTaskLabel setAdjustsFontSizeToFitWidth:YES];
        [currentTaskLabel setBackgroundColor:[UIColor clearColor]];
        [currentTaskLabel setTextAlignment:UITextAlignmentCenter];
        [currentTaskLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [currentTaskView addSubview:currentTaskLabel];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(currentTaskView.frame.size.width-20,0,20,20)];
        [imgView setImage:[UIImage imageNamed:@"jira.png"]];
        [currentTaskView addSubview:imgView];
        [self.view addSubview:currentTaskView];
        
        pauseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pauseButton setFrame:CGRectMake(2,110,60,35)];
        [pauseButton setTitle:@"PAUSE" forState:UIControlStateNormal];
        [pauseButton addTarget:self action:@selector(togglePause) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:pauseButton];
        
        assignTime = DEFAULT_ASSIGN_TASK_TIME;
        level = 0;
        gameOver = NO;
        
        sound = [[OKGameSound alloc] init];
    }
    return self;
}

-(void)loadUsers{
    OKUser *pjorquera = [[OKUser alloc] initWithKey:OK_USER_KEY_PJORQUERA];
    OKUser *aquerol = [[OKUser alloc] initWithKey:OK_USER_KEY_AQUEROL];
    OKUser *adiaz = [[OKUser alloc] initWithKey:OK_USER_KEY_ADIAZ];
    OKUser *dsoro = [[OKUser alloc] initWithKey:OK_USER_KEY_DSORO];
    OKUser *mpons = [[OKUser alloc] initWithKey:OK_USER_KEY_MPONS];
    OKUser *vquerol = [[OKUser alloc] initWithKey:OK_USER_KEY_VQUEROL];
    
    OKUserView *pjorqueraView = [[OKUserView alloc] initWithDelegate:self withUser:pjorquera onFrame:CGRectMake(0,160,self.view.frame.size.width/2,100)];
    OKUserView *aquerolView = [[OKUserView alloc] initWithDelegate:self withUser:aquerol onFrame:CGRectMake(self.view.frame.size.width/2,160,self.view.frame.size.width/2,100)];
    OKUserView *dsoroView = [[OKUserView alloc] initWithDelegate:self withUser:dsoro onFrame:CGRectMake(0,260,self.view.frame.size.width/2,100)];
    OKUserView *adiazView = [[OKUserView alloc] initWithDelegate:self withUser:adiaz onFrame:CGRectMake(self.view.frame.size.width/2,260,self.view.frame.size.width/2,100)];
    OKUserView *vquerolView = [[OKUserView alloc] initWithDelegate:self withUser:vquerol onFrame:CGRectMake(0,360,self.view.frame.size.width/2,100)];
    OKUserView *mponsView = [[OKUserView alloc] initWithDelegate:self withUser:mpons onFrame:CGRectMake(self.view.frame.size.width/2,360,self.view.frame.size.width/2,100)];
    
    ricView = [[OKRicView alloc] initWithDelegate:self onFrame:CGRectMake(0,5,self.view.frame.size.width/2,100)];
    
    [self.view addSubview:pjorqueraView];
    [self.view addSubview:aquerolView];
    [self.view addSubview:dsoroView];
    [self.view addSubview:adiazView];
    [self.view addSubview:vquerolView];
    [self.view addSubview:mponsView];
    
    [self.view addSubview:ricView];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self createTask];
    [self restartTimer];
    [sound play:OK_AUDIO_MUSIC];
}

-(void)togglePause{
    if(pauseView == nil){
        pauseView = [[UIView alloc] initWithFrame:self.view.bounds];
        [pauseView setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.75]];
        UILabel *pauseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height/4,self.view.bounds.size.width,self.view.bounds.size.height/4)];
        [pauseLabel setBackgroundColor:[UIColor clearColor]];
        [pauseLabel setText:@"Game Paused"];
        [pauseLabel setTextAlignment:UITextAlignmentCenter];
        [pauseLabel setFont:[UIFont boldSystemFontOfSize:40]];
        [pauseLabel setTextColor:[UIColor colorWithWhite:0.7 alpha:1]];
        [pauseLabel setShadowOffset:CGSizeMake(1,1)];
        [pauseLabel setShadowColor:[UIColor colorWithWhite:0.3 alpha:0.7]];
        [pauseView addSubview:pauseLabel];
        
        UILabel *pauseClickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height/2,self.view.bounds.size.width,self.view.bounds.size.height/4)];
        [pauseClickLabel setBackgroundColor:[UIColor clearColor]];
        [pauseClickLabel setText:@"(Press anywhere to continue)"];
        [pauseClickLabel setTextAlignment:UITextAlignmentCenter];
        [pauseClickLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [pauseClickLabel setNumberOfLines:0];
        [pauseClickLabel setTextColor:[UIColor colorWithWhite:0.6 alpha:1]];
        [pauseClickLabel setShadowOffset:CGSizeMake(1,1)];
        [pauseClickLabel setShadowColor:[UIColor colorWithWhite:0.3 alpha:0.7]];
        [pauseView addSubview:pauseClickLabel];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(togglePause)];
        [pauseView addGestureRecognizer:tapRecognizer];
    }
    if(!pause){
        [self.view addSubview:pauseView];
        pause = YES;
    }else{
        [pauseView removeFromSuperview];
        pause = NO;
    }
}

-(void)createTask{
    if(gameOver) return;
    assignTask = [[OKTask alloc] initRandomTask];
    [currentTaskLabel setText:[OKGameProperties taskTypeName:[assignTask type]]];
}

-(void)restartTimer{
    if(gameOver) return;
    assignTime = DEFAULT_ASSIGN_TASK_TIME*pow(LEVEL_PERCENT_DECREASE,level);
    NSTimeInterval interval = OK_COUNTDOWN_TIMER;
    taskCreatedTime = [NSDate date];
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                 target:self
                                               selector:@selector(updateTimer)
                                               userInfo:nil
                                                repeats:YES];
}

-(void)updateTimer{
    if(gameOver || pause) return;
    assignTime -= OK_COUNTDOWN_TIMER;
    if(assignTime < 0.0){
        [gameTimer invalidate];
        assignTime = 0.0;
        //Assign task to RicView!
        [sound play:OK_AUDIO_ASSIGN_FAILED];
        [ricView.user asignTask:assignTask];
        [UIView animateWithDuration:0.2 animations:^(void){
            [currentTaskView setCenter:ricView.center];
        } completion:^(BOOL finished) {
            [currentTaskView setFrame:CGRectMake(200,60,80,80)];
            [self createTask];
            [self restartTimer];
        }];
    }
    NSInteger seconds = floor(assignTime);
    CGFloat milis = (assignTime-seconds)*100;
    NSString *milisString;
    if(milis >= 10) milisString = [NSString stringWithFormat:@"%.0f",milis];
    else milisString = [NSString stringWithFormat:@"0%.0f",milis];
    [timerLabel setText:[NSString stringWithFormat:@"%d:%@",seconds,milisString]];
}

#pragma mark - OKUserViewDelegate methods

-(void)userSelected:(OKUser*)user inView:(OKUserView*)view{
    if(gameOver) return;
    BOOL assignedTask = [user asignTask:assignTask];
    if(assignedTask){
        [gameTimer invalidate];
        [sound play:OK_AUDIO_ASSIGN_TASK];
        CGFloat assignPoints = (assignTime/DEFAULT_ASSIGN_TASK_TIME*pow(LEVEL_PERCENT_DECREASE,level))*DEFAULT_MAX_POINTS;
        points += floor(assignPoints);
        [pointsLabel setText:[NSString stringWithFormat:@"Points: %d",points]];
        level = floor(points/UP_LEVEL_POINTS);
        [levelLabel setText:[NSString stringWithFormat:@"Level: %d",level]];
        
        [UIView animateWithDuration:0.2 animations:^(void){
            [currentTaskView setCenter:view.center];
        } completion:^(BOOL finished) {
            [currentTaskView setFrame:CGRectMake(200,60,80,80)];
            [self createTask];
            [self restartTimer];
        }];
    }
}

#pragma mark - RicUserViewDelegate methods

-(void)ricOverWorkAndGameOver{
    gameOver = YES;
    [gameTimer invalidate];

    UILabel *gameOverLabel = [[UILabel alloc] initWithFrame:self.view.frame];
    [gameOverLabel setBackgroundColor:[UIColor clearColor]];
    [gameOverLabel setText:@"GAME OVER"];
    [gameOverLabel setTextAlignment:UITextAlignmentCenter];
    [gameOverLabel setFont:[UIFont boldSystemFontOfSize:50]];
    [gameOverLabel setTextColor:[UIColor redColor]];
    [gameOverLabel setShadowOffset:CGSizeMake(1,1)];
    [gameOverLabel setShadowColor:[UIColor colorWithWhite:0.0 alpha:0.7]];
    [self.view addSubview:gameOverLabel];
    
    [sound stop:OK_AUDIO_MUSIC];
    [sound play:OK_AUDIO_GAMEOVER];
}

@end
