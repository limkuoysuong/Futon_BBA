//
//  HelloWorldMyScene.m
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/7/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import "mainGameScene.h"
#import "GameOverScene.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "GameScore.h"

#define ARC4RANDOM_MAX 0x100000000

@interface mainGameScene () <AVAudioPlayerDelegate>{
    
    BOOL dropAnimation;
    
    SKSpriteNode* futon;
    
    int _point;
    //int _pointINS;
    int _challenge;
    
    CGPoint futonPos;
    CGPoint midPos;
    
    int dropCount;
    
    BOOL finish;
    BOOL touchSecondTime;
    int coinMax;
    
    SKSpriteNode* gauge;
    SKSpriteNode* scoreBar;
    SKSpriteNode* challengeBar;
    SKSpriteNode* powerGaugeCoverSprite;
    SKSpriteNode* BBACharacterSprite;
    SKSpriteNode* gameoverSprite;
    
    SKSpriteNode* BBACharacterSpriteHit;
    SKTexture *BBACharacterHit;
    
    NSArray* dsArray;
    
    int power;
    
    dispatch_once_t lastUpdatedAtInitToken;
    
    CFTimeInterval lastUpdatedAt;
    
    float update;
    float update2;
    BOOL isFirstTouch;
    
    GameScore *gameScore;
}

@property (weak, nonatomic)SKLabelNode* pointLabel;
@property (nonatomic) int point;

@property (weak, nonatomic)SKLabelNode* challengeLabel;

@property (weak, nonatomic)SKLabelNode* pointInsLabel;
@property (nonatomic) int pointINS;

@end

@implementation mainGameScene

//@synthesize pointLabel = _pointLabel;
//@synthesize point = _point;

//@synthesize pointInsLabel = _pointInsLabel;
//@synthesize pointINS = _pointINS;

//@synthesize challengeLabel = _challengeLabel;

//SKSpriteNode *backgroundMain;

static mainGameScene* sharedMainGameScene = nil;


+ (mainGameScene*)sharedManager {
	@synchronized(self) {
		if (sharedMainGameScene == nil) {
			sharedMainGameScene = [[self alloc] init];
		}
	}
	return sharedMainGameScene;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedMainGameScene == nil) {
			sharedMainGameScene = [super allocWithZone:zone];
			return sharedMainGameScene;
		}
	}
	return sharedMainGameScene;
}

- (void)setDsArray:(NSArray*)dsarray {
    dsArray = dsarray;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}


- (void) setAlpha:(CGFloat)alpha{
    futon.alpha = alpha;
    scoreBar.alpha = alpha;
    challengeBar.alpha = alpha;
    gauge.alpha = alpha;
    powerGaugeCoverSprite.alpha = alpha;
    BBACharacterSprite.alpha = alpha;
}

- (void) countDownMethod{
    
    //load count down texture
    SKTextureAtlas *CountDownAtlas = [SKTextureAtlas atlasNamed:@"CONTROL"];
    SKTexture *f1 = [CountDownAtlas textureNamed:@"count_main_1.png"];
    SKTexture *f2 = [CountDownAtlas textureNamed:@"count_main_2.png"];
    SKTexture *f3 = [CountDownAtlas textureNamed:@"count_main_3.png"];
    SKTexture *f4 = [CountDownAtlas textureNamed:@"count_main_start.png"];
    NSArray *countDownTexturesArray = @[f3,f2,f1,f4];
    //  [_countDownTextures addObjectsFromArray:countDownTexturesArray];
    
    //add count down images
    SKSpriteNode *countDown = [SKSpriteNode spriteNodeWithTexture:[countDownTexturesArray objectAtIndex:0]];
    countDown.zPosition = 1000;
    countDown.size = CGSizeMake(330, 160);
    countDown.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    [self addChild:countDown];
    
    [self setAlpha:0.5];
    
    SKAction *cdAnimation = [SKAction animateWithTextures:countDownTexturesArray timePerFrame:1.0];
    
    SKAction * removeTransparent = [SKAction runBlock:^{
        [self setAlpha:1.0];
        isFirstTouch = YES;
    }];
    SKAction *remove = [SKAction removeFromParent];
    [countDown runAction:[SKAction sequence:@[cdAnimation, removeTransparent, remove]]];
}

