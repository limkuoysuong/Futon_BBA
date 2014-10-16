//
//  yellowInsect.h
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/9/14.
//  Copyright (c) 2014 Doi Daihei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class yellowInsect;
@protocol yellowInsectDelegate

- (void) yellowInsectTouched:(yellowInsect *)YI;

@end

@interface yellowInsect : SKSpriteNode
    @property(weak) id delegate;
@end