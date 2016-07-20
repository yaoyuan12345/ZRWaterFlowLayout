//
//  ZRWaterFlowLayout.m
//  WaterFlowDemo
//
//  Created by etcxm on 16/7/12.
//  Copyright © 2016年 中软国际. All rights reserved.
//

#import "ZRWaterFlowLayout.h"



/*默认列数*/
static const NSInteger ZrDefaultcolumnCount = 3;
/*列的间隙*/
static const NSInteger ZrDefaultcolumnMargin = 10;
/*行的间隙*/
static const NSInteger ZrDefaultrowMargin = 10;
/*UICollectionView 的边距*/
static const UIEdgeInsets ZrDefaultedgeInset = {10, 10, 10, 10};

@interface ZRWaterFlowLayout ()

/*这个所有item的布局信息*/
@property(nonatomic,strong) NSMutableArray *attriArry;

/*所有列数中的高度*/
@property(nonatomic,strong) NSMutableArray *columnHeightArry;

/*记录内容的高度*/
@property(nonatomic,assign) CGFloat cellContentViewHeight;


- (CGFloat)columnCount;
- (CGFloat)columnMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)edgeInsets;
//@property(nonatomic,assign) CGFloat column1;
//@property(nonatomic,assign) CGFloat column2;
//@property(nonatomic,assign) CGFloat column3;
@end


@implementation ZRWaterFlowLayout

#pragma mark 配置常用数据
- (CGFloat)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterFlowLayout:)]) {
        CGFloat count = [self.delegate columnCountInWaterFlowLayout:self];
        return count == 0 ? ZrDefaultcolumnCount:count;
    }else
    {
        return ZrDefaultcolumnCount;
    }
}
- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterFlowLayout:)]) {
        CGFloat count = [self.delegate columnMarginInWaterFlowLayout:self];
        return count == 0 ? ZrDefaultcolumnMargin:count;
    }else
    {
        return ZrDefaultcolumnMargin;
    }
}
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFlowLayout:)]) {
        CGFloat count = [self.delegate rowMarginInWaterFlowLayout:self];
        return count == 0 ? ZrDefaultrowMargin:count;
    }else
    {
        return ZrDefaultrowMargin;
    }
}
- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetInWaterFlowLayout:)]) {
        return [self.delegate edgeInsetInWaterFlowLayout:self];
    }else
    {
        return ZrDefaultedgeInset;
    }
}


//懒加载
- (NSMutableArray *)attriArry
{
    if (_attriArry == nil) {
        _attriArry = [NSMutableArray array];
    }
    return _attriArry;
}
- (NSMutableArray *)columnHeightArry
{
    if (_columnHeightArry == nil) {
        _columnHeightArry = [NSMutableArray array];
    }
    return _columnHeightArry;
}


//初始化
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.cellContentViewHeight = 0;
    
    NSLog(@"%s",__func__);
//    清除所有的列的高度
    [self.columnHeightArry removeAllObjects];
    for (int i = 0; i< self.columnCount; i++) {
        [self.columnHeightArry addObject:@(self.edgeInsets.top)];
    }
    
    
// 清除所有布局的信息
    [self.attriArry removeAllObjects];
    //    拿出第一组的cell的个数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
//    NSLog(@"count = %ld",count);
//    NSLog(@"%s",__func__);
   
    for (int i = 0; i<count; i++) {
        //        创建位置
        NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
        
        //        UICollectionViewLayoutAttributes *layoutAttri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
        
        //        通过 path设置item的布局信息
        UICollectionViewLayoutAttributes *layoutAttri = [self layoutAttributesForItemAtIndexPath:path];
        [self.attriArry addObject:layoutAttri];

    }
    
}

//返回cell的排布
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attriArry;
}
//返回 indexPath 对应item的信息
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *layoutAttri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
// UICollectionView 的宽度
    CGFloat width = self.collectionView.frame.size.width;
//    w = (width-间隙*4)/列数
   CGFloat w = (width - self.edgeInsets.left-self.edgeInsets.right-(self.columnMargin*(self.columnCount-1)))/self.columnCount;
    
    
    CGFloat h = [self.delegate zrWaterFlowLayout:self heightRowOfIndex:indexPath.item withItemWidth:w];
    
//    h = 50+arc4random_uniform(100);
    
//    x =
    
//    最短的列数
    NSUInteger indexColumn = 0;
    CGFloat minColumnHeight = [self.columnHeightArry[0] doubleValue];
    for (int i = 1; i<self.columnHeightArry.count; i++) {
        CGFloat columnheight = [self.columnHeightArry[i] doubleValue];
        if (columnheight < minColumnHeight) {
            minColumnHeight = columnheight;
            indexColumn = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left+ indexColumn*(self.columnMargin+w);
    
    
    CGFloat y = minColumnHeight;
    
    if (y!=self.edgeInsets.top) {
        y +=self.rowMargin;
    }
    
    
//    item的位置大小
    layoutAttri.frame = CGRectMake(x, y, w,h);
    
//    更新最短的列数
    self.columnHeightArry[indexColumn] = @(CGRectGetMaxY(layoutAttri.frame));
    
//    记录内容最高度
    CGFloat contentHeight = [self.columnHeightArry[indexColumn] doubleValue];
    if (self.cellContentViewHeight < contentHeight) {
        self.cellContentViewHeight = contentHeight;
    }
    
    return layoutAttri;
}
//返回整个collectionView的大小
- (CGSize)collectionViewContentSize
{
//    CGFloat maxColumnHeight = [self.columnHeightArry[0] doubleValue];
//    for (int i = 1; i<self.columnHeightArry.count; i++) {
//        CGFloat columnheight = [self.columnHeightArry[i] doubleValue];
//        if (columnheight > maxColumnHeight) {
//            maxColumnHeight = columnheight;
//        }
//    }
    
    return CGSizeMake(0, self.cellContentViewHeight+self.edgeInsets.bottom);
}
@end
