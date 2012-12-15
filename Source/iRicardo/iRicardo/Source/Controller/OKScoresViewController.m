//
//  OKScoresViewController.m
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 02/12/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import "OKScoresViewController.h"
#import "OKGameProperties.h"
#import "OKAlertView.h"

@interface OKScoresViewController ()

@end

@implementation OKScoresViewController

@synthesize firstScoreName;
@synthesize firstScorePoints;
@synthesize secondScoreName;
@synthesize secondScorePoints;
@synthesize thirdScoreName;
@synthesize thirdScorePoints;
@synthesize fourthScoreName;
@synthesize fourthScorePoints;
@synthesize fifthScoreName;
@synthesize fifthScorePoints;

@synthesize removeScoresButton;
@synthesize goBackButton;


-(id)init{
    self = [super init];
    if(self){
        
        firstScoreName = [[UILabel alloc] initWithFrame:CGRectMake(20,120,80,20)];
        firstScorePoints = [[UILabel alloc] initWithFrame:CGRectMake(150,120,60,20)];
        secondScoreName = [[UILabel alloc] initWithFrame:CGRectMake(20,150,80,20)];
        secondScorePoints = [[UILabel alloc] initWithFrame:CGRectMake(150,150,60,20)];
        thirdScoreName = [[UILabel alloc] initWithFrame:CGRectMake(20,180,80,20)];
        thirdScorePoints = [[UILabel alloc] initWithFrame:CGRectMake(150,180,80,20)];
        fourthScoreName = [[UILabel alloc] initWithFrame:CGRectMake(20,210,80,20)];
        fourthScorePoints = [[UILabel alloc] initWithFrame:CGRectMake(150,210,80,20)];
        fifthScoreName = [[UILabel alloc] initWithFrame:CGRectMake(20,240,80,20)];
        fifthScorePoints = [[UILabel alloc] initWithFrame:CGRectMake(150,240,80,20)];
        
        removeScoresButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [removeScoresButton setFrame:CGRectMake(20,300,200,32)];
        [removeScoresButton setTitle:@"Remove High Scores" forState:UIControlStateNormal];
        [removeScoresButton addTarget:self action:@selector(removeScoresAlert) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:removeScoresButton];
        
        goBackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [goBackButton setFrame:CGRectMake(20,340,200,32)];
        [goBackButton setTitle:@"Return to Main" forState:UIControlStateNormal];
        [goBackButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:goBackButton];

        
        
        [self.view addSubview:firstScoreName];
        [self.view addSubview:firstScorePoints];
        [self.view addSubview:secondScoreName];
        [self.view addSubview:secondScorePoints];
        [self.view addSubview:thirdScoreName];
        [self.view addSubview:thirdScorePoints];
        [self.view addSubview:fourthScoreName];
        [self.view addSubview:fourthScorePoints];
        [self.view addSubview:fifthScoreName];
        [self.view addSubview:fifthScorePoints];
        
        [self setModalPresentationStyle:UIModalPresentationFullScreen];
        [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self populateHighScores];
}

-(void)populateHighScores{
    NSArray *scores = [OKGameProperties getHighScorePoints];
    NSArray *names = [OKGameProperties getHighScoreNames];
    
    firstScoreName.text = ([scores count] < 1)  ? @"1. ---" : [NSString stringWithFormat:@"1. %@:",[names objectAtIndex:0]];
    firstScorePoints.text = ([scores count] < 1)  ?  @"---" : [NSString stringWithFormat:@"%d points",[[scores objectAtIndex:0] intValue]];
    secondScoreName.text = ([scores count] < 2)  ? @"2. ---" : [NSString stringWithFormat:@"2. %@:",[names objectAtIndex:1]];
    secondScorePoints.text = ([scores count] < 2)  ?  @"---" : [NSString stringWithFormat:@"%d points",[[scores objectAtIndex:1] intValue]];
    thirdScoreName.text = ([scores count] < 3)  ? @"3. ---" : [NSString stringWithFormat:@"3. %@:",[names objectAtIndex:2]];
    thirdScorePoints.text = ([scores count] < 3)  ?  @"---" : [NSString stringWithFormat:@"%d points",[[scores objectAtIndex:2] intValue]];
    fourthScoreName.text = ([scores count] < 4)  ? @"4. ---" : [NSString stringWithFormat:@"4. %@:",[names objectAtIndex:3]];
    fourthScorePoints.text = ([scores count] < 4)  ?  @"---" : [NSString stringWithFormat:@"%d points",[[scores objectAtIndex:3] intValue]];
    fifthScoreName.text = ([scores count] < 5)  ? @"5. ---" : [NSString stringWithFormat:@"5. %@:",[names objectAtIndex:4]];
    fifthScorePoints.text = ([scores count] < 5)  ?  @"---" : [NSString stringWithFormat:@"%d points",[[scores objectAtIndex:4] intValue]];
}

-(void)removeScoresAlert{
    OKAlertView *alertView = [[OKAlertView alloc] initWithTitle:@"Remove scores" message:@"This will remove your high scores permanently. Are you sure to continue?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alertView show];
}


-(void)goBack{
    [self dismissModalViewControllerAnimated:YES];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [OKGameProperties removeHighScores];
        [self populateHighScores];
    }
}

@end
