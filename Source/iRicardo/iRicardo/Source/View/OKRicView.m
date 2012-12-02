//
//  OKRicView.m
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 20/10/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import "OKRicView.h"

@implementation OKRicView

@synthesize avatarView;
@synthesize user;
@synthesize progress;
@synthesize nameLabel;
@synthesize tasksLabel;
@synthesize delegate;

-(id)initWithDelegate:(id<OKRicViewDelegate>)dlg onFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        user = [[OKUser alloc] initWithKey:OK_USER_KEY_RGIL];
        [user setDelegate:self];
        [self setDelegate:dlg];
        [self setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
        avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,80,80)];
        [avatarView setBackgroundColor:[UIColor grayColor]];
        [self addSubview:avatarView];
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90,5,frame.size.width-95,20)];
        [nameLabel setBackgroundColor:[UIColor lightGrayColor]];
        [nameLabel setText:[user name]];
        [self addSubview:nameLabel];
        
        tasksLabel = [[UILabel alloc] initWithFrame:CGRectMake(90,30,frame.size.width-95,20)];
        [tasksLabel setBackgroundColor:[UIColor lightGrayColor]];
        [tasksLabel setText:@"(0/5)"];
        [self addSubview:tasksLabel];
        
        progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        [progress setFrame:CGRectMake(90,60,frame.size.width-95,5)];
        [self addSubview:progress];
                
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
}

-(void)resetUser{
    [user resetUser];
    [tasksLabel setText:@"(0/5)"];
    [progress setProgress:0.0];
}

-(void)pauseUser:(NSNumber*)pause{
    [user pauseUser:pause];
}


#pragma mark OKUserDelegate methods

-(void)userStartedATask{
    [tasksLabel setText:[NSString stringWithFormat:@"(%d/5)",[user.pendingTasks count]]];
}

-(void)userAssignedToTask{
    [tasksLabel setText:[NSString stringWithFormat:@"(%d/5)",[user.pendingTasks count]]];
}

-(void)userEndedATask{
    if([user.pendingTasks count] == 0)
        [tasksLabel setText:@"(0/5)"];
}

-(void)userOverWork{
    NSLog(@"RICARDO IS IN OVERWORK MODE. THE GAME IS OVER!!!");
    [tasksLabel setText:@"(5/5)"];
    [delegate ricOverWorkAndGameOver];
}

-(void)userReady{
    //Do nothing
}

-(void)taskProgress:(CGFloat)prg{
    [progress setProgress:prg];
}


@end
