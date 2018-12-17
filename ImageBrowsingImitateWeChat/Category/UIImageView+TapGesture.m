//
//  UIImageView+TapGesture.m
//  ImageBrowsingImitateWeChat
//
//  Created by 李子栋 on 2018/3/10.
//  Copyright © 2018年 李子栋. All rights reserved.
//

#import "UIImageView+TapGesture.h"

@implementation UIImageView (TapGesture)

- (void)addTapGestureRecognizerWithTarget:(id)target Selector:(SEL)selector {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
}

@end
