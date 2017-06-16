//
//  ViewController.m
//  XZExcelView
//
//  Created by mac on 17/6/16.
//  Copyright © 2017年 Mephsito. All rights reserved.
//

#import "ViewController.h"
#import "XZExcelView.h"
#import "YYFPSLabel.h"
#import <SDAutoLayout/SDAutoLayout.h>
#import <ChameleonFramework/Chameleon.h>

@interface ViewController ()
@property (nonatomic, strong)XZExcelView *mainV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.view addSubview:self.mainV];
    
    YYFPSLabel *fpsL=[[YYFPSLabel alloc]initWithFrame:CGRectMake(15, 60, 60, 40)];
    [self.view addSubview:fpsL];
    
    
    self.mainV.sd_layout
    .topSpaceToView(self.view,260)
    .leftSpaceToView(self.view,15)
    .rightSpaceToView(self.view,15)
    .heightIs(200);
}

- (XZExcelView *)mainV{
    if (_mainV==nil) {
        _mainV=[XZExcelView new];
        _mainV.backgroundColor=[UIColor yellowColor];
    }
    return _mainV;
}



@end
