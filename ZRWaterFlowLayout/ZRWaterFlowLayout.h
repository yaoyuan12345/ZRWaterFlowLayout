//
//  ZRWaterFlowLayout.h
//  WaterFlowDemo
//
//  Created by etcxm on 16/7/12.
//  Copyright © 2016年 中软国际. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZRWaterFlowLayout;
@protocol ZRWaterFlowLayoutDelegate <NSObject>
@required
//返回item的高度   根据（图片的宽度、图片的高度、item的宽度）返回item的高度
- (NSInteger)zrWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout heightRowOfIndex:(NSInteger)index withItemWidth:(CGFloat )width;
@optional

// ---- 瀑布流的列数
- (CGFloat)columnCountInWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout;

// ---- 瀑布流的列间距
- (CGFloat)columnMarginInWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout;

// ---- 瀑布流的行间距
- (CGFloat)rowMarginInWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout;

// ---- 整个瀑布流的内边距
- (UIEdgeInsets)edgeInsetInWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout;



@end



@interface ZRWaterFlowLayout : UICollectionViewLayout

@property(nonatomic,weak) id<ZRWaterFlowLayoutDelegate> delegate;

///*所有的图片资源*/
//@property(nonatomic,strong) NSMutableArray *theShopModelArry;



@end