- (void) items: (NSMutableArray *)dsMutableArray{
    
    SKTextureAtlas *itemAtlas = [SKTextureAtlas atlasNamed:@"ITEM"];
    SKTexture *bombImg = [itemAtlas textureNamed:@"item_main_bomb.png"];
    SKTexture *bigCoinImg = [itemAtlas textureNamed:@"item_main_coin_big.png"];
    SKTexture *smallCoinImg = [itemAtlas textureNamed:@"item_main_coin_small.png"];
    SKTexture *yelloInsImg = [itemAtlas textureNamed:@"item_main_insect01.png"];
    SKTexture *purpleInsImg = [itemAtlas textureNamed:@"item_main_insect02.png"];
    SKTexture *spiderInsImg = [itemAtlas textureNamed:@"item_main_insect03.png"];
    
    for (int i = 0; i < 10 + (power * 2) ; i++) {
        if (i%2==0) {
            
            dropSomethig* ds = [dropSomethig spriteNodeWithTexture:bigCoinImg];
            ds.delegate = self;
            ds.userInteractionEnabled = YES;
            ds.xScale = 3.0f/5.0f;
            ds.yScale = 3.0f/5.0f;
            
            float random = ((float)arc4random()*2 / ARC4RANDOM_MAX);
            SKAction* dsAnima = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.frame)*random,CGRectGetMinY(self.frame)-100) duration:1.5f];
            
            ds.position = CGPointMake(CGRectGetMidX(self.frame)*random ,CGRectGetMidY(self.frame)+100);
            
            dsAnima.timingMode = SKActionTimingEaseIn;
            [ds runAction:dsAnima];
            [dsMutableArray addObject:ds];
            
            
            BBADrop* bd = [BBADrop spriteNodeWithTexture:smallCoinImg];
            bd.delegate = self;
            bd.userInteractionEnabled = YES;
            bd.xScale = 3.0f/5.0f;
            bd.yScale = 3.0f/5.0f;
            float randomBBA = ((float)arc4random()*2 / ARC4RANDOM_MAX);
            bd.position = CGPointMake(CGRectGetMidX(self.frame)*randomBBA ,CGRectGetMidY(self.frame)+100);
            SKAction* BBAAnima = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.frame)*randomBBA,CGRectGetMinY(self.frame)-100) duration:2.0f];
            
            BBAAnima.timingMode = SKActionTimingEaseIn;
            [bd runAction:BBAAnima];
            [dsMutableArray addObject:bd];
        }
        
        if (i%7==0) {
            insectDrop* ins = [insectDrop spriteNodeWithTexture:spiderInsImg];
            ins.delegate = self;
            ins.userInteractionEnabled = YES;
            ins.xScale = 3.0f/5.0f;
            ins.yScale = 3.0f/5.0f;
            float randomINS = ((float)arc4random()*2 / ARC4RANDOM_MAX);
            ins.position = CGPointMake(CGRectGetMidX(self.frame)*randomINS ,CGRectGetMidY(self.frame)+100);
            SKAction* insAnima = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.frame)*randomINS,CGRectGetMinY(self.frame)-100) duration:2.0f];
            
            insAnima.timingMode = SKActionTimingEaseIn;
            [ins runAction:insAnima];
            [dsMutableArray addObject:ins];
            
            
            yellowInsect* yellins = [yellowInsect spriteNodeWithTexture:yelloInsImg];
            yellins.delegate = self;
            yellins.userInteractionEnabled = YES;
            yellins.xScale = 3.5f/5.0f;
            yellins.yScale = 3.5f/5.0f;
            float randomYELL = ((float)arc4random()*2 / ARC4RANDOM_MAX);
            yellins.position = CGPointMake(CGRectGetMidX(self.frame)*randomYELL ,CGRectGetMidY(self.frame)+100);
            SKAction* yellAnima = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.frame)*randomYELL,CGRectGetMinY(self.frame)-100) duration:1.5f];
            
            yellAnima.timingMode = SKActionTimingEaseIn;
            [yellins runAction:yellAnima];
            [dsMutableArray addObject:yellins];
            
            purpleInsect* purins = [purpleInsect spriteNodeWithTexture:purpleInsImg];
            purins.delegate = self;
            purins.userInteractionEnabled = YES;
            purins.xScale = 3.5f/5.0f;
            purins.yScale = 3.5f/5.0f;
            float randomPUR = ((float)arc4random()*2 / ARC4RANDOM_MAX);
            purins.position = CGPointMake(CGRectGetMidX(self.frame)*randomPUR ,CGRectGetMidY(self.frame)+100);
            SKAction* purAnima = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.frame)*randomPUR,CGRectGetMinY(self.frame)-100) duration:1.5f];
            
            purAnima.timingMode = SKActionTimingEaseIn;
            [purins runAction:purAnima];
            [dsMutableArray addObject:purins];
        }
        
        if (i%10==0) {
            bombDrop* bomb = [bombDrop spriteNodeWithTexture:bombImg];
            bomb.delegate = self;
            bomb.userInteractionEnabled = YES;
            bomb.xScale = 3.5f/5.0f;
            bomb.yScale = 3.5f/5.0f;
            float randomBOMB = ((float)arc4random()*2 / ARC4RANDOM_MAX);
            bomb.position = CGPointMake(CGRectGetMidX(self.frame)*randomBOMB ,CGRectGetMidY(self.frame)+100);
            SKAction* bombAnima = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.frame)*randomBOMB,CGRectGetMinY(self.frame)-100) duration:2.0f];
            
            bombAnima.timingMode = SKActionTimingEaseIn;
            [bomb runAction:bombAnima];
            [dsMutableArray addObject:bomb];
        }
    }
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        gameScore = [[GameScore alloc] init];
        [gameScore initScore];
        
        dropAnimation = YES;
        power = 0;
        _point = 0;
        _pointINS = 0;
        _challenge =1;
        update = 0;
        update2 = 0;
        finish = NO;
        dropCount = 0;
        coinMax = 0;
        touchSecondTime = NO;
        lastUpdatedAtInitToken = 0;
        lastUpdatedAt = 0;
        
        SKTextureAtlas *itemAtlas = [SKTextureAtlas atlasNamed:@"CONTROL"];
        SKTexture *bar = [itemAtlas textureNamed:@"bg_main_score_count.png"];
        SKTexture *powerGuageTexture = [itemAtlas textureNamed:@"illust_main_powerguage"];
        SKTexture *BBACharacter = [itemAtlas textureNamed:@"illust_main_bba01"];
        BBACharacterHit = [itemAtlas textureNamed:@"illust_main_bba02"];
        
        scoreBar = [SKSpriteNode spriteNodeWithTexture:bar];
        scoreBar.position = CGPointMake(80, self.frame.size.height-27);
        scoreBar.size = CGSizeMake(160, 23);
        
        challengeBar = [SKSpriteNode spriteNodeWithTexture:bar];
        challengeBar.position = CGPointMake(self.frame.size.width-78, self.frame.size.height-27);
        challengeBar.size = CGSizeMake(160, 23);
        
        _pointLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _pointLabel.fontSize = 13;
        _pointLabel.text = [NSString stringWithFormat:@"score: %d", _point];
        _pointLabel.position = CGPointMake(80, self.frame.size.height-30);
        _pointLabel.zPosition = 100;
        
        _challengeLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _challengeLabel.fontSize = 13;
        _challengeLabel.text = [NSString stringWithFormat:@"challenge: %d", _challenge];
        _challengeLabel.position = CGPointMake(self.frame.size.width-78, self.frame.size.height-30);
        
        powerGaugeCoverSprite = [SKSpriteNode spriteNodeWithTexture:powerGuageTexture];
        powerGaugeCoverSprite.position = CGPointMake(CGRectGetMidX(self.frame)*0.1, CGRectGetMidY(self.frame));
        powerGaugeCoverSprite.size = CGSizeMake(65, 300);
        gauge = [SKSpriteNode spriteNodeWithImageNamed:@"power_main_in"];
        gauge.size = CGSizeMake(10, 145);
        gauge.position = CGPointMake(CGRectGetMidX(self.frame)*0.1, CGRectGetMidY(self.frame));
        
        gauge.yScale = 0.0f;
        
        BBACharacterSprite = [SKSpriteNode spriteNodeWithTexture:BBACharacter];
        BBACharacterSprite.position = CGPointMake(self.frame.size.width-90, self.frame.size.height-170);
        BBACharacterSprite.size = CGSizeMake(160, 160);
        
        BBACharacterSpriteHit = [SKSpriteNode spriteNodeWithTexture:BBACharacterHit];
        BBACharacterSpriteHit.position = CGPointMake(self.frame.size.width-90, self.frame.size.height-170);
        BBACharacterSpriteHit.size = CGSizeMake(160, 160);
        
        
        SKAction* maxScale = [SKAction scaleYTo:2.0f duration:1.0f];
        maxScale.timingMode = SKActionTimingEaseIn;
        SKAction* minScale = [SKAction scaleYTo:0.0f duration:1.0f];
        minScale.timingMode = SKActionTimingEaseOut;
        SKAction* seq = [SKAction sequence:@[maxScale, minScale]];
        SKAction* rep = [SKAction repeatActionForever:seq];
        [gauge runAction:rep];
        
        futon = [SKSpriteNode spriteNodeWithImageNamed:@"illust_main_futon"];
        futon.size = CGSizeMake(CGRectGetWidth(self.frame), 760);
        futon.position= CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        NSMutableArray* dsMutableArray = @[].mutableCopy;
        // add items to Mutable Array
        [self items:dsMutableArray];
        
        dsArray = (NSArray*)dsMutableArray;
        
        [self addChild:futon];
        [self addChild:scoreBar];
        [self addChild:challengeBar];
        [self addChild:gauge];
        [self addChild:_pointLabel];
        [self addChild:_challengeLabel];
        [self addChild:powerGaugeCoverSprite];
        [self addChild:BBACharacterSprite];
        [self addChild:BBACharacterSpriteHit];
        BBACharacterSpriteHit.hidden = YES;
        isFirstTouch = NO;
        [self countDownMethod];
    }
    return self;
}

