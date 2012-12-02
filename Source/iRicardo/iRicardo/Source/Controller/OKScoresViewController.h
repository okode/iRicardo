//
//  OKScoresViewController.h
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 02/12/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKScoresViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) UILabel *firstScoreName;
@property (nonatomic, strong) UILabel *firstScorePoints;

@property (nonatomic, strong) UILabel *secondScoreName;
@property (nonatomic, strong) UILabel *secondScorePoints;

@property (nonatomic, strong) UILabel *thirdScoreName;
@property (nonatomic, strong) UILabel *thirdScorePoints;

@property (nonatomic, strong) UILabel *fourthScoreName;
@property (nonatomic, strong) UILabel *fourthScorePoints;

@property (nonatomic, strong) UILabel *fifthScoreName;
@property (nonatomic, strong) UILabel *fifthScorePoints;

@property (nonatomic, strong) UIButton *removeScoresButton;
@property (nonatomic, strong) UIButton *goBackButton;

@end
