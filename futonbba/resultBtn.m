//
//  resultBtn.m
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/7/14.
//  Copyright (c) 2014 LKS. All rights reserved.
//

#import "resultBtn.h"


@implementation resultBtn

@synthesize delegate = _delegate;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(resultBtn:)]) {
        [_delegate resultBtn:self];
    }
}

@end