- (void) futonAndBBAAnimation{
    BBACharacterSprite.hidden = YES;
    BBACharacterSpriteHit.hidden = NO;
    
    SKAction* waitBBA = [SKAction waitForDuration:0.3f];
    
    SKAction* hideAction = [SKAction runBlock:^{
        BBACharacterSpriteHit.hidden = YES;
    }];
    
    NSMutableArray* dsMutableArray = @[].mutableCopy;
    // add items to Mutable Array
    [self items:dsMutableArray];
    
    dropCount = 0;
    
    dsArray = (NSArray*)dsMutableArray;
    
    _challengeLabel.text = [NSString stringWithFormat:@"challenge: %d", _challenge];
    SKAction* futonAnima = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-190) duration:0.5];
    
    SKAction* futonAction = [SKAction runBlock:^{
        [futon runAction:futonAnima];
    }];
    SKAction* wholeAction = [SKAction sequence:@[waitBBA,hideAction,futonAction]];
    [self runAction:wholeAction];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (isFirstTouch) {
        if (dropAnimation) {
            dropAnimation = NO;
            coinMax = 55;
            
            gauge.hidden = YES;
            powerGaugeCoverSprite.hidden = YES;
            
            [self futonAndBBAAnimation];
        }
    }
    
    if (finish == YES) {
        finish = NO;
        gauge.hidden = YES;
        powerGaugeCoverSprite.hidden = YES;
        _challenge++;
        
        [self futonAndBBAAnimation];
    }
}

