//
//  XZExcelConfigureViewModel.h
//  XZExcelView
//
//  Created by mac on 17/6/16.
//  Copyright © 2017年 Mephsito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**表格线的颜色*/
#define LineColor  [UIColor grayColor]
UIKIT_EXTERN const CGFloat LineWidth;

@interface XZExcelConfigureViewModel : NSObject

#pragma mark  - 表格设置
/**表格宽度*/
@property (nonatomic, assign)CGFloat itemW;
/**表格高度*/
@property (nonatomic, assign)CGFloat itemH;
 /**行数*/
@property (nonatomic, assign)NSInteger rowNumber;
 /**列数*/
@property (nonatomic, assign)NSInteger colNumber;


#pragma mark  - 值
@property (nonatomic, strong)NSMutableArray  *titleArr;
@property (nonatomic, strong)NSMutableArray  *contentArr;

/**垂直滚动 */
@property (nonatomic, strong)NSValue *VerticalScrollValue;
/**水平滚动*/
@property (nonatomic, strong)NSValue *HorizontalScrollValue;

/**垂直滚动键值*/
UIKIT_EXTERN NSString * const VerticalScrollBegin;
/**水平滚动键值*/
UIKIT_EXTERN NSString * const HorizontalScrollBegin;

@end
