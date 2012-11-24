//
//  OKGameSound.m
//  iRicardo
//
//  Created by Pedro Jorquera on 24/11/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import "OKGameSound.h"
#import "OKGameProperties.h"
#import <AVFoundation/AVFoundation.h>

@interface OKGameSound ()
@property(nonatomic, strong) NSMutableDictionary* players;
-(void)appendSound:(NSString*)sound;
@end

@implementation OKGameSound

@synthesize players;

- (id)init
{
    self = [super init];
    if (self) {
        players = [[NSMutableDictionary alloc] init];
        [self appendSound:OK_AUDIO_MUSIC];
        [self appendSound:OK_AUDIO_ASSIGN_TASK];
        [self appendSound:OK_AUDIO_GAMEOVER];
    }
    return self;
}

-(void)appendSound:(NSString*)sound
{
    players[sound] = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:sound
                                                                                          withExtension:@"mp3"]
                                                            error:NULL];
    [players[sound] prepareToPlay];
}

-(void)play:(NSString *)sound
{
    [(AVAudioPlayer*)players[sound] play];
}

-(void)stop:(NSString *)sound
{
    [(AVAudioPlayer*)players[sound] stop];
}

@end
