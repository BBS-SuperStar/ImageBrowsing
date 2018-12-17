//
//  BBSFourImageViewCell.m
//  ImageBrowsingImitateWeChat
//
//  Created by 李子栋 on 2018/3/9.
//  Copyright © 2018年 李子栋. All rights reserved.
//

#import "BBSFourImageViewCell.h"
#import <Masonry.h>
#import "UITableViewCell+Handler.h"
#import "UIImageView+TapGesture.h"

NSString *const BBSFourImageViewCellIdentifier = @"BBSFourImageViewCell";
static const CGFloat ImageViewWidth = 100;
static const CGFloat ImageViewHeight = 100;
static const CGFloat ImageViewSpacing = 20;
static const NSInteger ImageViewTag = 100000;

@interface BBSFourImageViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *upperLeftCornerImageView;//左上角
@property (nonatomic, strong) UIImageView *lowerLeftCornerImageView;//左下角
@property (nonatomic, strong) UIImageView *upperRightCornerImageView;//右上角
@property (nonatomic, strong) UIImageView *lowerRightCornerImageView;//右下角
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation BBSFourImageViewCell

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
    
    [self.contentView addSubview:self.upperRightCornerImageView];
    [self.contentView addSubview:self.upperLeftCornerImageView];
    [self.contentView addSubview:self.lowerRightCornerImageView];
    [self.contentView addSubview:self.lowerLeftCornerImageView];
    [self.upperLeftCornerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset([self imageViewMargin]);
        make.width.height.mas_equalTo(ImageViewWidth);
    }];
    
    [self.upperRightCornerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.upperLeftCornerImageView.mas_right).offset(ImageViewSpacing);
        make.width.height.mas_equalTo(ImageViewWidth);
    }];
    
    [self.lowerLeftCornerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.upperLeftCornerImageView.mas_bottom).offset(ImageViewSpacing);
        make.left.equalTo(self.contentView).offset([self imageViewMargin]);
        make.width.height.mas_equalTo(ImageViewWidth);
    }];
    
    [self.lowerRightCornerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.upperLeftCornerImageView.mas_bottom).offset(ImageViewSpacing);
        make.left.equalTo(self.lowerLeftCornerImageView.mas_right).offset(ImageViewSpacing);
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
    self.upperLeftCornerImageView.image = image;
    
    NSString *imageNameTwo = data[1];
    UIImage *imageTwo = [UIImage imageNamed:imageNameTwo];
    self.upperRightCornerImageView.image = imageTwo;
    
    NSString *imageNameThree = data[2];
    UIImage *imageThree = [UIImage imageNamed:imageNameThree];
    self.lowerLeftCornerImageView.image = imageThree;
    
    NSString *imageNameFour = data[3];
    UIImage *imageFour = [UIImage imageNamed:imageNameFour];
    self.lowerRightCornerImageView.image = imageFour;
}

+ (CGFloat)cellHeightWithData:(NSArray *)data {
    return 2 * ImageViewHeight + 20 + ImageViewSpacing + 20;
}

#pragma mark - EventResponse

- (void)didTapImageView:(UITapGestureRecognizer *)tap {
    UIImageView *tempView = (UIImageView *)tap.view;
    if (!self.callback) {
        return;
    }
    self.callback([NSArray arrayWithObjects:self.upperLeftCornerImageView, self.upperRightCornerImageView, self.lowerLeftCornerImageView, self.lowerRightCornerImageView, nil],tempView.tag - ImageViewTag);
}

#pragma mark - Getters & Setters

- (UIImageView *)upperLeftCornerImageView {
    if (_upperLeftCornerImageView) {
        return _upperLeftCornerImageView;
    }
    _upperLeftCornerImageView = [UIImageView new];
    _upperLeftCornerImageView.backgroundColor = [UIColor clearColor];
    _upperLeftCornerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _upperLeftCornerImageView.clipsToBounds = YES;
    [_upperLeftCornerImageView addTapGestureRecognizerWithTarget:self Selector:@selector(didTapImageView:)];
    _upperLeftCornerImageView.tag = ImageViewTag + 0;
    return _upperLeftCornerImageView;
}

- (UIImageView *)lowerLeftCornerImageView {
    if (_lowerLeftCornerImageView) {
        return _lowerLeftCornerImageView;
    }
    _lowerLeftCornerImageView = [UIImageView new];
    _lowerLeftCornerImageView.backgroundColor = [UIColor clearColor];
    _lowerLeftCornerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _lowerLeftCornerImageView.clipsToBounds = YES;
    [_lowerLeftCornerImageView addTapGestureRecognizerWithTarget:self Selector:@selector(didTapImageView:)];
    _lowerLeftCornerImageView.tag = ImageViewTag + 2;
    return _lowerLeftCornerImageView;
}

- (UIImageView *)upperRightCornerImageView {
    if (_upperRightCornerImageView) {
        return _upperRightCornerImageView;
    }
    _upperRightCornerImageView = [UIImageView new];
    _upperRightCornerImageView.backgroundColor = [UIColor clearColor];
    _upperRightCornerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _upperRightCornerImageView.clipsToBounds = YES;
    [_upperRightCornerImageView addTapGestureRecognizerWithTarget:self Selector:@selector(didTapImageView:)];
    _upperRightCornerImageView.tag = ImageViewTag + 1;
    return _upperRightCornerImageView;
}

- (UIImageView *)lowerRightCornerImageView {
    if (_lowerRightCornerImageView) {
        return _lowerRightCornerImageView;
    }
    _lowerRightCornerImageView = [UIImageView new];
    _lowerRightCornerImageView.backgroundColor = [UIColor clearColor];
    _lowerRightCornerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _lowerRightCornerImageView.clipsToBounds = YES;
    [_lowerRightCornerImageView addTapGestureRecognizerWithTarget:self Selector:@selector(didTapImageView:)];
    _lowerRightCornerImageView.tag = ImageViewTag + 3;
    return _lowerRightCornerImageView;
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
    _titleLabel.text = @"四张图片";
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    return _titleLabel;
}

@end
