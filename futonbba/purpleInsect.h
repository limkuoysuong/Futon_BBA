//
//  purpleInsect.h
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/9/14.
//  Copyright (c) 2014 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class purpleInsect;
@protocol purpleInsectDelegate

- (void) purpleInsectTouched: (purpleInsect *)PI;

@end

@interface purpleInsect : SKSpriteNode
@property (weak) id delegate;

@end
