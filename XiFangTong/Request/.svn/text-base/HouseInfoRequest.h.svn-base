//
//  HouseInfoRequest.h
//  XiFangTong
//
//  Created by issuser on 13-8-22.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BaseWebRequest.h"
#import "HouseInfo.h"

@protocol HouseInfoRequestDelegate

-(void)houseInfoRequestSuccess:(HouseInfo *)houseInfo;
-(void)houseInfoRequestFailed:(NSString *)message;

@end


@interface HouseInfoRequest : BaseWebRequest

@property (assign, nonatomic) id<HouseInfoRequestDelegate>delegate;
//获取楼盘列表
-(void)requestHouseInfoWithID:(NSString *)houseID;

@end
