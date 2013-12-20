//
//  SearchHouseRequest.h
//  XiFangTong
//
//  Created by issuser on 13-8-19.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BaseWebRequest.h"

@protocol SearchHouseRequestDelegate

-(void)searchHouseRequestSuccess:(NSArray *)dataSources;
-(void)searchHouseRequestFailed:(NSString *)message;

@end

@interface SearchHouseRequest : BaseWebRequest
@property (assign, nonatomic) id<SearchHouseRequestDelegate>delegate;
//获取楼盘列表
-(void)requestHouseListWithParameter:(NSDictionary *)para showToast:(BOOL)show;

@end
