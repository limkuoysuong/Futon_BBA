//
//  GameScore.h
//  FutonBBA
//
//  Created by Kheang Senghort on 5/22/14.
//  Copyright (c) 2014 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScore : SKScene

+ (NSNumber *)getScore:(int)scoreNumber;

- (void)initScore;

- (void)runFutonGameScore:(int)scorePoint;

+ (int)currentScore;

- (void)sortedScore:(int)scoreNumber;

@end
