//
//  GuessLikeRequest.h
//  XiFangTong
//
//  Created by issuser on 13-8-26.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BaseWebRequest.h"
@protocol GuessLikeRequestDelegate

-(void)guessLikeRequestSuccess:(NSArray *)dataSources;
-(void)guessLikeRequestFailed:(NSString *)message;

@end

@interface GuessLikeRequest : BaseWebRequest
@property (assign, nonatomic) id<GuessLikeRequestDelegate>delegate;

//获取楼盘列表
-(void)requestHouseListWithParameter:(NSDictionary *)para;

@end
