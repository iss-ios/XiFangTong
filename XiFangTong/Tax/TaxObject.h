//
//  TaxObject.h
//  XiFangTong
//
//  Created by issuser on 13-8-30.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    kNormalType,//普通住宅
    kUnNormalType,//非普通住宅
    kSpecailType//非住宅
}HouseType;
typedef enum
{
    kWithLift,//有电梯
    kWithoutLift//无电梯
}WithLift;
typedef enum
{
    kOnlySmall,//小于等于90平方米且唯一住房
    kOnlyBig,//90~144平米且唯一住房
    kNotOnly//非唯一住房
}HouseIsOnly;
@interface TaxObject : NSObject
@property (copy, nonatomic) NSString   *houseUnitPrice;//房子单价
@property (copy, nonatomic) NSString   *houseArea;//房子面积
@property (nonatomic)       HouseType  houseType;
@property (nonatomic)       WithLift   withLift;
@property (nonatomic)       HouseIsOnly houseIsOnly;
@property (copy, nonatomic) NSString    *houseTotalPrice;
@property (copy, nonatomic) NSString    *stampTax;//合同印花税
@property (copy, nonatomic) NSString    *propertyCosts;//物业维修资金
@property (copy, nonatomic) NSString    *deedTax;//契税

-(void)countTax;

@end
