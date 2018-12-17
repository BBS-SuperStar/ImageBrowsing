//
//  BBSImageBrowsingController.m
//  ImageBrowsingImitateWeChat
//
//  Created by 李子栋 on 2018/3/9.
//  Copyright © 2018年 李子栋. All rights reserved.
//

#import "BBSImageBrowsingController.h"
#import "BBSPresentAnimationTransitioning.h"
#import <Masonry.h>

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

static NSInteger ContainerViewTag = 200000;

@interface BBSImageBrowsingController ()<UIViewControllerTransitioningDelegate,
UIScrollViewDelegate,
UIGestureRecognizerDelegate>

@property (copy, nonatomic) NSArray *imageViewArray;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIImageView *showImageView;
@property (strong, nonatomic) UIScrollView *imageScrollView;
@property (assign, nonatomic) BOOL scrollViewIsScrolling;
@property (assign, nonatomic) BOOL animationFlag;

@end

@implementation BBSImageBrowsingController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (instancetype)initWithImageViewArray:(NSArray *)imageViewArray
                          currentIndex:(NSInteger)currentIndex {
    self = [self init];
    if (self) {
        self.imageViewArray = imageViewArray;
        self.currentIndex = currentIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureCustomSubviews];
}

#pragma mark - Private

- (void)configureCustomSubviews {
    self.view.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0];
    
    [self.view addSubview:self.imageScrollView];
    [self.imageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self.view);
        make.width.mas_equalTo(SCREENWIDTH + 20);
    }];
    
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(20);
    }];
    
    for (int i = 0; i < self.imageViewArray.count; i ++) {
        UIView *containerView = [UIView new];
        containerView.tag = ContainerViewTag + i;
        [self.imageScrollView addSubview:containerView];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureAction:)];
        panGesture.delegate = self;
        [containerView addGestureRecognizer:panGesture];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBackButton)];
        tapGesture.delegate = self;
        [containerView addGestureRecognizer:tapGesture];
        
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageScrollView).offset((20 + SCREENWIDTH) * i);
            make.top.equalTo(self.imageScrollView);
            make.height.mas_equalTo(SCREENHEIGHT);
            make.width.mas_equalTo(SCREENWIDTH);
        }];
        
        UIImageView *tempImageView = self.imageViewArray[i];
        UIImageView *imageView = [UIImageView new];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = tempImageView.image;
        [containerView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(containerView);
            make.width.mas_equalTo(SCREENWIDTH);
            make.height.mas_equalTo(SCREENWIDTH*tempImageView.image.size.height/tempImageView.image.size.width);
        }];
        
        if (self.currentIndex == i) {
            self.showImageView.image = tempImageView.image;
            [self.showImageView setFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH*tempImageView.image.size.height/tempImageView.image.size.width)];
            self.showImageView.center = self.view.center;
        }
    }
    
    [self.imageScrollView setContentOffset:CGPointMake((20 + SCREENWIDTH) * self.currentIndex, 0)];

}

#pragma mark - EventResponse

- (void)didTapBackButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handlePanGestureAction:(UIPanGestureRecognizer *)pan {
    CGPoint offSetPoint = [pan translationInView:self.view];
    UIImageView *scaleImageView = [pan.view.subviews firstObject];
    if ((offSetPoint.y <= 0 || ABS(offSetPoint.x) > 0) && !self.animationFlag) {//从偏移量来判断拖拽方向，当offSetPoint.y > 0时 是向下拖动
        return;
    }
    self.animationFlag = YES;
    self.imageScrollView.scrollEnabled = NO;
    CGFloat alpha = 1 - offSetPoint.y/400;

    if (alpha > 0) {
        self.imageScrollView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
    }
    else {
        self.imageScrollView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }
    CGFloat scale = 1 - offSetPoint.y/400;
    if (scale < 0.4) {
        scale= 0.4;
    }
    if (scale > 1) {
        scale = 1;
    }
    
    [scaleImageView setFrame:CGRectMake(scaleImageView.frame.origin.x, scaleImageView.frame.origin.y, SCREENWIDTH * scale, SCREENWIDTH * scaleImageView.image.size.height / scaleImageView.image.size.width * scale)];
    scaleImageView.center = CGPointMake(self.view.center.x + offSetPoint.x, self.view.center.y + offSetPoint.y);

    switch (pan.state) {
        case UIGestureRecognizerStateEnded:{
            if (offSetPoint.y > SCREENHEIGHT/3.0) {//执行dismiss动画
                self.showImageView = scaleImageView;
                [self didTapBackButton];
            }
            else {//还原imageview的位置
                [UIView animateWithDuration:0.3 animations:^{
                    [scaleImageView setFrame:CGRectMake(scaleImageView.frame.origin.x, scaleImageView.frame.origin.y, SCREENWIDTH, SCREENWIDTH * scaleImageView.image.size.height / scaleImageView.image.size.width)];
                    scaleImageView.center = CGPointMake(self.view.center.x, self.view.center.y);
                    self.imageScrollView.scrollEnabled = YES;
                    self.imageScrollView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
                    self.animationFlag = NO;
                }];
            }
        }
            break;
            
        case UIGestureRecognizerStateFailed:{
            [UIView animateWithDuration:0.3 animations:^{
                [scaleImageView setFrame:CGRectMake(scaleImageView.frame.origin.x, scaleImageView.frame.origin.y, SCREENWIDTH, SCREENWIDTH * scaleImageView.image.size.height / scaleImageView.image.size.width)];
                scaleImageView.center = CGPointMake(self.view.center.x, self.view.center.y);
                self.imageScrollView.scrollEnabled = YES;
                self.imageScrollView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
                self.animationFlag = NO;
            }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.scrollViewIsScrolling) {
        return NO;
    }
    return YES;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [BBSPresentAnimationTransitioning transitionWithTransitionType:BBSPresentAnimationTransitioningTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [BBSPresentAnimationTransitioning transitionWithTransitionType:BBSPresentAnimationTransitioningTypeDismiss];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.scrollViewIsScrolling = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.scrollViewIsScrolling = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.currentIndex = scrollView.contentOffset.x/(SCREENWIDTH + 20);
    if (self.callBack) {
        UIImageView *tempImageView = self.imageViewArray[self.currentIndex];
        self.showImageView.image = tempImageView.image;
        [self.showImageView setFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH * tempImageView.image.size.height / tempImageView.image.size.width)];
        self.showImageView.center = self.view.center;
        self.callBack(tempImageView);
    }
}

#pragma mark - Getters & Setters

- (UIButton *)backButton {
    if (_backButton) {
        return _backButton;
    }
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_backButton addTarget:self action:@selector(didTapBackButton) forControlEvents:UIControlEventTouchUpInside];
    return _backButton;
}

- (UIScrollView *)imageScrollView {
    if (_imageScrollView) {
        return _imageScrollView;
    }
    _imageScrollView = [UIScrollView new];
    _imageScrollView.delegate = self;
    _imageScrollView.delaysContentTouches = YES;
    _imageScrollView.canCancelContentTouches = NO;
    _imageScrollView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
    _imageScrollView.contentSize = CGSizeMake((20 + SCREENWIDTH) * self.imageViewArray.count, SCREENHEIGHT);
    _imageScrollView.pagingEnabled = YES;
    return _imageScrollView;
}

- (UIImageView *)showImageView {
    if (_showImageView) {
        return _showImageView;
    }
    _showImageView = [UIImageView new];
    _showImageView.clipsToBounds = YES;
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    return _showImageView;
}

@end
