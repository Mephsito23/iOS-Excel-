//
//  LeftListView.m
//  XZExcelView
//
//  Created by mac on 17/6/16.
//  Copyright © 2017年 Mephsito. All rights reserved.
//

#import "LeftListView.h"
#import <SDAutoLayout/SDAutoLayout.h>
#import "XZExcelConfigureViewModel.h"
#import "TableViewOneCell.h"
#import <ChameleonFramework/Chameleon.h>
#import "TableModel.h"

@interface LeftListView()<UITableViewDelegate,
                          UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableV;
@property (nonatomic, strong)XZExcelConfigureViewModel *viewModel;
/**垂直滚动 */
@property (nonatomic, strong)NSValue *VerticalScrollValue;

@end

@implementation LeftListView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self creatSubViews];
    }
    return self;
}


- (void)creatSubViews{
    
    [self addSubview:self.tableV];
    self.tableV.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (void)viewBindViewModel:(XZExcelConfigureViewModel *)viewModel{
    self.viewModel=viewModel;
    self.tableV.rowHeight=viewModel.itemH;
    
    [self.viewModel addObserver:self
                     forKeyPath:VerticalScrollBegin
                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                        context:nil];
}

#pragma mark  - KVO 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    XZExcelConfigureViewModel *viewModel=(XZExcelConfigureViewModel *)object;
    if ([keyPath isEqualToString:VerticalScrollBegin]) {
        self.tableV.contentOffset=viewModel.VerticalScrollValue.CGPointValue;
    }
}

- (void)dealloc{
     [self.viewModel  removeObserver:self forKeyPath:VerticalScrollBegin];
}

#pragma mark  - UITableView 数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.viewModel.rowNumber;
}

#pragma mark  - UitableView 代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewOneCell *cell=[TableViewOneCell dequeneCellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewOneCell *showCell=(TableViewOneCell *)cell;
    showCell.backgroundColor=[UIColor flatSkyBlueColorDark];
    [showCell cellBindViewModel:self.viewModel];
    
    TableModel *model=self.viewModel.contentArr[indexPath.row];
    [showCell cellBindModel:model];
    
    
}

#pragma mark  - scrollerView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.viewModel setValue:[NSValue valueWithCGPoint:scrollView.contentOffset] forKey:VerticalScrollBegin];
}


#pragma mark  - getter and setter
- (UITableView *)tableV{
    if (_tableV==nil) {
        _tableV=[[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableV.delegate=self;
        _tableV.dataSource=self;
        _tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableV;
}



@end
