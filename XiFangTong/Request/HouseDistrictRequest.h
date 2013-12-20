//
//  HouseDistrictRequest.h
//  XiFangTong
//
//  Created by issuser on 13-8-16.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BaseWebRequest.h"

@protocol HouseDistrictRequestDelegate

-(void)houseDistrictRequestSuccess:(NSArray *)dataSources;
-(void)houseDistrictRequestFailed:(NSString *)message;

@end
@interface HouseDistrictRequest : BaseWebRequest

@property (assign, nonatomic) id<HouseDistrictRequestDelegate>delegate;

//获取楼盘区域
-(void)requestHouseDistrict;

@end
