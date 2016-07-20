//
//  ZRShopModel.h
//  WaterFlowDemo
//
//  Created by etcxm on 16/7/12.
//  Copyright © 2016年 中软国际. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRShopModel : NSObject

///*<#注释#>*/
//@property(nonatomic,strong) <#type#> *<#name#>;

/*图片高度*/
@property(nonatomic,assign) NSInteger h;
/*图片宽度*/
@property(nonatomic,assign) NSInteger w;
/*图片地址*/
@property(nonatomic,copy) NSString *img;
/*图片价格*/
@property(nonatomic,copy) NSString *price;





@end
