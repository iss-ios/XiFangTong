//
//  ActivityInfoRequest.h
//  XiFangTong
//
//  Created by issuser on 13-8-29.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BaseWebRequest.h"
@protocol ActivityInfoRequestDelegate

-(void)activityInfoRequestSuccess:(NSArray *)dataSources;
-(void)activityInfoRequestFailed:(NSString *)message;

@end

@interface ActivityInfoRequest : BaseWebRequest

@property (assign, nonatomic) id<ActivityInfoRequestDelegate>delegate;

-(void)requestActivityInfoWithHouseID:(NSString *)houseID;

@end
