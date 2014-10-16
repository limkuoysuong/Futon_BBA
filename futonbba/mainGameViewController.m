//
//  HelloWorldViewController.m
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/7/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import "mainGameViewController.h"
#import "mainGameScene.h"


@implementation mainGameViewController

static mainGameViewController* sharedMainGameViewController = nil;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Configure the view.
    SKView * skView = (SKView *)self.view;
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
    [skView setMultipleTouchEnabled:YES];
    
    // Create and configure the scene.
    SKScene * scene = [mainGameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
//    self.canDisplayBannerAds = YES;
    
    
//    _adView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
//    _adView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), _adView.frame.size.width, _adView.frame.size.height);
//    _adView.delegate = self;
//    _adView.autoresizesSubviews = YES;
//    _adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
//    [self.view addSubview:_adView];
//    _adView.alpha = 0.0;
//    
//    [self hidesBanner];
    
    // Present the scene.
    [skView presentScene:scene];
}

//- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
//    if (!self.bannerIsVisible) {
//        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
//        [UIView setAnimationDuration:0.3];
//        
//        banner.frame = CGRectOffset(banner.frame, 0, -CGRectGetHeight(banner.frame));
//        banner.alpha = 1.0;
//        
//        [UIView commitAnimations];
//        self.bannerIsVisible = YES;
//    }
//}
//
//- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
//{
//    if (self.bannerIsVisible) {
//        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
//        [UIView setAnimationDuration:0.3];
//        
//        banner.frame = CGRectOffset(banner.frame, 0, CGRectGetHeight(banner.frame));
//        banner.alpha = 0.0;
//        
//        [UIView commitAnimations];
//        self.bannerIsVisible = NO;
//    }
//}
//
//- (void)hidesBanner {
//    [_adView setAlpha:0];
//    self.bannerIsVisible = NO;
//}
//
//- (void)showsBanner {
//    [_adView setAlpha:1];
//    self.bannerIsVisible = YES;
//}

+ (mainGameViewController*)sharedManager {
	@synchronized(self) {
		if (sharedMainGameViewController == nil) {
			sharedMainGameViewController = [[self alloc] init];
		}
	}
	return sharedMainGameViewController;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedMainGameViewController == nil) {
			sharedMainGameViewController = [super allocWithZone:zone];
			return sharedMainGameViewController;
		}
	}
	return sharedMainGameViewController;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"backToStart"]) {
    }
}

@end
