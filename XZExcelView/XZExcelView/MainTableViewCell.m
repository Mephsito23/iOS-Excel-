//
//  MainTableViewCell.m
//  BlankProject
//
//  Created by mac on 17/6/15.
//  Copyright © 2017年 Mephsito. All rights reserved.
//

#import "MainTableViewCell.h"
#import "MainTableViewCellITem.h"
#import "XZExcelConfigureViewModel.h"
#import <SDAutoLayout/SDAutoLayout.h>
#import <ChameleonFramework/Chameleon.h>
#import "TableModel.h"

@interface MainTableViewCell()<UICollectionViewDelegate,
                               UICollectionViewDataSource,
                               UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *cellCollectionV;
@property (nonatomic, strong)XZExcelConfigureViewModel *viewModel;
@property (nonatomic, strong)TableModel *model;

@end

@implementation MainTableViewCell

+ (MainTableViewCell*)dequeneCellWithTableView:(UITableView *)tableView{
    
    static NSString *ID=@"MainTableViewCell";
    MainTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell==nil) {
        cell=[[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;
}

- (void)cellBindViewModel:(XZExcelConfigureViewModel *)viewModel{
    self.viewModel=viewModel;
}

- (void)cellBindModel:(TableModel *)model{
    self.model=model;
}

- (void)scrollerItemWithContentOffset:(CGPoint )contentOffset{
    self.cellCollectionV.contentOffset=contentOffset;
}

- (void)creatSubView{
    [self.contentView addSubview:self.cellCollectionV];
    self.cellCollectionV.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

#pragma mark  - scrollerViwe 代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(mianTableViewCellScrollerDid:)]) {
        [self.delegate mianTableViewCellScrollerDid:scrollView];
    }
}

#pragma mark  - UICollectionView 代理和数据源

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.itemArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MainTableViewCellITem *item=[collectionView dequeueReusableCellWithReuseIdentifier:@"MainTableViewCellITem" forIndexPath:indexPath];
    return item;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MainTableViewCellITem *showItem=(MainTableViewCellITem *)cell;
    [showItem cellBindViewModel:self.viewModel];
    
    ItemModel *model=self.model.itemArr[indexPath.row];
    [showItem cellBindModel:model];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.viewModel.itemW, self.viewModel.itemH);
}

#pragma mark  - getter and setter
- (UICollectionView *)cellCollectionV{
    
    if (_cellCollectionV==nil) {
        
        CGFloat itemW=self.viewModel.itemW;
        CGFloat itemH=self.viewModel.itemH;
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.itemSize=CGSizeMake(itemW, itemH);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing=0;
        layout.minimumInteritemSpacing=0;
        
        _cellCollectionV=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _cellCollectionV.backgroundColor=[UIColor whiteColor];
        _cellCollectionV.delegate=self;
        _cellCollectionV.dataSource=self;
        _cellCollectionV.showsVerticalScrollIndicator = NO;
        _cellCollectionV.showsHorizontalScrollIndicator = NO;
        
        [_cellCollectionV registerClass:[MainTableViewCellITem class] forCellWithReuseIdentifier:NSStringFromClass([MainTableViewCellITem class])];
        
    }
    return _cellCollectionV;
}


@end
