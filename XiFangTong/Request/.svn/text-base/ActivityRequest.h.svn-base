//
//  ActivityRequest.h
//  XiFangTong
//
//  Created by issuser on 13-8-27.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BaseWebRequest.h"
@protocol ActivityRequestDelegate

-(void)activityRequestSuccess:(NSArray *)dataSources;
-(void)activityRequestFailed:(NSString *)message;

@end

@interface ActivityRequest : BaseWebRequest
@property (assign, nonatomic) id<ActivityRequestDelegate>delegate;

//获取楼盘列表
-(void)requestActivityList;

@end
