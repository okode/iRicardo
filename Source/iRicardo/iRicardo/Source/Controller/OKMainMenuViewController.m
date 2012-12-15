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

-(id)init{
    self = [super init];
    if (self) {
        UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [startButton setTitle:@"Start game" forState:UIControlStateNormal];
        [startButton setFrame:CGRectMake(40,120,240,32)];
        [startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:startButton];
        UIButton *howToButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [howToButton setTitle:@"How to play" forState:UIControlStateNormal];
        [howToButton setFrame:CGRectMake(40,160,240,32)];
        [howToButton addTarget:self action:@selector(showHowTo) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:howToButton];
        UIButton *highScoresButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [highScoresButton setTitle:@"High scores" forState:UIControlStateNormal];
        [highScoresButton setFrame:CGRectMake(40,200,240,32)];
        [highScoresButton addTarget:self action:@selector(showScores) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:highScoresButton];
        UIButton *aboutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [aboutButton setTitle:@"About iRicardo" forState:UIControlStateNormal];
        [aboutButton addTarget:self action:@selector(showAbout) forControlEvents:UIControlEventTouchUpInside];
        [aboutButton setFrame:CGRectMake(40,240,240,32)];
        [self.view addSubview:aboutButton];
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
