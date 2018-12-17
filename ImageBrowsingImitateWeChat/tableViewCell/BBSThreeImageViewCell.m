//
//  BBSThreeImageViewCell.m
//  ImageBrowsingImitateWeChat
//
//  Created by 李子栋 on 2018/3/9.
//  Copyright © 2018年 李子栋. All rights reserved.
//

#import "BBSThreeImageViewCell.h"
#import <Masonry.h>
#import "UIImageView+TapGesture.h"
#import "UITableViewCell+Handler.h"

NSString *const BBSThreeImageViewCellIdentifier = @"BBSThreeImageViewCell";
static const CGFloat ImageViewWidth = 100;
static const CGFloat ImageViewHeight = 100;
static const CGFloat ImageViewSpacing = 20;
static const NSInteger ImageViewTag = 100000;

@interface BBSThreeImageViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation BBSThreeImageViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInitiallization];
    }
    return self;
}

#pragma mark - Private

- (void)commonInitiallization {
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.middleImageView];
    [self.contentView addSubview:self.rightImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset([self imageViewMargin]);
        make.width.height.mas_equalTo(ImageViewWidth);
    }];
    
    [self.middleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.leftImageView.mas_right).offset(ImageViewSpacing);
        make.width.height.mas_equalTo(ImageViewWidth);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.middleImageView.mas_right).offset(ImageViewSpacing);
        make.width.height.mas_equalTo(ImageViewWidth);
    }];
    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (CGFloat)imageViewMargin {
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - 3 * ImageViewWidth - 2 * ImageViewSpacing) / 2;
    return margin;
}

#pragma mark - Public

- (void)updateCellWithData:(NSArray *)data {
    if (data.count <= 0 || data == nil) {
        return;
    }
    NSString *imageName = data[0];
    UIImage *image = [UIImage imageNamed:imageName];
    self.leftImageView.image = image;
    
    NSString *imageNameTwo = data[1];
    UIImage *imageTwo = [UIImage imageNamed:imageNameTwo];
    self.middleImageView.image = imageTwo;
    
    NSString *imageNameThree = data[2];
    UIImage *imageThree = [UIImage imageNamed:imageNameThree];
    self.rightImageView.image = imageThree;
}

+ (CGFloat)cellHeightWithData:(NSArray *)data {
    return ImageViewHeight + 20 + 20;
}

#pragma mark - EventResponse

- (void)didTapImageView:(UITapGestureRecognizer *)tap {
    UIImageView *tempView = (UIImageView *)tap.view;
    if (!self.callback) {
        return;
    }
    self.callback([NSArray arrayWithObjects:self.leftImageView, self.middleImageView, self.rightImageView, nil],tempView.tag - ImageViewTag);
}

#pragma mark - Getters & Setters

- (UIImageView *)leftImageView {
    if (_leftImageView) {
        return _leftImageView;
    }
    _leftImageView = [UIImageView new];
    _leftImageView.backgroundColor = [UIColor clearColor];
    _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageView.clipsToBounds = YES;
    [_leftImageView addTapGestureRecognizerWithTarget:self Selector:@selector(didTapImageView:)];
    _leftImageView.tag = ImageViewTag + 0;
    return _leftImageView;
}

- (UIImageView *)middleImageView {
    if (_middleImageView) {
        return _middleImageView;
    }
    _middleImageView = [UIImageView new];
    _middleImageView.backgroundColor = [UIColor clearColor];
    _middleImageView.contentMode = UIViewContentModeScaleAspectFill;
    _middleImageView.clipsToBounds = YES;
    [_middleImageView addTapGestureRecognizerWithTarget:self Selector:@selector(didTapImageView:)];
    _middleImageView.tag = ImageViewTag + 1;
    return _middleImageView;
}

- (UIImageView *)rightImageView {
    if (_rightImageView) {
        return _rightImageView;
    }
    _rightImageView = [UIImageView new];
    _rightImageView.backgroundColor = [UIColor clearColor];
    _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    _rightImageView.clipsToBounds = YES;
    [_rightImageView addTapGestureRecognizerWithTarget:self Selector:@selector(didTapImageView:)];
    _rightImageView.tag = ImageViewTag + 2;
    return _rightImageView;
}

- (UIView *)bottomLine {
    if (_bottomLine) {
        return _bottomLine;
    }
    _bottomLine = [UIView new];
    _bottomLine.backgroundColor = [UIColor lightGrayColor];
    return _bottomLine;
}

- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    _titleLabel = [UILabel new];
    _titleLabel.text = @"三张图片";
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    return _titleLabel;
}

@end
