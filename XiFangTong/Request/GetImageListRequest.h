//
//  GetImageListRequest.h
//  XiFangTong
//
//  Created by issuser on 13-8-26.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BaseWebRequest.h"
#import "ImageObject.h"
@protocol GetImageListRequestDelegate

-(void)getImageListRequestSuccess:(ImageObject *)imageObject;
-(void)getImageListRequestFailed:(NSString *)message;

@end

@interface GetImageListRequest : BaseWebRequest

@property (assign, nonatomic) id<GetImageListRequestDelegate>delegate;

-(void)requestImageListWithCategory:(NSString *)category;

@end
