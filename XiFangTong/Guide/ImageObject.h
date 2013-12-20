//
//  ImageObject.h
//  XiFangTong
//
//  Created by issuser on 13-11-5.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageObject : NSObject

@property (copy, nonatomic) NSString *imageID;
@property (copy, nonatomic) NSString *cate;
@property (copy, nonatomic) NSString *imageTitle;
@property (copy, nonatomic) NSString *imageUrl;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *dTime;
@property (copy,nonatomic)  NSString *webOpen;

-(id)initWithDDXMLElement:(DDXMLElement *)element;

@end
