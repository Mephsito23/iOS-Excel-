//
//  XZExcelView.m
//  XZExcelView
//
//  Created by mac on 17/6/16.
//  Copyright © 2017年 Mephsito. All rights reserved.
//

#import "XZExcelView.h"
#import "XZExcelConfigureViewModel.h"
#import <SDAutoLayout/SDAutoLayout.h>
#import "LeftListView.h"
#import "TopHeadView.h"
#import "XZExcelContentView.h"
#import <ChameleonFramework/Chameleon.h>

@interface XZExcelView()

@property (nonatomic, strong)XZExcelConfigureViewModel *viewModel;

@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)LeftListView *leftListView;
@property (nonatomic, strong)TopHeadView *headView;
@property (nonatomic, strong)XZExcelContentView *contentView;

@end

@implementation XZExcelView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        self.viewModel=[XZExcelConfigureViewModel new];
        [self creatSubViews];
    }
    return self;
}

- (void)bindViewModel{
    [self.headView viewBindViewModel:self.viewModel];
    [self.leftListView viewBindViewModel:self.viewModel];
    [self.contentView viewBindViewModel:self.viewModel];
}

- (void)creatSubViews{
    
    [self addSubview:self.titleL];
    [self addSubview:self.headView];
    [self addSubview:self.leftListView];
    [self addSubview:self.contentView];
    
    [self layoutPageSubViews];
    [self bindViewModel];
}

- (void)layoutPageSubViews{
    
    CGFloat itemW=self.viewModel.itemW;
    
    self.titleL.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .widthIs(itemW)
    .heightIs(self.viewModel.itemH);
    
    
    self.headView.sd_layout
    .topEqualToView(self.titleL)
    .leftSpaceToView(self.titleL,0)
    .rightEqualToView(self)
    .heightRatioToView(self.titleL,1);
    
    self.leftListView.sd_layout
    .topSpaceToView(self.titleL,0)
    .leftEqualToView(self)
    .widthIs(itemW)
    .bottomEqualToView(self);
    
    
    self.contentView.sd_layout
    .topEqualToView(self.leftListView)
    .leftEqualToView(self.headView)
    .rightEqualToView(self)
    .bottomEqualToView(self);
}

#pragma mark  - getter and setter

- (UILabel *)titleL{
    if (_titleL==nil) {
        _titleL=[UILabel new];
        _titleL.text=@"楼层";
        _titleL.textAlignment=NSTextAlignmentCenter;
        _titleL.backgroundColor=[UIColor flatSkyBlueColorDark];
    }
    return _titleL;
}

- (LeftListView *)leftListView{
    if (_leftListView==nil) {
        _leftListView=[LeftListView new];
    }
    return _leftListView;
}

- (TopHeadView *)headView{
    if (_headView==nil) {
        _headView=[TopHeadView new];
    }
    return _headView;
}

- (XZExcelContentView *)contentView{
    if (_contentView==nil) {
        _contentView=[XZExcelContentView new];
    }
    return _contentView;
}


@end
