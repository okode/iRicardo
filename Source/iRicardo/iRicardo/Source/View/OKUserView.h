//
//  OKUserView.h
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 20/10/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OKUser.h"

@class OKUserView;

@protocol OKUserViewDelegate <NSObject>

-(void)userSelected:(OKUser*)user inView:(OKUserView*)view;

@end

@interface OKUserView : UIView <UIGestureRecognizerDelegate,OKUserDelegate>

-(id)initWithDelegate:(id<OKUserViewDelegate>)dlg withUser:(OKUser*)kUser onFrame:(CGRect)frame;
-(void)pauseUser:(NSNumber*)pause;
-(void)removeUser;
-(void)resetUser;

@property (nonatomic, strong) id<OKUserViewDelegate> delegate;
@property (nonatomic, strong) OKUser *user;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIProgressView *progress;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *tasksLabel;

@property (nonatomic, strong) UIView *overworkView;

@end
