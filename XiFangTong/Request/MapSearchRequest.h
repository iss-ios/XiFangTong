//
//  MapSearchRequest.h
//  XiFangTong
//
//  Created by issuser on 13-10-25.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BaseWebRequest.h"

@protocol MapSearchRequestDelegate

-(void)mapSearchRequestSuccess:(NSArray *)dataSources;
-(void)mapSearchRequestFailed:(NSString *)message;

@end

@interface MapSearchRequest : BaseWebRequest

@property (assign, nonatomic) id<MapSearchRequestDelegate>delegate;
//获取楼盘列表
-(void)requestMapHouseListWithParameter:(NSDictionary *)para showToast:(BOOL)show;

@end
