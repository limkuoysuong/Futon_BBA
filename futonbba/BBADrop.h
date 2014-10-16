//
//  BBADrop.h
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/9/14.
//  Copyright (c) 2014 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class BBADrop;
@protocol BBADropDelegate

- (void) BBADropTouched:(BBADrop *)bd;

@end

@interface BBADrop : SKSpriteNode
@property(weak) id delegate;
@end

