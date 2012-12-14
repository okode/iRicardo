//
//  OKGameSound.h
//  iRicardo
//
//  Created by Pedro Jorquera on 24/11/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKGameSound : NSObject

/**
 * Play selected sound
 */
-(void)play:(NSString*)sound;

/**
 * Stop selected sound if playing
 */
-(void)stop:(NSString*)sound;

/**
 * Stop all playing sounds
 */
-(void)stop;

/**
 * Pause all playing sounds
 */
-(void)pause;

/**
 * Resume all playing sounds
 */
-(void)resume;

@end
