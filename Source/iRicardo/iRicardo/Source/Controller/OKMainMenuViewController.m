//
//  OKMainMenuViewController.m
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 02/12/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import "OKMainMenuViewController.h"
#import <MediaPlayer/MediaPlayer.h>  

@interface OKMainMenuViewController ()

@end

@implementation OKMainMenuViewController

@synthesize gameController;
@synthesize scoresController;
@synthesize movieController;
@synthesize howtoController;

@synthesize moon;
@synthesize sound;
@synthesize introView;
@synthesize skipIntroButton;
@synthesize playingAnimation;

-(id)init{
    self = [super init];
    if (self) {
        playingAnimation = NO;
        
        UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [startButton setTitle:@"Start game" forState:UIControlStateNormal];
        [startButton setFrame:CGRectMake(40,177,240,32)];
        [startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
        [startButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        startButton.titleLabel.font = [UIFont systemFontOfSize:16];

        [self.view addSubview:startButton];
        UIButton *howToButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [howToButton setTitle:@"How to play" forState:UIControlStateNormal];
        [howToButton setFrame:CGRectMake(40,240,240,32)];
        [howToButton addTarget:self action:@selector(showHowTo) forControlEvents:UIControlEventTouchUpInside];
        [howToButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [howToButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        howToButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:howToButton];
        
        UIButton *highScoresButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [highScoresButton setTitle:@"High scores" forState:UIControlStateNormal];
        [highScoresButton setFrame:CGRectMake(40,303,240,32)];
        [highScoresButton addTarget:self action:@selector(showScores) forControlEvents:UIControlEventTouchUpInside];
        [highScoresButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [highScoresButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        highScoresButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:highScoresButton];
        
        UIButton *aboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [aboutButton setTitle:@"About iRicardo" forState:UIControlStateNormal];
        [aboutButton addTarget:self action:@selector(showAbout) forControlEvents:UIControlEventTouchUpInside];
        [aboutButton setFrame:CGRectMake(40,366,240,32)];
        [aboutButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [aboutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        aboutButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:aboutButton];
        
        [[UILabel appearanceWhenContainedIn:[UIButton class], nil] setShadowOffset:CGSizeMake(2.0, 2.0)];
        
        UIView *cutView = [[UIView alloc] initWithFrame:CGRectMake(16,16,290,126)];
        [cutView setBackgroundColor:[UIColor clearColor]];
        [cutView setClipsToBounds:YES];
        [self.view addSubview:cutView];
        
        moon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moon"]];
        [moon setFrame:CGRectMake(220,60,175,175)];
        [moon setContentMode:UIViewContentModeRedraw];
        [cutView addSubview:moon];

        UILabel * iRicardoTitle = [[UILabel alloc] initWithFrame:CGRectMake(23,40,300,50)];
        [iRicardoTitle setText:[NSString stringWithFormat:@"iRicardo"]];
        [iRicardoTitle setFont:[UIFont systemFontOfSize:40]];
        [iRicardoTitle setBackgroundColor:[UIColor clearColor]];
        [iRicardoTitle setTextColor:[UIColor whiteColor]];
        iRicardoTitle.shadowColor = [UIColor blackColor];
        iRicardoTitle.shadowOffset = CGSizeMake(0.0, 3.0);
        [self.view addSubview:iRicardoTitle];
        UILabel * subtitleTitle = [[UILabel alloc] initWithFrame:CGRectMake(23,85,300,26)];
        [subtitleTitle setText:[NSString stringWithFormat:@"Project Manager"]];
        [subtitleTitle setFont:[UIFont systemFontOfSize:18.4]];
        [subtitleTitle setBackgroundColor:[UIColor clearColor]];
        [subtitleTitle setTextColor:[UIColor orangeColor]];
        subtitleTitle.shadowColor = [UIColor blackColor];
        subtitleTitle.shadowOffset = CGSizeMake(0.0, 3.0);
        [self.view addSubview:subtitleTitle];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
        
    }
    return self;
}

-(void)startMoonAnimation{
    [UIView animateWithDuration:120 animations:^{
        if(!playingAnimation) return;
        [moon setFrame:CGRectMake(-150,-120,120,120)];
    } completion:^(BOOL finished) {
        if(finished){
            [moon setFrame:CGRectMake(260,110,175,175)];
            if(playingAnimation)
                [self startMoonAnimation];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
}

-(void)viewDidAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    if(gameController){
        [gameController removeGame];
        [self setGameController:nil];
    }
    if(sound == nil){
        sound = [[OKGameSound alloc] init];
        [sound play:OK_AUDIO_MENU];
        
    }
    playingAnimation = YES;
    [self startMoonAnimation];
}

-(void)viewDidDisappear:(BOOL)animated{
    playingAnimation = NO;
    [moon setFrame:CGRectMake(220,60,175,175)];
}

-(void)startGame{
    [sound stop:OK_AUDIO_MENU];
    
    gameController = [[OKGameViewController alloc] init];
    
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    
    introView = [[UIWebView alloc] init];
    introView.frame = CGRectMake(0, h, w, h);
    introView.scalesPageToFit = YES;
    introView.userInteractionEnabled = NO;
    [introView setOpaque:NO];
    [introView setBackgroundColor:[UIColor blackColor]];
    [introView.scrollView setBackgroundColor:[UIColor blackColor]];
    NSString* introResource = ([[UIScreen mainScreen] bounds].size.height == 568) ? @"starwars-iphone5" : @"starwars";
    [introView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:introResource ofType:@"html" inDirectory:@"intro/"]isDirectory:NO]]];
    [self.view addSubview:introView];
    
    [UIView animateWithDuration:0.44 animations:^{
        introView.frame = CGRectMake(0, 0, w, h);
    } completion:nil];
    
    skipIntroButton = [UIButton buttonWithType:UIButtonTypeCustom];
    skipIntroButton.frame = CGRectMake(0, 0, w, h);
    [skipIntroButton setTitle:@"" forState:UIControlStateNormal];
    [skipIntroButton addTarget:self action:@selector(introSkipped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipIntroButton];
    
    [sound play:OK_AUDIO_INTRO afterDelay:12.55];
}

-(void)introSkipped:(id)sender{
    [sound stop];
    sound = nil;
    
    [self presentViewController:gameController animated:YES completion:nil];
    
    [introView stopLoading];
    [introView removeFromSuperview];
    introView = nil;
    [skipIntroButton removeFromSuperview];
    skipIntroButton = nil;
}

-(void)showScores{
    if(scoresController== nil){
        scoresController = [[OKScoresViewController alloc] init];
    }
     [self presentViewController:scoresController animated:YES completion:nil];
}

-(void)pauseGame{
    if(gameController){
        [gameController pauseGame];
    }
}

-(void)showAbout{
    [sound stop:OK_AUDIO_MENU];
    sound = nil;
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Clip" ofType:@"mov"];
    NSURL *fileURL = [NSURL fileURLWithPath:filepath];
    movieController = [[OKMovieViewController alloc] initWithContentURL:fileURL];
    [self presentViewController:movieController animated:YES completion:nil];
}

-(void)showHowTo{
    if(howtoController == nil){
        howtoController = [[OKHowToViewController alloc] init];
    }
    [self presentViewController:howtoController animated:YES completion:nil];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

@end
