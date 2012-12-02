//
//  OKMainMenuViewController.m
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 02/12/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import "OKMainMenuViewController.h"
#import "OKGameViewController.h"

@interface OKMainMenuViewController ()

@end

@implementation OKMainMenuViewController

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
        [self.view addSubview:howToButton];
        UIButton *highScoresButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [highScoresButton setTitle:@"High scores" forState:UIControlStateNormal];
        [highScoresButton setFrame:CGRectMake(40,200,240,32)];
        [self.view addSubview:highScoresButton];
        UIButton *aboutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [aboutButton setTitle:@"About iRicardo" forState:UIControlStateNormal];
        [aboutButton setFrame:CGRectMake(40,240,240,32)];
        [self.view addSubview:aboutButton];
    }
    return self;
}

-(void)startGame{
    OKGameViewController *gameViewController = [[OKGameViewController alloc] init];
    [self presentViewController:gameViewController animated:YES completion:nil];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
