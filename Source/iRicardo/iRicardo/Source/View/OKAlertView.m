//
//  OKAlertView.m
//  CustomWidget
//
//  Created by Daniel Soro Coicaud on 14/12/12.
//  Copyright (c) 2012 Okode. All rights reserved.
//

#import "OKAlertView.h"
#import <QuartzCore/QuartzCore.h>

@implementation OKAlertView

@synthesize customOkButton;
@synthesize cancelCustomButton;

-(id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:nil otherButtonTitles:nil];
    if(self){
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"alert-bg.png"]]];
        self.layer.borderColor = [[UIColor colorWithRed:0.1 green:0.1 blue:0.15 alpha:0.7] CGColor];
        self.layer.borderWidth = 5;
        
        customOkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [customOkButton setBackgroundImage:[UIImage imageNamed:@"alert-button-normal.png"] forState:UIControlStateNormal];
        [customOkButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [customOkButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:customOkButton];
        
        if(otherButtonTitles != nil){
            cancelCustomButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [cancelCustomButton setBackgroundImage:[UIImage imageNamed:@"alert-button-normal.png"] forState:UIControlStateNormal];
            [cancelCustomButton setTitle:otherButtonTitles forState:UIControlStateNormal];
            [cancelCustomButton addTarget:self action:@selector(okButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [customOkButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [cancelCustomButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
            [self addSubview:cancelCustomButton];
        }else{
            [customOkButton addTarget:self action:@selector(okButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    
    return self;

}


-(void)layoutSubviews{
    for (UIView *subview in self.subviews){ //Fast Enumeration
        if ([subview isMemberOfClass:[UIImageView class]]) {
            subview.hidden = YES;
            if(cancelCustomButton == nil)
                [customOkButton setFrame:CGRectMake((subview.frame.size.width-200)/2, subview.frame.size.height - 60,200, 44)];
            else{
                CGFloat xst = (subview.frame.size.width-260)/2;
                [customOkButton setFrame:CGRectMake(xst, subview.frame.size.height - 60,120, 44)];
                [cancelCustomButton setFrame:CGRectMake(subview.frame.size.width-120-xst, subview.frame.size.height - 60,120, 44)];
            }
        }
        if ([subview isMemberOfClass:[UILabel class]]) {
            UILabel *label = (UILabel*)subview;
            label.textColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
            label.shadowColor = [UIColor blackColor];
            label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        }
    }
}

-(void)setAlertViewStyle:(UIAlertViewStyle)alertViewStyle{
    [super setAlertViewStyle:alertViewStyle];
    UITextField *textField = [self textFieldAtIndex:0];
    [textField setTextAlignment:UITextAlignmentCenter];
    [textField setBorderStyle:UITextBorderStyleNone];
}

-(void)okButtonPressed{
    if(self.delegate){
        id<UIAlertViewDelegate>dlg = self.delegate;
        if([dlg respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
            [dlg alertView:self clickedButtonAtIndex:1];
    }
    [self dismissWithClickedButtonIndex:1 animated:YES];
}

-(void)cancelButtonPressed{
    if(self.delegate){
        id<UIAlertViewDelegate>dlg = self.delegate;
        if([dlg respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
            [dlg alertView:self clickedButtonAtIndex:0];
    }
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

@end
