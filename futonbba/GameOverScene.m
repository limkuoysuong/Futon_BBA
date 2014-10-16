//
//  GameOverScene.m
//  FutonBBA
//
//  Created by Kheang Senghort on 5/6/14.
//  Copyright (c) 2014 Doi Daihei. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScore.h"

@implementation GameOverScene
{
    
    GameScore *gameScore;
    
    NSUserDefaults *defaults;
    
    int current;
    
}

-(id) initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
//        mainGameViewController* mgVC = [mainGameViewController sharedManager];
//        
//        [mgVC showsBanner];
        
        // Create object of GameScore
        gameScore = [[GameScore alloc] init];
        
        // Assign static currentScore method to variable current
        current = [GameScore currentScore];
        
        // Call method sortedScore
        [gameScore sortedScore:current];
        
        // Create object for NSUserDefaults
        defaults = [NSUserDefaults standardUserDefaults];
        
        // Declare variable with NSMutableArray
        NSMutableArray *getArrayScore = [NSMutableArray array];
        
        //NSLog(@"Hello current score %d", current);
        // Create loop for add score into NSMutableArray
        for (int i=0; i<5; i++)
        {
            // Call method getScore
            [getArrayScore addObject:[GameScore getScore:i]];
        }
        // Get value from variable getArrayScore into NSArray
        myScore = (NSArray *)getArrayScore;
        
        
        CGRect rect = [[UIScreen mainScreen] bounds];
        SKSpriteNode *background;
        
        if (rect.size.height == 480)
        {
            // //adding the background for 3.5 inch
            background = [SKSpriteNode spriteNodeWithImageNamed:@"bg_result_3_5inch.png"];
            background.size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
            //        background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
            background.position= CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
            [self addChild:background];
            
            // Add controll for iphone 3.5 inch
            [self addControllForiPhone3_5inch];
            
            // Add label current score
            SKLabelNode *labelCurrentScore = [self addLabelScore:CGPointMake(150, 365) tagName:@"labelCurrentScore" setScore:current];
            [labelCurrentScore setFontSize:20.f];
            [labelCurrentScore setText:[NSString stringWithFormat:@"Current: %d", current]];
            [self addChild:labelCurrentScore];
            
            // Add label score
            for (int j=0; j<5; j++)
            {
                SKLabelNode *labelScore = [self addLabelScore:CGPointMake(160, 330 -(j * 25)) tagName:@"labelScore" setScore:[[myScore objectAtIndex:j] intValue]];
                [self addChild:labelScore];
            }
            
            // Add number show to list 1 to 5
            for (int i=1; i<=5; i++) {
                SKLabelNode *labelNumber = [self addLabelScore:CGPointMake(125, 355 - (i * 25)) tagName:@"labelNumber" setScore:i];
                [labelNumber setText:[NSString stringWithFormat:@"%d.",i]];
                [self addChild:labelNumber];
            }
            
            // Add star rankLabel to SKLabelNode
            for (int k=0; k<5; k++) {
                resultBtn *labelRank;
                if (current == [[myScore objectAtIndex:k] integerValue])
                {
                    labelRank = [self addLabelRank:CGPointMake(95, 337 - (k * 25)) imageName:@"star_icon.png" getWidth:18 getHeight:18 tagName:@"labelRank"];
                    [self addChild:labelRank];
                    break;
                }
                else
                {
                    if (k == 4) labelRank.hidden = YES;
                }
            }
    
        }
        else
        {
            //adding the background for 4 inch
            background = [SKSpriteNode spriteNodeWithImageNamed:@"bg_result_4inch.png"];
            background.size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
            //        background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
            background.position= CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
            [self addChild:background];
            
            // Add controll for iphone 4 inch
            [self addControllForiPhone4inch];
            
            // Add label current score
            SKLabelNode *labelCurrentScore = [self addLabelScore:CGPointMake(150, 420) tagName:@"labelCurrentScore" setScore:current];
            [labelCurrentScore setFontSize:20.f];
            [labelCurrentScore setText:[NSString stringWithFormat:@"Current: %d", current]];
            [self addChild:labelCurrentScore];
            
            // Add score to SKLabelNode
            for (int j=0; j<5; j++)
            {
                SKLabelNode *labelScore = [self addLabelScore:CGPointMake(167, 380 - (j * 25)) tagName:@"labelScore" setScore:[[myScore objectAtIndex:j] intValue]];
                [self addChild:labelScore];
                
            }
            
            // Add number show to list 1 to 5
            for (int i=1; i<=5; i++) {
                SKLabelNode *labelNumber = [self addLabelScore:CGPointMake(120, 405 - (i * 25)) tagName:@"labelNumber" setScore:i];
                [labelNumber setText:[NSString stringWithFormat:@"%d.",i]];
                [self addChild:labelNumber];
            }
            
            // Add star rankLabel to SKLabelNode
            for (int k=0; k<5; k++) {
                resultBtn *labelRank;
                if (current == [[myScore objectAtIndex:k] integerValue])
                {
                    labelRank = [self addLabelRank:CGPointMake(103, 388 - (k * 25)) imageName:@"star_icon.png" getWidth:18 getHeight:18 tagName:@"labelRank"];
                    [self addChild:labelRank];
                    break;
                }
                else
                {
                    if (k == 4) labelRank.hidden = YES;
                }
            }
        }
    }
    return self;
}



