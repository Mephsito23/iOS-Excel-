//
//  TopHeadView.m
//  XZExcelView
//
//  Created by mac on 17/6/16.
//  Copyright © 2017年 Mephsito. All rights reserved.
//

#import "TopHeadView.h"
#import "TopViewITem.h"
#import "XZExcelConfigureViewModel.h"
#import <SDAutoLayout/SDAutoLayout.h>
#import <ChameleonFramework/Chameleon.h>

@interface TopHeadView()<UICollectionViewDelegate,
                         UICollectionViewDataSource,
                         UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *headTitleV;
@property (nonatomic, strong)XZExcelConfigureViewModel *viewModel;

@end

@implementation TopHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self creatSubViews];
    }
    return self;
}

- (void)viewBindViewModel:(XZExcelConfigureViewModel *)viewModel{
    self.viewModel=viewModel;
    
    [self.viewModel addObserver:self
                     forKeyPath:HorizontalScrollBegin
                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                        context:nil];
}

#pragma mark  - KVO 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    XZExcelConfigureViewModel *viewModel=(XZExcelConfigureViewModel *)object;
    if ([keyPath isEqualToString:HorizontalScrollBegin]) {
        self.headTitleV.contentOffset=viewModel.HorizontalScrollValue.CGPointValue;
    }
}

- (void)dealloc{
    [self.viewModel  removeObserver:self forKeyPath:HorizontalScrollBegin];
}

- (void)creatSubViews{
    
    [self addSubview:self.headTitleV];
    self.headTitleV.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

#pragma mark  - UICollectionView 代理和数据源

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewModel.colNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TopViewITem *item=[collectionView dequeueReusableCellWithReuseIdentifier:@"TopViewITem" forIndexPath:indexPath];
    return item;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TopViewITem *showItem=(TopViewITem *)cell;
    showItem.backgroundColor=[UIColor flatSkyBlueColorDark];
    [showItem cellBindViewModel:self.viewModel];
    
    NSString *title=self.viewModel.titleArr[indexPath.row];
    [showItem cellBindModel:title];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.viewModel.itemW, self.viewModel.itemH);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.viewModel setValue:[NSValue valueWithCGPoint:scrollView.contentOffset] forKey:HorizontalScrollBegin];
}


#pragma mark  - getter and setter

- (UICollectionView *)headTitleV{
    
    if (_headTitleV==nil) {
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.itemSize=CGSizeMake(self.viewModel.itemW, self.viewModel.itemH);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing=0;
        layout.minimumInteritemSpacing=0;
        
        _headTitleV=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _headTitleV.backgroundColor=[UIColor whiteColor];
        _headTitleV.delegate=self;
        _headTitleV.dataSource=self;
        _headTitleV.showsVerticalScrollIndicator = NO;
        _headTitleV.showsHorizontalScrollIndicator = NO;
        
        [_headTitleV registerClass:[TopViewITem class] forCellWithReuseIdentifier:NSStringFromClass([TopViewITem class])];
        
    }
    return _headTitleV;
}

@end
