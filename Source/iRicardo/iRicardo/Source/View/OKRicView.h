//
//  OKRicView.h
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 20/10/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKUser.h"

@protocol OKRicViewDelegate <NSObject>

-(void)ricOverWorkAndGameOver;

@end

@interface OKRicView : UIView <OKUserDelegate>

-(id)initWithDelegate:(id<OKRicViewDelegate>)dlg onFrame:(CGRect)frame;

@property (nonatomic, strong) id<OKRicViewDelegate> delegate;
@property (nonatomic, strong) OKUser *user;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIProgressView *progress;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *tasksLabel;

@end