- (void)coinTouched:(dropSomethig *)ds {
    [self runAction:[SKAction playSoundFileNamed:@"coin.mp3" waitForCompletion:NO]];
    _point += 100;
    _pointLabel.text = [NSString stringWithFormat:@"score:%d", _point];
    [self sparkParticle:ds.position];
    [ds removeFromParent];
}

- (void)insectTouched:(insectDrop *)ind {
    [self runAction:[SKAction playSoundFileNamed:@"insect.mp3" waitForCompletion:NO]];
    _point -= 30;
    _pointLabel.text = [NSString stringWithFormat:@"score:%d", _point];
    [self insectParticle:ind.position];
    [ind removeFromParent];
}

- (void)BBADropTouched:(BBADrop *)bba {
    [self runAction:[SKAction playSoundFileNamed:@"coin.mp3" waitForCompletion:NO]];
    _point += 50;
    _pointLabel.text = [NSString stringWithFormat:@"score:%d", _point];
    [self sparkParticle:bba.position];
    [bba removeFromParent];
}

- (void)yellowInsectTouched:(yellowInsect *)yellins {
    [self runAction:[SKAction playSoundFileNamed:@"insect.mp3" waitForCompletion:NO]];
    _point -= 10;
    _pointLabel.text = [NSString stringWithFormat:@"score:%d", _point];
    [self insectParticle:yellins.position];
    [yellins removeFromParent];
}

