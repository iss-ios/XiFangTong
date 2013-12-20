//
//  ImageObject.m
//  XiFangTong
//
//  Created by issuser on 13-11-5.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "ImageObject.h"
//    <ds diffgr:id="ds1" msdata:rowOrder="0">
//    <ID>1</ID>
//    <Cate>HomeAD</Cate>
//    <Title>下载锡房团app</Title>
//    <Imgage_Url>201310/10/213798417622627.jpg</Imgage_Url>
//    <Content>下载锡房团app客户端，赢万元大礼</Content>
//    <Dtime>2013-10-09T16:51:32.653+08:00</Dtime>
//    <WebOpen>1</WebOpen>
//    </ds>
@implementation ImageObject

@synthesize imageID;
@synthesize cate;
@synthesize imageTitle;
@synthesize imageUrl;
@synthesize content;
@synthesize dTime;
@synthesize webOpen;

-(id)initWithDDXMLElement:(DDXMLElement *)element
{
    self = [super init];
    if (self) {
        
        [self setImageID:[element elementForName:@"ID"].stringValue];
        [self setCate:[element elementForName:@"Cate"].stringValue];
        [self setImageTitle:[element elementForName:@"Title"].stringValue];
        [self setImageUrl:[element elementForName:@"Imgage_Url"].stringValue];
        [self setContent:[element elementForName:@"Content"].stringValue];
        [self setDTime:[element elementForName:@"Dtime"].stringValue];
        [self setWebOpen:[element elementForName:@"WebOpen"].stringValue];
    }
    return self;
}

@end
