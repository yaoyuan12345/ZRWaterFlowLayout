//
//  ZRCollectionViewCell.m
//  WaterFlowDemo
//
//  Created by etcxm on 16/7/12.
//  Copyright © 2016年 中软国际. All rights reserved.
//

#import "ZRCollectionViewCell.h"
#import "ZRShopModel.h"
#import <UIImageView+WebCache.h>


@interface ZRCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *theImageView;
@property (weak, nonatomic) IBOutlet UILabel *theLabel;



@end


@implementation ZRCollectionViewCell

- (void)setModel:(ZRShopModel *)model
{
    self.theLabel.text = model.price;
    [self.theImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
