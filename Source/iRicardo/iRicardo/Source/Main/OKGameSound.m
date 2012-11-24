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
@property (nonatomic, strong) NSMutableDictionary* players;
@property (nonatomic, assign) NSInteger indexAudioAssign;
-(void)appendSound:(NSString*)sound;
-(void)appendSound:(NSString*)sound key:(NSString*)key;
@end

@implementation OKGameSound

@synthesize players;
@synthesize indexAudioAssign;

- (id)init
{
    self = [super init];
    if (self) {
        players = [[NSMutableDictionary alloc] init];
        [self appendSound:OK_AUDIO_MUSIC];
        indexAudioAssign = 1;
        [self appendSound:OK_AUDIO_ASSIGN_TASK key:[NSString stringWithFormat:@"%@%d", OK_AUDIO_ASSIGN_TASK, indexAudioAssign]];
        [self appendSound:OK_AUDIO_ASSIGN_TASK key:[NSString stringWithFormat:@"%@%d", OK_AUDIO_ASSIGN_TASK, indexAudioAssign + 1]];
        [self appendSound:OK_AUDIO_ASSIGN_TASK key:[NSString stringWithFormat:@"%@%d", OK_AUDIO_ASSIGN_TASK, indexAudioAssign + 2]];
        [self appendSound:OK_AUDIO_GAMEOVER];
    }
    return self;
}

-(void)appendSound:(NSString*)sound
{
    [self appendSound:sound key:sound];
}

-(void)appendSound:(NSString*)sound key:(NSString*)key
{
    players[key] = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:sound
                                                                                        withExtension:@"mp3"]
                                                          error:NULL];
    [players[key] prepareToPlay];
}

-(void)play:(NSString *)sound
{
    if([sound isEqualToString:OK_AUDIO_ASSIGN_TASK]) {
        if((++indexAudioAssign > 3)) indexAudioAssign = 1;
        sound = [NSString stringWithFormat:@"%@%d", OK_AUDIO_ASSIGN_TASK, indexAudioAssign];
    }
    [(AVAudioPlayer*)players[sound] play];
}

-(void)stop:(NSString *)sound
{
    [(AVAudioPlayer*)players[sound] stop];
}

@end
