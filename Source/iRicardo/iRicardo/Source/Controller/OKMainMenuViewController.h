//
//  OKMainMenuViewController.h
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 02/12/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKGameViewController.h"
#import "OKScoresViewController.h"
#import "OKMovieViewController.h"
#import "OKHowToViewController.h"

@interface OKMainMenuViewController : UIViewController

-(void)pauseGame;

@property (nonatomic, strong) OKGameViewController *gameController;
@property (nonatomic, strong) OKScoresViewController *scoresController;
@property (nonatomic, strong) OKMovieViewController *movieController;
@property (nonatomic, strong) OKHowToViewController *howtoController;

@property (nonatomic, strong) UIWebView* introView;
@property (nonatomic, strong) UIButton* skipIntroButton;

@end
