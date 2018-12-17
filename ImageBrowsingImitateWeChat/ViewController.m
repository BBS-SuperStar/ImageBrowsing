//
//  ViewController.m
//  ImageBrowsingImitateWeChat
//
//  Created by 李子栋 on 2018/3/9.
//  Copyright © 2018年 李子栋. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "BBSSingleImageViewCell.h"
#import "BBSTwoImageViewCell.h"
#import "BBSThreeImageViewCell.h"
#import "BBSFourImageViewCell.h"
#import "UITableViewCell+Handler.h"
#import "BBSImageBrowsingController.h"

@interface ViewController ()<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITableView *customTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *identifierArray;

@property (nonatomic, strong) UIImageView *animationImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureCustomSubviews];
}

#pragma mark - Private

- (void)configureCustomSubviews {
    self.view.backgroundColor = [UIColor whiteColor];
    self.customTableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.height.mas_equalTo(44);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.customTableView];
    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
    [self.customTableView registerClass:[BBSSingleImageViewCell class] forCellReuseIdentifier:BBSSingleImageViewCellIdentifier];
    [self.customTableView registerClass:[BBSTwoImageViewCell class] forCellReuseIdentifier:BBSTwoImageViewCellIdentifier];
    [self.customTableView registerClass:[BBSThreeImageViewCell class] forCellReuseIdentifier:BBSThreeImageViewCellIdentifier];
    [self.customTableView registerClass:[BBSFourImageViewCell class] forCellReuseIdentifier:BBSFourImageViewCellIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if ([self.identifierArray[indexPath.row] isEqualToString:BBSSingleImageViewCellIdentifier]) {
        height = [BBSSingleImageViewCell cellHeightWithData:self.dataArray[indexPath.row]];
    }
    else if ([self.identifierArray[indexPath.row] isEqualToString:BBSTwoImageViewCellIdentifier]) {
        height = [BBSTwoImageViewCell cellHeightWithData:self.dataArray[indexPath.row]];
    }
    else if ([self.identifierArray[indexPath.row] isEqualToString:BBSThreeImageViewCellIdentifier]) {
        height = [BBSThreeImageViewCell cellHeightWithData:self.dataArray[indexPath.row]];
    }
    else if ([self.identifierArray[indexPath.row] isEqualToString:BBSFourImageViewCellIdentifier]) {
        height = [BBSFourImageViewCell cellHeightWithData:self.dataArray[indexPath.row]];
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = self.identifierArray[indexPath.row];
    if (!identifier.length) {
        return [UITableViewCell new];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ([cell respondsToSelector:@selector(updateCellWithData:)]) {
        [cell updateCellWithData:self.dataArray[indexPath.row]];
    }
    if (cell) {
        __weak typeof(self) weakSelf = self;
        cell.callback = ^(NSArray *imageViewArray, NSInteger tapedIndex) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            UIImageView *tapImageView = imageViewArray[tapedIndex];
            strongSelf.animationImageView = tapImageView;
            BBSImageBrowsingController *browsingController = [[BBSImageBrowsingController alloc] initWithImageViewArray:imageViewArray currentIndex:tapedIndex];
            browsingController.callBack = ^(UIImageView *currentImageView) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                strongSelf.animationImageView = currentImageView;
            };
            [strongSelf presentViewController:browsingController animated:YES completion:nil];
        };
    }
    return !!cell ? cell : [UITableViewCell new];
}

#pragma mark - Getters & Setters

- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    _titleLabel = [UILabel new];
    _titleLabel.text = @"图片浏览器";
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    return _titleLabel;
}

- (UITableView *)customTableView {
    if (_customTableView) {
        return _customTableView;
    }
    _customTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    _customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _customTableView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray) {
        return _dataArray;
    }
    _dataArray = [NSMutableArray new];
    [_dataArray addObject:@[@"111.jpg"]];
    [_dataArray addObject:@[@"111.jpg",@"222.jpg"]];
    [_dataArray addObject:@[@"111.jpg",@"222.jpg",@"333.jpg"]];
    [_dataArray addObject:@[@"111.jpg",@"222.jpg",@"333.jpg",@"444.jpg"]];
    return _dataArray;
}

- (NSMutableArray *)identifierArray {
    if (_identifierArray) {
        return _identifierArray;
    }
    _identifierArray = [NSMutableArray new];
    [_identifierArray addObject:BBSSingleImageViewCellIdentifier];
    [_identifierArray addObject:BBSTwoImageViewCellIdentifier];
    [_identifierArray addObject:BBSThreeImageViewCellIdentifier];
    [_identifierArray addObject:BBSFourImageViewCellIdentifier];
    return _identifierArray;
}
@end
