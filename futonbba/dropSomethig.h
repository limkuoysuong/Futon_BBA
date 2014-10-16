//
//  dropSomethig.h
//  FutonBBA
//
//  Created by Doi Daihei on 2014/04/28.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class dropSomethig;
@protocol dropSomethingDelegate
- (void)coinTouched:(dropSomethig*)ds;

@end

@interface dropSomethig : SKSpriteNode
@property(weak) id delegate;

@end
