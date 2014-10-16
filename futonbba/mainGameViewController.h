//
//  HelloWorldViewController.h
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/7/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "resultBtn.h"
#import "StartSceneViewController.h"
//#import <iAd/iAd.h>


@interface mainGameViewController : UIViewController <resultBtnDelegate, ADBannerViewDelegate> {
    
//    ADBannerView* _adView;
}

//@property (nonatomic) BOOL bannerIsVisible;



+ (mainGameViewController*)sharedManager;

- (void)hidesBanner;

- (void)showsBanner;

@end
