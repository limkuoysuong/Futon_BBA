//
//  insectDrop.m
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/8/14.
//  Copyright (c) 2014 Doi Daihei. All rights reserved.
//


#import "insectDrop.h"

@implementation insectDrop
@synthesize delegate = _delegate;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([_delegate respondsToSelector:@selector(insectTouched:)]) {
        [_delegate insectTouched:self];
    }
}
@end
