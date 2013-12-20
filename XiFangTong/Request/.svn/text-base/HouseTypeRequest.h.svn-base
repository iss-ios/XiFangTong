//
//  HouseTypeRequest.h
//  XiFangTong
//
//  Created by issuser on 13-8-16.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BaseWebRequest.h"

@protocol HouseTypeRequestDelegate

-(void)houseTypeRequestSuccess:(NSArray *)dataSources;
-(void)houseTypeRequestFailed:(NSString *)message;

@end
@interface HouseTypeRequest : BaseWebRequest
@property (assign, nonatomic) id<HouseTypeRequestDelegate>delegate;

//获取楼盘类型
-(void)requestHouseType;

@end
