//
//  StartSceneViewController.m
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/7/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import "StartSceneViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface StartSceneViewController () <AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation StartSceneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self playBackgroundMusic];
    self.PopUpTutorialView.hidden = YES;
    self.closeButton.hidden = YES;
    self.nextButton.hidden = YES;
    self.tutorialView.hidden = YES;
    
    _adView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    _adView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), _adView.frame.size.width, _adView.frame.size.height);
    _adView.delegate = self;
    _adView.autoresizesSubviews = YES;
    _adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:_adView];
    _adView.alpha = 0.0;
    
    tCount = 0;
    
}


- (void) playBackgroundMusic{
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:@"backgroundMusic"
                                              ofType:@"mp3"];
    NSData *fileData=[NSData dataWithContentsOfFile:filePath]; NSError *error = nil;
    /* Start the audio player */
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData
                                                     error:&error];
    self.audioPlayer.numberOfLoops = -1;
    /* Did we get an instance of AVAudioPlayer? */
    if (self.audioPlayer != nil){
        /* Set the delegate and start playing */
        self.audioPlayer.delegate = self;
        if ([self.audioPlayer prepareToPlay] &&
            [self.audioPlayer play]){
            /* Successfully started playing */
            NSLog(@"Play success");
        }else{
            /* Failed to play */
            NSLog(@"Failed");
        } }else{
            /* Failed to instantiate AVAudioPlayer */
            NSLog(@"instance audio fail");
        }
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (!_bannerIsVisible) {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        [UIView setAnimationDuration:0.3];
        
        banner.frame = CGRectOffset(banner.frame, 0, -CGRectGetHeight(banner.frame));
        banner.alpha = 1.0;
        
        [UIView commitAnimations];
        _bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (_bannerIsVisible) {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        [UIView setAnimationDuration:0.3];
        
        banner.frame = CGRectOffset(banner.frame, 0, CGRectGetHeight(banner.frame));
        banner.alpha = 0.0;
        
        [UIView commitAnimations];
        _bannerIsVisible = NO;
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"Finished playing the song");
    /* The [flag] parameter tells us if the playback was successfully
     finished or not */
    if ([player isEqual:self.audioPlayer]){ self.audioPlayer = nil;
    }else{
        /* Which audio player is this? We certainly didn't allocate
         this instance! */
    }
}

- (IBAction)ScoreButton:(UIButton *)sender {
}

- (IBAction)TutorialButton:(UIButton *)sender {
    self.PopUpTutorialView.hidden = NO;
    [self popupView:_PopUpTutorialView];
    [self popupView:_closeButton];
    [self popupView:_nextButton];
    
    self.tutorialView.hidden = NO;
    self.closeButton.hidden = NO;
    self.nextButton.hidden = NO;
    self.tutorialButton.enabled = NO;
    self.scoreButton.enabled = NO;
    self.startButton.enabled = NO;
    
}

- (void)popupView:(UIView *)view
{
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5f,0.5f);
    
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2f,1.2f);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.1
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9f,0.9f);
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.2
                                                                    delay:0.0
                                                                  options:UIViewAnimationOptionCurveEaseOut
                                                               animations:^{
                                                                   view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0f,1.0f);
                                                               }
                                                               completion:nil
                                               ];
                                          }
                          ];
                     }
     ];
}

- (IBAction)NextButton:(UIButton *)sender {
    tCount++;
    if (tCount == 1) {
    _tutorialView.image = [UIImage imageNamed:@"tutorial02.png"];
    [_nextButton setImage:[UIImage imageNamed:@"button_tutorial_next.png"] forState:UIControlStateNormal];
    }
    else if (tCount == 2) {
    _tutorialView.image = [UIImage imageNamed:@"tutorial03.png"];
    }
    else if (tCount == 3) {
        _tutorialView.image = [UIImage imageNamed:@"tutorial04.png"];
        [_nextButton setImage:[UIImage imageNamed:@"button_tutorial_ok.png"] forState:UIControlStateNormal];
    }
    else if (tCount == 4) {
        self.startButton.enabled = YES;
        self.tutorialButton.enabled = YES;
        self.scoreButton.enabled = YES;
        self.PopUpTutorialView.hidden = YES;
        self.closeButton.hidden = YES;
        self.nextButton.hidden = YES;
        self.tutorialView.hidden = YES;
        tCount=0;
        _tutorialView.image = [UIImage imageNamed:@"tutorial01.png"];
         [_nextButton setImage:[UIImage imageNamed:@"button_tutorial_next.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)CloseButton:(UIButton *)sender {
    self.startButton.enabled = YES;
    self.tutorialButton.enabled = YES;
    self.scoreButton.enabled = YES;
    self.PopUpTutorialView.hidden = YES;
    self.closeButton.hidden = YES;
    self.nextButton.hidden = YES;
    self.tutorialView.hidden = YES;
    tCount=0;
    _tutorialView.image = [UIImage imageNamed:@"tutorial01.png"];
    [_nextButton setImage:[UIImage imageNamed:@"button_tutorial_next.png"] forState:UIControlStateNormal];
    }

- (IBAction)toSecond:(id)sender {
    [self performSegueWithIdentifier:@"toSecond" sender:self];
}
//- (IBAction)toScore:(id)sender {
//    [self performSegueWithIdentifier:@"scoreSegue" sender:self];
//
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"scoreSegue"]) {
//        
//    }
    
    if ([segue.identifier isEqualToString:@"toSecond"]) {
        
    }
}


@end
