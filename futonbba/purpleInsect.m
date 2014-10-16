//
//  purpleInsect.m
//  FutonBBA
//
//  Created by Lim Kuoy Suong on 5/9/14.
//  Copyright (c) 2014 Doi Daihei. All rights reserved.
//

#import "purpleInsect.h"

@implementation purpleInsect
@synthesize delegate = _delegate;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(purpleInsectTouched:)]) {
        [_delegate purpleInsectTouched:self];
    }
}
@end
