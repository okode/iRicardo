//
//  OKHowToViewController.m
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 15/12/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import "OKHowToViewController.h"

@interface OKHowToViewController ()

@end

@implementation OKHowToViewController

@synthesize scrollView;
@synthesize howToImage;

-(id)init{
    self = [super init];
    if(self){
        scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [scrollView setBackgroundColor:[UIColor clearColor]];
        UIImage *img = [UIImage imageNamed:@"howto.png"];
        howToImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"howto.png"]];
        [scrollView setContentSize:img.size];
        [scrollView addSubview:howToImage];
        [scrollView setBounces:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        
        
        UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
        [close setBackgroundImage:[UIImage imageNamed:@"alert-button-normal.png"] forState:UIControlStateNormal];
        [close setFrame:CGRectMake((img.size.width-200)/2, img.size.height - 75,200, 44)];
        [close setTitle:@"CLOSE" forState:UIControlStateNormal];
        [close addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [close.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [scrollView addSubview:close];
        
        [self.view addSubview:scrollView];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [scrollView scrollRectToVisible:CGRectMake(0,0,scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
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

@end