- (void)purpleInsectTouched:(purpleInsect *)purins {
    [self runAction:[SKAction playSoundFileNamed:@"insect.mp3" waitForCompletion:NO]];
    _point -= 15;
    _pointLabel.text = [NSString stringWithFormat:@"score:%d", _point];
    [self insectParticle:purins.position];
    [purins removeFromParent];
}

- (void)bombDropTouched:(bombDrop *)bod{
    [self runAction:[SKAction playSoundFileNamed:@"bomb.mp3" waitForCompletion:NO]];
    [self bombParticle:bod.position];
    [bod removeFromParent];
    self.view.userInteractionEnabled = NO;
    //[gauge removeFromParent];
    finish = NO;
    
    
    
    SKTexture *gameoverTexture = [SKTexture textureWithImageNamed:@"logo_main_gameover"];
    gameoverSprite = [SKSpriteNode spriteNodeWithTexture:gameoverTexture];
    gameoverSprite.size = CGSizeMake(200, 70);
    gameoverSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    gameoverSprite.hidden = YES;
    [self addChild:gameoverSprite];
    
    SKAction* gameoverRevel = [SKAction runBlock:^{
        [self setAlpha:0.5];
        gameoverSprite.hidden = NO;
        
    }];
    
    SKAction* waitShift = [SKAction waitForDuration:1.0f];
    SKAction* waitShiftAfter = [SKAction waitForDuration:1.0f];
   // [gameScore runFutonGameScore:_point];
    
    SKAction* gameOverAction = [SKAction runBlock:^{
    //    [self removeAllActions];
//        [self removeAllChildren];
//        [self removeChildrenInArray:dsArray];
        [gameScore runFutonGameScore:_point];

        SKTransition *reveal = [SKTransition fadeWithDuration:1.0f];
        SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size];
        self.view.userInteractionEnabled = YES;
        [self.view presentScene:gameOverScene transition: reveal];
        
    }];
    
    SKAction* seq = [SKAction sequence:@[waitShift,gameoverRevel,waitShiftAfter, gameOverAction]];
    [self runAction:seq];
}

