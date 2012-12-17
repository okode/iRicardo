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

        [close setTitle:@"Return to Main" forState:UIControlStateNormal];
        [close setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [close setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        close.titleLabel.font = [UIFont systemFontOfSize:16];

        
        
        [close setFrame:CGRectMake((img.size.width-220)/2, img.size.height - 75,220, 44)];
        [close addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
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
