//
//  SubmitGroupBuyRequest.h
//  XiFangTong
//
//  Created by issuser on 13-8-30.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BaseWebRequest.h"
@protocol SubmitGroupBuyRequestDelegate

-(void)submitGroupBuyRequestSuccess:(BOOL )success;
-(void)submitGroupBuyRequestFailed:(NSString *)message;

@end

@interface SubmitGroupBuyRequest : BaseWebRequest
@property (assign, nonatomic) id<SubmitGroupBuyRequestDelegate>delegate;

-(void)requestSubmitGroupBuyWithPara:(NSDictionary *)para;

@end
