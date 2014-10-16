
//
//  bombDrop.h
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/15/14.
//  Copyright (c) 2014 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class bombDrop;

@protocol bombDropDelegate
- (void) bombDropTouched: (bombDrop *)bod;

@end

@interface bombDrop : SKSpriteNode
@property(weak) id delegate;
@end

