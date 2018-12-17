//
//  BBSImageBrowsingController.h
//  ImageBrowsingImitateWeChat
//
//  Created by 李子栋 on 2018/3/9.
//  Copyright © 2018年 李子栋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UpdateAnimationImageViewCallBack)(UIImageView *currentImageView);

@interface BBSImageBrowsingController : UIViewController

@property (strong, nonatomic, readonly) UIImageView *showImageView;
@property (copy, nonatomic) UpdateAnimationImageViewCallBack callBack;

- (instancetype)initWithImageViewArray:(NSArray *)imageViewArray
                          currentIndex:(NSInteger)currentIndex;

@end
