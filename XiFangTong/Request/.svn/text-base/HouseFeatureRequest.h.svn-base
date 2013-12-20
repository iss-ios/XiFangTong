//
//  HouseFeatureRequest.h
//  XiFangTong
//
//  Created by issuser on 13-8-16.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BaseWebRequest.h"

@protocol HouseFeatureRequestDelegate

-(void)houseFeatureRequestSuccess:(NSArray *)dataSources;
-(void)houseFeatureRequestFailed:(NSString *)message;

@end

@interface HouseFeatureRequest : BaseWebRequest
@property (assign, nonatomic) id<HouseFeatureRequestDelegate>delegate;
//获取楼盘特色
-(void)requestHouseFeature;

@end
