//
//  insectDrop.h
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/8/14.
//  Copyright (c) 2014 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class insectDrop;
@protocol insectDropDelegate
- (void) insectTouched:(insectDrop *)ind;

@end
 
@interface insectDrop : SKSpriteNode
@property(weak) id delegate;

@end


