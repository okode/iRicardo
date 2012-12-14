//
//  OKProgressView.m
//  customWidgets
//
//  Created by Daniel Soro Coicaud on 13/12/12.
//  Copyright (c) 2012 Okode. All rights reserved.
//

#import "OKProgressView.h"

@implementation OKProgressView


-(void)drawRect:(CGRect)rect{
    
    UIImage *background = [[UIImage imageNamed:@"progress-bg.png"]
                           resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 4)];
    UIImage *fill = [[UIImage imageNamed:@"progress-fill.png"]
                     resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 4)];
    [background drawInRect:rect];
    NSInteger maxWidth = rect.size.width-4;
    NSInteger curWidth = floor([self progress] * maxWidth);
    CGRect fillRect = CGRectMake(rect.origin.x+2,
                                 rect.origin.y+2,
                                 curWidth,
                                 rect.size.height-4);
    [fill drawInRect:fillRect];
}


@end
