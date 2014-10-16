//
//  dropSomethig.m
//  FutonBBA
//
//  Created by Doi Daihei on 2014/04/28.
//  Copyright (c) 2014年 Doi Daihei. All rights reserved.
//

#import "dropSomethig.h"

@implementation dropSomethig

@synthesize delegate = _delegate;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(coinTouched:)]) {
        [_delegate coinTouched:self];
    }
}

@end
