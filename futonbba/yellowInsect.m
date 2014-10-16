//
//  yellowInsect.m
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/9/14.
//  Copyright (c) 2014 Doi Daihei. All rights reserved.
//

#import "yellowInsect.h"

@implementation yellowInsect
@synthesize delegate = _delegate;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(yellowInsectTouched:)]) {
        [_delegate yellowInsectTouched:self];
    }
}
@end
