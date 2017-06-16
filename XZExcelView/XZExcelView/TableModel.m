//
//  TableModel.m
//  XZExcelView
//
//  Created by mac on 17/6/16.
//  Copyright © 2017年 Mephsito. All rights reserved.
//

#import "TableModel.h"

@implementation TableModel

- (NSMutableArray *)itemArr{
    if (_itemArr==nil) {
        _itemArr=[NSMutableArray array];
    }
    return _itemArr;
}

@end

@implementation ItemModel

@end
