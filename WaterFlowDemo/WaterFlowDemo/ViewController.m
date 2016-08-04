//
//  ViewController.m
//  WaterFlowDemo
//
//  Created by etcxm on 16/7/12.
//  Copyright © 2016年 中软国际. All rights reserved.
//

#import "ViewController.h"
#import "ZRWaterFlowLayout.h"
#import "ZRCollectionViewCell.h"
#import "ZRShopModel.h"
#import <MJExtension.h>
#import <MJRefresh.h>


@interface ViewController ()<UICollectionViewDataSource,ZRWaterFlowLayoutDelegate>

/*所有图片资源*/
@property(nonatomic,strong) NSMutableArray *theShopArry;

/*UIcollectionView*/
@property(nonatomic,weak) UICollectionView *theCollectionView;

@property(nonatomic,weak) ZRWaterFlowLayout *zrLayout;



@end

@implementation ViewController
static NSString *cellId = @"Identifier";

- (NSMutableArray *)theShopArry
{
    if (_theShopArry == nil) {
        _theShopArry = [NSMutableArray array];
    }
    return _theShopArry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    配置UICollectionView
    [self setUpCollectionView];
    
    [self setUpRefresh];
    

    
    
    
}
- (void)setUpRefresh
{
    self.theCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDatas)];
    [self.theCollectionView.mj_header beginRefreshing];
    
    self.theCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];
    self.theCollectionView.mj_footer.hidden = YES;
}
- (void)loadNewDatas
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.theShopArry removeAllObjects];
        self.theShopArry =  [ZRShopModel mj_objectArrayWithFilename:@"1.plist"];

        [self.theCollectionView reloadData];
        [self.theCollectionView.mj_header endRefreshing];
    });
}
- (void)loadMoreDatas
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *theArry =  [ZRShopModel mj_objectArrayWithFilename:@"1.plist"];
        [self.theShopArry addObjectsFromArray:theArry];

        [self.theCollectionView reloadData];
        [self.theCollectionView.mj_header endRefreshing];
    });
}
- (void)setUpCollectionView
{
    ZRWaterFlowLayout *flowlayout = [[ZRWaterFlowLayout alloc] init];
    flowlayout.delegate = self;
    self.zrLayout  = flowlayout;
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:collectionView];
    self.theCollectionView = collectionView;
    
    //    注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZRCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellId];
    
    
    //    NSLog(@"arry = %@",arry);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    self.theCollectionView.mj_footer.hidden = (self.theShopArry.count == 0);
    return self.theShopArry.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ZRCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
   
    collectionCell.model = [self.theShopArry objectAtIndex:indexPath.item];
    
    return collectionCell;
}

#pragma mark  ZRWaterFlowLayoutDelegate  ---瀑布流的委托方法

//   返回itme的高度
- (NSInteger)zrWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout heightRowOfIndex:(NSInteger)index withItemWidth:(CGFloat )width
{
    ////    model.w  model.h
    ////    w     h
    ZRShopModel *model = [self.theShopArry objectAtIndex:index];
    return model.h*width/model.w;
}

//   瀑布流的列数
- (CGFloat)columnCountInWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout
{
    return 2;
}

@end
