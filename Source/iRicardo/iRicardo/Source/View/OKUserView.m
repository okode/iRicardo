//
//  OKUserView.m
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 20/10/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import "OKUserView.h"
#import "OKProgressView.h"

@implementation OKUserView

@synthesize avatarView;
@synthesize user;
@synthesize progress;
@synthesize nameLabel;
@synthesize tasksLabel;
@synthesize overworkView;
@synthesize delegate;

-(id)initWithDelegate:(id<OKUserViewDelegate>)dlg withUser:(OKUser*)kUser onFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setDelegate:dlg];
        [self setUser:kUser];
        [user setDelegate:self];
        //[self setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
        avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,80,80)];
        //[avatarView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.gif", [user key]]]];
        [self addSubview:avatarView];
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(92,8,frame.size.width-98,20)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [nameLabel setFont:[UIFont systemFontOfSize:8]];
        [nameLabel setText:[user name]];
        [self addSubview:nameLabel];
        
        tasksLabel = [[UILabel alloc] initWithFrame:CGRectMake(92,29,frame.size.width-98,20)];
        [tasksLabel setBackgroundColor:[UIColor clearColor]];
        [tasksLabel setTextColor:[UIColor whiteColor]];
        [tasksLabel setFont:[UIFont systemFontOfSize:8]];
        [tasksLabel setText:@"0 / 5"];
        [self addSubview:tasksLabel];
        
        progress = [[OKProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        [progress setFrame:CGRectMake(88,60,frame.size.width-98,20)];
        [self addSubview:progress];
        
        overworkView = [[UIView alloc] initWithFrame:CGRectMake(5,5,frame.size.width-14,frame.size.height-20)];
        [overworkView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.8]];
        [overworkView setAlpha:0.0];
        [self addSubview:overworkView];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
        [tapRecognizer setDelegate:self];
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

-(void)removeUser{
    [user removeUser];
    [self setDelegate:nil];
    [self setUser:nil];
    [avatarView removeFromSuperview];
    [progress removeFromSuperview];
    [nameLabel removeFromSuperview];
    [tasksLabel removeFromSuperview];
    [overworkView removeFromSuperview];
}

-(void)resetUser{
    [user resetUser];
    [tasksLabel setText:@"0/5"];
    [progress setProgress:0.0];
    [overworkView removeFromSuperview];
}

-(void)pauseUser:(NSNumber*)pause{
    [user pauseUser:pause];
}

-(void)tapRecognized:(id)sender{
    //NSLog(@"Tap recognized on user: %@",[user name]);
    [delegate userSelected:user inView:self];
}

-(void)showOverwork:(BOOL)show {
    CGFloat alpha = (show) ? 1.0 : 0.0;
    [overworkView setAlpha:alpha];
}


#pragma mark OKUserDelegate methods

-(void)userStartedATask{
    [tasksLabel setText:[NSString stringWithFormat:@"%d / %d",[user.pendingTasks count],OK_MAX_USER_TASKS]];
}

-(void)userAssignedToTask{
    [tasksLabel setText:[NSString stringWithFormat:@"%d / %d",[user.pendingTasks count],OK_MAX_USER_TASKS]];
}

-(void)userEndedATask{
    if([user.pendingTasks count] == 0)
        [tasksLabel setText:[NSString stringWithFormat:@"0 / %d",OK_MAX_USER_TASKS]];
}

-(void)userOverWork{
    [tasksLabel setText:[NSString stringWithFormat:@"%d / %d",OK_MAX_USER_TASKS,OK_MAX_USER_TASKS]];
    [self showOverwork:YES];
}

-(void)userReady{
    [self showOverwork:NO];
}

-(void)taskProgress:(CGFloat)prg{
    [progress setProgress:prg];
}

@end
