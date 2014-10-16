//
//  ViewController.m
//  scoreScreen at the front Game
//
//  Created by Lim Kuoy Suong on 5/7/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import "ViewController.h"
#import "GameScore.h"

@interface ViewController ()
{
    GameScore *gameScore;
    
    int currentScore;
    
    NSArray *myScore;
    
    NSUserDefaults *defaults;
    
    ADBannerView* _adView;
    BOOL _bannerIsVisible;
}

@property (strong, nonatomic) GameScore *game;
@end

@implementation ViewController

- (void)viewDidLoad
{
    // Create variable background
    UIImage *background;
    // Create variables labelScore and labelNumber
    UILabel *labelScore, *labelNumber;
    // Create object of GameScore
    gameScore = [[GameScore alloc] init];
    
    // Create object for NSUserDefaults
    defaults = [NSUserDefaults standardUserDefaults];
    
    // Declare variable with NSMutableArray
    NSMutableArray *getArrayScore = [NSMutableArray array];

    // Create loop for add score into NSMutableArray
    for (int i=0; i<5; i++)
    {
        // Call method getScore
        [getArrayScore addObject:[GameScore getScore:i]];
    }
    // Get value from variable getArrayScore into NSArray
    myScore = (NSArray *)getArrayScore;
    
    // Display for scree iphone 4-inch
    if ( [[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
        if ([[UIScreen mainScreen] scale] == 2.0){
            if ([UIScreen mainScreen].bounds.size.height == 568){
                background = [UIImage imageNamed:@"bg_score_4inch.png"];
                // Add image to background
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
                imageView.image = background;
                [self.view addSubview:imageView];
                
                // Add image to button back
                UIButton *button = [self addButton:440.0];
                [self.view addSubview:button];
                
                // Add label for score
                for (int j=0; j<5; j++) {
                    labelScore = [self addLabelScore:135 + (j * 30) setScore:[[myScore objectAtIndex:j] intValue]];
                    [self.view addSubview:labelScore];
                }
                
                // Add label for rank 1 to 5
                for (int k=1; k<=5; k++) {
                    labelNumber = [self addLabelRank: 105 + (k *30) setValue:k];
                    [labelNumber setText:[NSString stringWithFormat:@"%d.", k]];
                    [self.view addSubview:labelNumber];
                }
                
            }
            // Display for iphone 3.5-inch
            else{
                background = [UIImage imageNamed:@"bg_score_3_5inch.png"];
                // Add image to background
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
                imageView.image = background;
                [self.view addSubview:imageView];
                
                // Add image to button back
                UIButton *button = [self addButton:380.0];
                [self.view addSubview:button];
                
                // Add label to show score
                for (int j=0; j<5; j++) {
                    labelScore = [self addLabelScore:100 + (j * 30) setScore:[[myScore objectAtIndex:j] intValue]];
                    [self.view addSubview:labelScore];
                }
                
                // Add label for 1 to 5
                for (int k=1; k<=5; k++) {
                    labelNumber = [self addLabelRank: 70 + (k *30) setValue:k];
                    [labelNumber setText:[NSString stringWithFormat:@"%d.", k]];
                    [self.view addSubview:labelNumber];
                }
            }
        }
    }
    
    _adView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    _adView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), _adView.frame.size.width, _adView.frame.size.height);
    _adView.delegate = self;
    _adView.autoresizesSubviews = YES;
    _adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:_adView];
    _adView.alpha = 0.0;

    
    [super viewDidLoad];
    
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


// Function create label for score
- (UILabel *)addLabelScore:(int)pointY setScore:(int)score
{
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont fontWithName:@"Chalkduster" size:20.0f]];
    [label setText:[NSString stringWithFormat:@"%d", score]];
    [label setFrame:CGRectMake(135, pointY, 200, 25)];
    label.textColor = [UIColor whiteColor];
    return  label;
}

// Function create label for rank
- (UILabel *)addLabelRank:(int)pointY setValue:(int)value
{
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont fontWithName:@"Chalkduster" size:20.0f]];
    [label setText:[NSString stringWithFormat:@"%d", value]];
    [label setFrame:CGRectMake(100, pointY, 30, 25)];
    label.textColor = [UIColor whiteColor];
    return  label;

}

// Function create button
- (UIButton *)addButton:(float)pointY
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20.0, pointY, 80.0, 40.0);
    UIImage *buttonImage = [UIImage imageNamed:@"button_score_back.png"];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

// Function create action for button
- (void)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end