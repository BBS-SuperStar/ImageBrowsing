//
//  BBSPresentAnimationTransitioning.h
//  ImageBrowsingImitateWeChat
//
//  Created by 李子栋 on 2018/3/9.
//  Copyright © 2018年 李子栋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , BBSPresentAnimationTransitioningType) {
    BBSPresentAnimationTransitioningTypePresent,
    BBSPresentAnimationTransitioningTypeDismiss
};

@interface BBSPresentAnimationTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(BBSPresentAnimationTransitioningType)type;
- (instancetype)initWithTransitionType:(BBSPresentAnimationTransitioningType)type;

@end
