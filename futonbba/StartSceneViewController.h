//
//  StartSceneViewController.h
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/7/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "mainGameViewController.h"

@interface StartSceneViewController : UIViewController <ADBannerViewDelegate>
{
    int tCount;
    ADBannerView* _adView;
    BOOL _bannerIsVisible;
}
- (IBAction)ScoreButton:(UIButton *)sender;
- (IBAction)TutorialButton:(UIButton *)sender;
- (IBAction)NextButton:(UIButton *)sender;
- (IBAction)CloseButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *PopUpTutorialView;
@property (weak, nonatomic) IBOutlet UIImageView *tutorialView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *tutorialButton;
@property (weak, nonatomic) IBOutlet UIButton *scoreButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;


////説明文のテキストを前もって作成。
//extern NSString* const listTutorialView[3];
//
@end


