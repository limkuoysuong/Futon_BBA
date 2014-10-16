//
//  GameOverScene.h
//  FutonBBA
//
//  Created by Kheang Senghort on 5/6/14.
//  Copyright (c) 2014 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "resultBtn.h"
#import "mainGameViewController.h"
#import "startSceneViewController.h"
#import <Social/Social.h>
#import "mainGameScene.h"
//#import <UIKit/UIKit.h>
//#import <iAd/iAd.h>


@interface GameOverScene : SKScene <resultBtnDelegate, ADBannerViewDelegate>
{
    NSArray *myScore;
    
    ADBannerView* _adView;
    BOOL _bannerIsVisible;

}

@end