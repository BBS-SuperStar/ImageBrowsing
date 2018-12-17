//
//  BBSSingleImageViewCell.m
//  ImageBrowsingImitateWeChat
//
//  Created by 李子栋 on 2018/3/9.
//  Copyright © 2018年 李子栋. All rights reserved.
//

#import "BBSSingleImageViewCell.h"
#import "UITableViewCell+Handler.h"
#import <Masonry.h>
#import "UIImageView+TapGesture.h"

NSString *const BBSSingleImageViewCellIdentifier = @"BBSSingleImageViewCell";

@interface BBSSingleImageViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *customImageView;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation BBSSingleImageViewCell

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
    
    [self.contentView addSubview:self.customImageView];
    [self.customImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.right.equalTo(self.contentView).offset(-10);
    }];
    
    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}



#pragma mark - Public

- (void)updateCellWithData:(NSArray *)data {
    self.dataArray = data;
    if (data.count <= 0 || data == nil) {
        return;
    }
    NSString *imageName = data[0];
    UIImage *image = [UIImage imageNamed:imageName];
    self.customImageView.image = image;
}

+ (CGFloat)cellHeightWithData:(NSArray *)data {
    if (data.count <= 0 || data == nil) {
        return 10;
    }
    NSString *imageName = data[0];
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat originalWidth = image.size.width;
    CGFloat originalHeight = image.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    CGFloat height = width * originalHeight / originalWidth;
    return height + 20 + 20;
}

#pragma mark - EventResponse

- (void)didTapImageView:(UITapGestureRecognizer *)tap {
    UIImageView *tempView = (UIImageView *)tap.view;
    if (!self.callback) {
        return;
    }
    self.callback([NSArray arrayWithObject:tempView],0);
}

#pragma mark - Getters & Setters

- (UIImageView *)customImageView {
    if (_customImageView) {
        return _customImageView;
    }
    _customImageView = [UIImageView new];
    _customImageView.backgroundColor = [UIColor clearColor];
    _customImageView.contentMode = UIViewContentModeScaleAspectFill;
    _customImageView.clipsToBounds = YES;
    [_customImageView addTapGestureRecognizerWithTarget:self Selector:@selector(didTapImageView:)];
    return _customImageView;
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
    _titleLabel.text = @"一张图片";
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    return _titleLabel;
}

@end
