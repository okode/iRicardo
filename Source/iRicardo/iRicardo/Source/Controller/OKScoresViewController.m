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
        
        firstScoreName = [[UILabel alloc] initWithFrame:CGRectMake(40,162,145,20)];
        firstScorePoints = [[UILabel alloc] initWithFrame:CGRectMake(168,162,110,20)];
        secondScoreName = [[UILabel alloc] initWithFrame:CGRectMake(40,192,145,20)];
        secondScorePoints = [[UILabel alloc] initWithFrame:CGRectMake(168,192,110,20)];
        thirdScoreName = [[UILabel alloc] initWithFrame:CGRectMake(40,222,145,20)];
        thirdScorePoints = [[UILabel alloc] initWithFrame:CGRectMake(168,222,110,20)];
        fourthScoreName = [[UILabel alloc] initWithFrame:CGRectMake(40,252,145,20)];
        fourthScorePoints = [[UILabel alloc] initWithFrame:CGRectMake(168,252,110,20)];
        fifthScoreName = [[UILabel alloc] initWithFrame:CGRectMake(40,282,145,20)];
        fifthScorePoints = [[UILabel alloc] initWithFrame:CGRectMake(168,282,110,20)];
        
        [firstScoreName setTextColor:[UIColor whiteColor]];
        [firstScoreName setBackgroundColor:[UIColor clearColor]];
        [firstScoreName setFont:[UIFont systemFontOfSize:9]];
        
        [firstScorePoints setTextAlignment:NSTextAlignmentRight];
        [firstScorePoints setTextColor:[UIColor whiteColor]];
        [firstScorePoints setBackgroundColor:[UIColor clearColor]];
        [firstScorePoints setFont:[UIFont systemFontOfSize:9]];
        
        [secondScoreName setTextColor:[UIColor whiteColor]];
        [secondScoreName setBackgroundColor:[UIColor clearColor]];
        [secondScoreName setFont:[UIFont systemFontOfSize:9]];
        
        [secondScorePoints setTextAlignment:NSTextAlignmentRight];
        [secondScorePoints setTextColor:[UIColor whiteColor]];
        [secondScorePoints setBackgroundColor:[UIColor clearColor]];
        [secondScorePoints setFont:[UIFont systemFontOfSize:9]];
        
        [thirdScoreName setTextColor:[UIColor whiteColor]];
        [thirdScoreName setBackgroundColor:[UIColor clearColor]];
        [thirdScoreName setFont:[UIFont systemFontOfSize:9]];
        
        [thirdScorePoints setTextAlignment:NSTextAlignmentRight];
        [thirdScorePoints setTextColor:[UIColor whiteColor]];
        [thirdScorePoints setBackgroundColor:[UIColor clearColor]];
        [thirdScorePoints setFont:[UIFont systemFontOfSize:9]];

        [fourthScoreName setTextColor:[UIColor whiteColor]];
        [fourthScoreName setBackgroundColor:[UIColor clearColor]];
        [fourthScoreName setFont:[UIFont systemFontOfSize:9]];

        [fourthScorePoints setTextAlignment:NSTextAlignmentRight];
        [fourthScorePoints setTextColor:[UIColor whiteColor]];
        [fourthScorePoints setBackgroundColor:[UIColor clearColor]];
        [fourthScorePoints setFont:[UIFont systemFontOfSize:9]];

        [fifthScoreName setTextColor:[UIColor whiteColor]];
        [fifthScoreName setBackgroundColor:[UIColor clearColor]];
        [fifthScoreName setFont:[UIFont systemFontOfSize:9]];

        [fifthScorePoints setTextAlignment:NSTextAlignmentRight];
        [fifthScorePoints setTextColor:[UIColor whiteColor]];
        [fifthScorePoints setBackgroundColor:[UIColor clearColor]];
        [fifthScorePoints setFont:[UIFont systemFontOfSize:9]];

        
        removeScoresButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [removeScoresButton setFrame:CGRectMake(40,343,240,32)];
        [removeScoresButton setTitle:@"Remove Scores" forState:UIControlStateNormal];
        [removeScoresButton addTarget:self action:@selector(removeScoresAlert) forControlEvents:UIControlEventTouchUpInside];
        [removeScoresButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [removeScoresButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        removeScoresButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:removeScoresButton];
        
        goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [goBackButton setFrame:CGRectMake(40,406,240,32)];
        [goBackButton setTitle:@"Return to Main" forState:UIControlStateNormal];
        [goBackButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [goBackButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [goBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        goBackButton.titleLabel.font = [UIFont systemFontOfSize:16];
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
        UILabel * highScoresTitle = [[UILabel alloc] initWithFrame:CGRectMake(65,117,296,26)];
        [highScoresTitle setText:[NSString stringWithFormat:@"High Scores"]];
        [highScoresTitle setFont:[UIFont systemFontOfSize:18.4]];
        [highScoresTitle setBackgroundColor:[UIColor clearColor]];
        [highScoresTitle setTextColor:[UIColor lightGrayColor]];
        highScoresTitle.shadowColor = [UIColor blackColor];
        highScoresTitle.shadowOffset = CGSizeMake(0.0, 3.0);
        [self.view addSubview:highScoresTitle];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"scores_background.png"]]];
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
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [OKGameProperties removeHighScores];
        [self populateHighScores];
    }
}

@end
