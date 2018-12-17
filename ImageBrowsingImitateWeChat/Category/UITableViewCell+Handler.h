//
//  UITableViewCell+Handler.h
//  ImageBrowsingImitateWeChat
//
//  Created by 李子栋 on 2018/3/9.
//  Copyright © 2018年 李子栋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidTapImageViewCallBack)(NSArray *imageViewArray, NSInteger tapedIndex);

@interface UITableViewCell (Handler)

@property (nonatomic, copy) DidTapImageViewCallBack callback;

- (void)updateCellWithData:(NSArray *)data;

+ (CGFloat)cellHeightWithData:(NSArray *)data;

@end
