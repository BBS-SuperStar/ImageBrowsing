//
//  BBSTwoImageViewCell.m
//  ImageBrowsingImitateWeChat
//
//  Created by 李子栋 on 2018/3/9.
//  Copyright © 2018年 李子栋. All rights reserved.
//

#import "BBSTwoImageViewCell.h"
#import "UITableViewCell+Handler.h"
#import <Masonry.h>
#import "UIImageView+TapGesture.h"

NSString *const BBSTwoImageViewCellIdentifier = @"BBSTwoImageViewCell";

static const CGFloat ImageViewWidth = 100;
static const CGFloat ImageViewHeight = 100;
static const CGFloat ImageViewSpacing = 20;
static const NSInteger ImageViewTag = 100000;

@interface BBSTwoImageViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation BBSTwoImageViewCell

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
    [self.contentView addSubview:self.rightImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset([self imageViewMargin]);
        make.width.height.mas_equalTo(ImageViewWidth);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.leftImageView.mas_right).offset(ImageViewSpacing);
        make.width.height.mas_equalTo(ImageViewWidth);
    }];
    
    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (CGFloat)imageViewMargin {
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - 2 * ImageViewWidth - ImageViewSpacing) / 2;
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
    self.rightImageView.image = imageTwo;
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
    self.callback([NSArray arrayWithObjects:self.leftImageView, self.rightImageView, nil],tempView.tag - ImageViewTag);
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
    _leftImageView.tag = ImageViewTag + 0;
    [_leftImageView addTapGestureRecognizerWithTarget:self Selector:@selector(didTapImageView:)];
    return _leftImageView;
}

- (UIImageView *)rightImageView {
    if (_rightImageView) {
        return _rightImageView;
    }
    _rightImageView = [UIImageView new];
    _rightImageView.backgroundColor = [UIColor clearColor];
    _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    _rightImageView.clipsToBounds = YES;
    _rightImageView.tag = ImageViewTag + 1;
    [_rightImageView addTapGestureRecognizerWithTarget:self Selector:@selector(didTapImageView:)];
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
    _titleLabel.text = @"二张图片";
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    return _titleLabel;
}

@end
