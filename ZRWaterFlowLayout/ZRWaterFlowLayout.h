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
//返回item的高度
- (NSInteger)zrWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout heightRowOfIndex:(NSInteger)index withItemWidth:(CGFloat )width;
@optional
- (CGFloat)columnCountInWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout;

- (CGFloat)columnMarginInWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout;

- (CGFloat)rowMarginInWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout;

- (UIEdgeInsets)edgeInsetInWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout;



@end



@interface ZRWaterFlowLayout : UICollectionViewLayout

@property(nonatomic,weak) id<ZRWaterFlowLayoutDelegate> delegate;

///*所有的图片资源*/
//@property(nonatomic,strong) NSMutableArray *theShopModelArry;



@end
