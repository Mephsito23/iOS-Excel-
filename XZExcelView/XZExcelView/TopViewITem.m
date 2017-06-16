//
//  TopViewITem.m
//  XZExcelView
//
//  Created by mac on 17/6/16.
//  Copyright © 2017年 Mephsito. All rights reserved.
//

#import "TopViewITem.h"
#import "XZExcelConfigureViewModel.h"
#import <SDAutoLayout/SDAutoLayout.h>

@interface TopViewITem()
@property (nonatomic, strong)XZExcelConfigureViewModel *viewModel;
@property (nonatomic, assign)CGSize size;
@property (nonatomic, strong)UILabel*titleL;

@end

@implementation TopViewITem
- (instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self creatSubViews];
    }
    return self;
}

- (void)cellBindViewModel:(XZExcelConfigureViewModel *)viewModel{
    self.viewModel=viewModel;
    
    CGSize size=CGSizeMake(viewModel.itemW, viewModel.itemH);
    BOOL judge=CGSizeEqualToSize(self.size, size);
    if (!judge) {
        self.size=size;
        [self drawLineWithSize:size];
    }
}

- (void)cellBindModel:(NSString *)model{
    self.titleL.text=model;
}

- (void)drawLineWithSize:(CGSize)size{
    
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:CGPointMake(0, 0)];
    // 其他点
    [linePath addLineToPoint:CGPointMake(size.width, 0)];
    [linePath addLineToPoint:CGPointMake(size.width, size.height)];
    [linePath addLineToPoint:CGPointMake(0, size.height)];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = LineWidth;
    lineLayer.strokeColor = LineColor.CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil; // 默认为blackColor
    
    UIGraphicsBeginImageContext(size);
    [linePath stroke];
    UIGraphicsEndImageContext();
    
    [self.contentView.layer addSublayer:lineLayer];
    
}

- (void)creatSubViews{
    [self.contentView addSubview:self.titleL];
    self.titleL.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (UILabel *)titleL{
    if (_titleL==nil) {
        _titleL=[UILabel new];
        _titleL.font=[UIFont systemFontOfSize:15];
        _titleL.textAlignment=NSTextAlignmentCenter;
    }
    return _titleL;
}

@end
