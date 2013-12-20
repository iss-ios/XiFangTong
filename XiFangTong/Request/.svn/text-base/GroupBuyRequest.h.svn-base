//
//  GroupBuyRequest.h
//  XiFangTong
//
//  Created by issuser on 13-8-27.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BaseWebRequest.h"
@protocol GroupBuyRequestDelegate

-(void)groupBuyRequestSuccess:(NSArray *)dataSources;
-(void)groupBuyRequestFailed:(NSString *)message;

@end
@interface GroupBuyRequest : BaseWebRequest

@property (assign, nonatomic) id<GroupBuyRequestDelegate>delegate;

//获取楼盘列表
-(void)requestGroupBuyListWithDate:(NSString *)curDate;

@end
