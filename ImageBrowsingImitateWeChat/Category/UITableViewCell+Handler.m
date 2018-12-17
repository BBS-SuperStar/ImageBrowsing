//
//  UITableViewCell+Handler.m
//  ImageBrowsingImitateWeChat
//
//  Created by 李子栋 on 2018/3/9.
//  Copyright © 2018年 李子栋. All rights reserved.
//

#import "UITableViewCell+Handler.h"
#import <Masonry.h>
#import <objc/runtime.h>

@implementation UITableViewCell (Handler)

- (void)updateCellWithData:(id)data {
    //在子类中写相应的实现操作
}

+ (CGFloat)cellHeightWithData:(NSArray *)data {
    //在子类中写相应的实现操作
    return 0;
}

#pragma mark - Getter & Setter

- (void)setCallback:(DidTapImageViewCallBack)callback {
    //这里使用方法的指针地址作为唯一的key
    objc_setAssociatedObject(self, @selector(callback), callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (DidTapImageViewCallBack)callback {
   return objc_getAssociatedObject(self, @selector(callback));
}

@end