- (void)resultBtn:(resultBtn *)rb {
    NSLog(@"すんで");
    mainGameViewController* mainVC = [mainGameViewController sharedManager];
    mainVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    
    if ([rb.name isEqualToString:@"buttonBack"]) {
        [self removeAllActions];
        [self removeAllChildren];
        mainGameScene* gameScene = [mainGameScene sharedManager];
        
        [gameScene removeAllActions];
        [gameScene removeAllChildren];
        [gameScene removeFromParent];
        [gameScene setDsArray:nil];
        [gameScene.view removeFromSuperview];
        gameScene.itemTextures = nil;
        gameScene = nil;
        
        self.view.window.rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:^{
           [mainVC.view removeFromSuperview];
            mainVC.view = nil;
        }];
        
    } else if ([rb.name isEqualToString:@"buttonFacebook"]){
        
        // Facebook投稿機能のインスタンスを作成する
        SLComposeViewController *slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        
        // 投稿するコンテンツを設定する
        // 表示する文字列
        if ([self isJapaneseLanguage]) {
            [slComposeViewController setInitialText:[NSString stringWithFormat:@"今回のスコアは\n%dやで!\nもっといい点\n取れるで?!!", current]];
            
        } else {
            [slComposeViewController setInitialText:[NSString stringWithFormat:@"My current score is \n%d points!\nCan you beat my score?!!", current]];
            
        }
        
        //        // URL
        //        [slComposeViewController addURL:[NSURL URLWithString:@"http://www.yoheim.net/"]];
        //        // 画像
        [slComposeViewController addImage:[UIImage imageNamed:@"iTunesArtwork.png"]];
        
        // 処理終了後に呼び出されるコールバックを指定する
        [slComposeViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case SLComposeViewControllerResultDone:
                    NSLog(@"Done!!");
                    break;
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Cancel!!");
            }
        }];
        
        // 表示する
        [mainVC presentViewController:slComposeViewController animated:YES completion:nil];
        
    } else if ([rb.name isEqualToString:@"buttonTwitter"]){
        SLComposeViewController *twitter = [[SLComposeViewController alloc]init];
        twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        if ([self isJapaneseLanguage]) {
            [twitter setInitialText:[NSString stringWithFormat:@"今回のスコアは\n%dやで!\nもっといい点\n取れるで?!!", current]];
        } else {
            [twitter setInitialText:[NSString stringWithFormat:@"My current score is \n%d points!\nCan you beat my score?!!", current]];
        }
        
        [twitter addImage:[UIImage imageNamed:@"iTunesArtwork.png"]];
        [twitter addURL:[NSURL URLWithString:@"http://www.yoheim.net/"]];
    //    [slComposeViewController addImage:[UIImage imageNamed:@"iTunesArtwork.png"]];
    
        [mainVC presentViewController:twitter animated:YES completion:NULL];
    }

}

- (BOOL)isJapaneseLanguage
{
    static BOOL isJapanese;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isJapanese = [currentLanguage isEqualToString:@"ja"];
    });
    return isJapanese;
}


// Create function add button into view controll
- (resultBtn *)addButton:(NSString *)imageName getWidth:(float)width getHeight:(float)height positionX:(float)floatX positionY:(float)floatY  tagName:(NSString *)tagNames
{
    
    resultBtn *button = [[resultBtn alloc] initWithImageNamed:imageName];
    button.size = CGSizeMake(width, height);
    button.position = CGPointMake(floatX, floatY);
    button.zPosition = 0.1f;
    button.name = tagNames;
    if (!button.userInteractionEnabled) {
        button.userInteractionEnabled = YES;
        button.delegate = self;

        NSLog(@"ボタンのタッチ操作オンやで");
    }
//    button.userInteractionEnabled = YES;
    return  button;
}

// Create function add label score and number into view controller
- (SKLabelNode *)addLabelScore:(CGPoint)point tagName:(NSString *)tagNames setScore:(int)score
{
    //Arial Rounded MT Bold
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    label.fontSize = 17;
    label.fontColor = [SKColor whiteColor];
    label.position = CGPointMake(point.x + 10, point.y);
    label.zPosition = 0.1f;
    label.name = tagNames;
    [label setText:[NSString stringWithFormat:@"%d", score]];
    return label;
}

// Create function add label rank into view controller
- (resultBtn *)addLabelRank:(CGPoint)point imageName:(NSString *)image getWidth:(float)width getHeight:(float)height tagName:(NSString *)tagNames
{
    resultBtn *label = [[resultBtn alloc] initWithImageNamed:image];
    label.size = CGSizeMake(width, height);
    label.position = CGPointMake(point.x, point.y);
    label.name = tagNames;
    
    return label;
}

- (void)addControllForiPhone3_5inch
{
    
    // Add all buttons
    // Call function add button back when load screen score
    [self addChild:[self addButton:@"button_result_back.png" getWidth:80 getHeight:40 positionX:60 positionY:90 tagName:@"buttonBack"]];
    
    // Call function add button facebook when load screen score
    [self addChild:[self addButton:@"button_result_facebook.png" getWidth:95 getHeight:55 positionX:159 positionY:98 tagName:@"buttonFacebook"]];
    
    // Call function add button twitter when load screen score
    [self addChild:[self addButton:@"button_result_twitter.png" getWidth:95 getHeight:55 positionX:255 positionY:98 tagName:@"buttonTwitter"]];
    
}

- (void)addControllForiPhone4inch
{
    
    // Add all buttons
    // Call function add button back when load screen score
    [self addChild:[self addButton:@"button_result_back.png" getWidth:80 getHeight:40 positionX:60 positionY:130 tagName:@"buttonBack"]];
    
    // Call function add button facebook when load screen score
    [self addChild:[self addButton:@"button_result_facebook.png" getWidth:95 getHeight:55 positionX:159 positionY:138 tagName:@"buttonFacebook"]];
    
    // Call function add button twitter when load screen score
    [self addChild:[self addButton:@"button_result_twitter.png" getWidth:95 getHeight:55 positionX:255 positionY:138 tagName:@"buttonTwitter"]];
}

@end
