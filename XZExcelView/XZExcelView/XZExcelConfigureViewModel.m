//
//  XZExcelConfigureViewModel.m
//  XZExcelView
//
//  Created by mac on 17/6/16.
//  Copyright © 2017年 Mephsito. All rights reserved.
//

#import "XZExcelConfigureViewModel.h"
#import "TableModel.h"

NSString *const VerticalScrollBegin=@"VerticalScrollValue";
NSString *const HorizontalScrollBegin=@"HorizontalScrollValue";
const CGFloat LineWidth=2;

@interface XZExcelConfigureViewModel()


@end

@implementation XZExcelConfigureViewModel

- (instancetype)init{
    if (self=[super init]) {
        [self bindViewModel];
      
    }
    return self;
}

- (void)bindViewModel{
    
    [self configureData];
    
    self.itemH=35;
    self.itemW=60;
    self.rowNumber=self.titleArr.count;
    self.colNumber=self.contentArr.count;
    
}

- (void)configureData{
    
    self.titleArr=[NSMutableArray array];
    for ( int i=0; i<100; i++) {
        [self.titleArr addObject:[NSString stringWithFormat:@"%d行",i]];
    }
    
    NSMutableArray *contentArr=[NSMutableArray array];
    
    @autoreleasepool {
        
        for (int i=0; i<100; i++) {
            
            TableModel *model=[TableModel new];
            model.rowTitle=[NSString stringWithFormat:@"%d楼",i];
            
            NSMutableArray *itemArr=[NSMutableArray array];
            for (int j=0; j<100; j++) {
                ItemModel *itemM=[ItemModel new];
                itemM.contentStr=[NSString stringWithFormat:@"%d",i*j];
                [itemArr addObject:itemM];
            }
            model.itemArr=itemArr;
            
            [contentArr addObject:model];
        }
    }
    
    self.contentArr=contentArr;
    
    
}







@end