- (void)sparkParticle:(CGPoint)pPos {
    SKEmitterNode* emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:
                              [[NSBundle mainBundle] pathForResource:@"MyParticle"
                                                              ofType:@"sks"]];
    emitter.targetNode = self.scene;
    emitter.position = pPos;
    [self addChild:emitter];
}

- (void)insectParticle:(CGPoint)pPos {
    SKEmitterNode* emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:
                              [[NSBundle mainBundle] pathForResource:@"insectTouch"
                                                              ofType:@"sks"]];
    emitter.targetNode = self.scene;
    emitter.position = pPos;
    [self addChild:emitter];
}

- (void)bombParticle:(CGPoint)bPart{
    SKEmitterNode* emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"MyBombParticle" ofType:@"sks"]];
    
    emitter.targetNode = self.scene;
    emitter.position = bPart;
    [self addChild:emitter];
}

-(void)update:(CFTimeInterval)currentTime {
    
    // 前回のフレームの更新時刻を記憶しておく
    dispatch_once(&lastUpdatedAtInitToken, ^{
        lastUpdatedAt = currentTime;
    });
    
    // 前回フレーム更新からの経過時刻を計算する
    float timeUpdate = currentTime - lastUpdatedAt;
    lastUpdatedAt = currentTime;
    
    //    NSLog(@"%f", timeUpdate);
    update += timeUpdate;
    update2 += timeUpdate;
    //    NSLog(@"%d", (int)update);
    
    switch ((int)update % 2) {
        case 1:
            power -= 1;
            break;
        default:
            power += 1;
            break;
    }
    
    NSLog(@"%d", power);
    
    futonPos = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-190);
    //  futonPos = CGPointMake(CGRectGetMidX(self.frame),20);
    
    if (futonPos.y == futon.position.y) {
        if (dropCount < dsArray.count) {
            //_challenge++;
            if (update2 >= 0.075) {
                dropSomethig* ds = (dropSomethig*)[dsArray objectAtIndex:dropCount];
                [self addChild:ds];
                //                ds.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ds.size];
                dropCount++;
                update2 = 0;
            }
            //            dropSomethig* ds = (dropSomethig*)[dsArray objectAtIndex:dropCount];
            //            [self addChild:ds];
            //            dropCount++;
        }
        else{
            if (_challenge == 5) {
                //                self.view.userInteractionEnabled = NO;
                //[gauge removeFromParent];
                finish = NO;
                
                SKTexture *gameoverTexture = [SKTexture textureWithImageNamed:@"logo_main_gameover"];
                gameoverSprite = [SKSpriteNode spriteNodeWithTexture:gameoverTexture];
                gameoverSprite.size = CGSizeMake(200, 70);
                gameoverSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
                gameoverSprite.hidden = YES;
                [self addChild:gameoverSprite];
                
                SKAction* gameoverRevel = [SKAction runBlock:^{
                    [self setAlpha:0.5];
                    gameoverSprite.hidden = NO;
                    
                }];
                
                SKAction* waitShift = [SKAction waitForDuration:2.0f];
                SKAction* waitShiftAfter = [SKAction waitForDuration:2.0f];
            
                SKAction* gameOverAction = [SKAction runBlock:^{
                    [gameScore runFutonGameScore:_point];
                    SKTransition *reveal = [SKTransition fadeWithDuration:1.0f];
                    SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size];
                    [self.view presentScene:gameOverScene transition: reveal];
                }];
                
                SKAction* seq = [SKAction sequence:@[waitShift,gameoverRevel,waitShiftAfter, gameOverAction]];
                [self runAction:seq];
            }
            SKAction* backAct = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)) duration:2.0f];
            SKAction* isYes = [SKAction runBlock:^{
                finish = YES;
                gauge.hidden = NO;
                powerGaugeCoverSprite.hidden = NO;
                //                power = 0;
                BBACharacterSprite.hidden = NO;
                
            }];
            
            SKAction* seq = [SKAction sequence:@[backAct, isYes]];
            [futon runAction:seq];
        }
    }
}

@end
