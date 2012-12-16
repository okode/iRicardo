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
@property (nonatomic, strong) NSMutableArray* pausedPlayers;
@property (nonatomic, assign) NSInteger indexAudioAssign;
-(void)appendSound:(NSString*)sound;
-(void)appendSound:(NSString*)sound key:(NSString*)key;
@end

@implementation OKGameSound

@synthesize players;
@synthesize pausedPlayers;
@synthesize indexAudioAssign;

- (id)init
{
    self = [super init];
    if (self) {
        players = [[NSMutableDictionary alloc] init];
        pausedPlayers = [[NSMutableArray alloc] init];
        [self appendSound:OK_AUDIO_MUSIC];
        indexAudioAssign = 1;
        [self appendSound:OK_AUDIO_ASSIGN_TASK key:[NSString stringWithFormat:@"%@%d", OK_AUDIO_ASSIGN_TASK, indexAudioAssign]];
        [self appendSound:OK_AUDIO_ASSIGN_TASK key:[NSString stringWithFormat:@"%@%d", OK_AUDIO_ASSIGN_TASK, indexAudioAssign + 1]];
        [self appendSound:OK_AUDIO_ASSIGN_TASK key:[NSString stringWithFormat:@"%@%d", OK_AUDIO_ASSIGN_TASK, indexAudioAssign + 2]];
        [self appendSound:OK_AUDIO_ASSIGN_FAILED];
        [self appendSound:OK_AUDIO_GAMEOVER];
        [self appendSound:OK_AUDIO_FANFARE];
        [self appendSound:OK_AUDIO_INTRO];
    }
    return self;
}

-(void)appendSound:(NSString*)sound
{
    [self appendSound:sound key:sound];
}

-(void)appendSound:(NSString*)sound key:(NSString*)key{
    [players setObject:[[AVAudioPlayer alloc] initWithContentsOfURL:[[NSBundle mainBundle]
                                                    URLForResource:sound
                                                     withExtension:@"mp3"]
                                                             error:NULL]
                forKey:key];
    [[players objectForKey:key] prepareToPlay];
}

-(void)play:(NSString*)sound
{
    if([sound isEqualToString:OK_AUDIO_ASSIGN_TASK]) {
        if((++indexAudioAssign > 3)) indexAudioAssign = 1;
        sound = [NSString stringWithFormat:@"%@%d", OK_AUDIO_ASSIGN_TASK, indexAudioAssign];
    }
    [(AVAudioPlayer*)[players objectForKey:sound] play];
}

-(void)play:(NSString*)sound afterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(play:) withObject:sound afterDelay:delay];
}

-(void)stop:(NSString *)sound
{
    AVAudioPlayer* player = (AVAudioPlayer*)[players objectForKey:sound];
    [pausedPlayers removeObject:player];
    [player stop];
}

-(void)pause
{
    for(NSString* sound in players) {
        AVAudioPlayer* player = (AVAudioPlayer*)[players objectForKey:sound];
        if([player isPlaying]) {
            [player pause];
            [pausedPlayers addObject:player];
        }
    }
}

-(void)stop
{
    for(NSString* sound in players) {
        AVAudioPlayer* player = (AVAudioPlayer*)[players objectForKey:sound];
        [player stop];
    }
    [pausedPlayers removeAllObjects];
}

-(void)resume
{
    for(AVAudioPlayer* player in pausedPlayers)
        [player play];
    [pausedPlayers removeAllObjects];
}

@end
