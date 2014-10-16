//
//  resultBtn.h
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/7/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class resultBtn;

@protocol resultBtnDelegate

- (void)resultBtn:(resultBtn*)rb;

@end

@interface resultBtn : SKSpriteNode

@property (weak) id delegate;

@end
