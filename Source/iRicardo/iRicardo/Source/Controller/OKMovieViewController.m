//
//  OKMovieViewController.m
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 15/12/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import "OKMovieViewController.h"

@interface OKMovieViewController ()

@end

@implementation OKMovieViewController

-(id)initWithContentURL:(NSURL *)contentURL{
    self = [super initWithContentURL:contentURL];
    if(self){
        [self.moviePlayer setFullscreen:YES];
        [self.moviePlayer setShouldAutoplay:YES];
        [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self.moviePlayer setControlStyle:MPMovieControlStyleNone];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.moviePlayer prepareToPlay];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateChanged)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    
}

-(void) playbackStateChanged {
    NSLog(@"PlaybackStateChanged to: %d", self.moviePlayer.playbackState);
    if(self.moviePlayer.playbackState == MPMoviePlaybackStatePlaying){
        [self.moviePlayer setControlStyle:MPMovieControlStyleEmbedded];
    }    
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

@end
