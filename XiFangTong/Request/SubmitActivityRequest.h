//
//  SubmitActivityRequest.h
//  XiFangTong
//
//  Created by issuser on 13-8-29.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BaseWebRequest.h"
@protocol SubmitActivityRequestDelegate

-(void)submitActivityRequestSuccess:(BOOL )success;
-(void)submitActivityRequestFailed:(NSString *)message;

@end
@interface SubmitActivityRequest : BaseWebRequest

@property (assign, nonatomic) id<SubmitActivityRequestDelegate>delegate;

-(void)requestSubmitActivityWithPara:(NSDictionary *)para;
@end
