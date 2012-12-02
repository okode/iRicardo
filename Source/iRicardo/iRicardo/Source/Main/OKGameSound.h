//
//  OKGameSound.h
//  iRicardo
//
//  Created by Pedro Jorquera on 24/11/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKGameSound : NSObject

-(void)play:(NSString*)sound;
-(void)stop:(NSString*)sound;

-(void)pause;
-(void)resume;

@end
