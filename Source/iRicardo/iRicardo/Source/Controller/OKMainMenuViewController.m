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

@synthesize introView;
@synthesize skipIntroButton;

-(id)init{
    self = [super init];
    if (self) {
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

        
        UILabel * iRicardoTitle = [[UILabel alloc] initWithFrame:CGRectMake(23,19,300,50)];
        [iRicardoTitle setText:[NSString stringWithFormat:@"iRicardo"]];
        [iRicardoTitle setFont:[UIFont systemFontOfSize:40]];
        [iRicardoTitle setBackgroundColor:[UIColor clearColor]];
        [iRicardoTitle setTextColor:[UIColor whiteColor]];
        iRicardoTitle.shadowColor = [UIColor blackColor];
        iRicardoTitle.shadowOffset = CGSizeMake(0.0, 3.0);
        [self.view addSubview:iRicardoTitle];
        UILabel * subtitleTitle = [[UILabel alloc] initWithFrame:CGRectMake(23,64,300,26)];
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

-(void)viewDidAppear:(BOOL)animated{
    if(gameController){
        [gameController removeGame];
        [self setGameController:nil];
    }
}

-(void)startGame{
    gameController = [[OKGameViewController alloc] init];
    for(UIView* subview in self.view.subviews) subview.userInteractionEnabled = NO;
    
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    
    introView = [[UIWebView alloc] init];
    introView.frame = CGRectMake(0, 0, w, h);
    introView.scalesPageToFit = YES;
    introView.userInteractionEnabled = NO;
    [introView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"starwars" ofType:@"html" inDirectory:@"intro/"]isDirectory:NO]]];
    [self.view addSubview:introView];
    
    skipIntroButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    skipIntroButton.frame = CGRectMake(w - 80, h - 40, 60, 30);
    [skipIntroButton setTitle:@"SKIP" forState:UIControlStateNormal];
    [skipIntroButton addTarget:self action:@selector(introSkipped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipIntroButton];
    
    [[gameController sound] play:OK_AUDIO_INTRO];
}

-(void)introSkipped:(id)sender
{
    for(UIView* subview in self.view.subviews) subview.userInteractionEnabled = YES;
    [[gameController sound] stop];
    [introView stopLoading];
    [introView removeFromSuperview];
    introView = nil;
    [skipIntroButton removeFromSuperview];
    skipIntroButton = nil;
    
    [self presentViewController:gameController animated:YES completion:nil];
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
