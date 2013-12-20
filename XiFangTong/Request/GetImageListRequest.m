//
//  GetImageListRequest.m
//  XiFangTong
//
//  Created by issuser on 13-8-26.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "GetImageListRequest.h"

@implementation GetImageListRequest
-(void)requestImageListWithCategory:(NSString *)category
{
    [self requestStart:@"GetImageList" parameter:[NSDictionary dictionaryWithObject:category forKey:@"category"]];
}
- (void)actionRequestSuccessful:(ASIHTTPRequest *)request
{
//    <ds diffgr:id="ds1" msdata:rowOrder="0">
//    <ID>1</ID>
//    <Cate>HomeAD</Cate>
//    <Title>下载锡房团app</Title>
//    <Imgage_Url>201310/10/213798417622627.jpg</Imgage_Url>
//    <Content>下载锡房团app客户端，赢万元大礼</Content>
//    <Dtime>2013-10-09T16:51:32.653+08:00</Dtime>
//    <WebOpen>1</WebOpen>
//    </ds>
    
    if (request) {
        NSString *data = [request responseString];
        DDXMLDocument *doc = [[DDXMLDocument alloc] initWithXMLString:data options:0 error:nil];
        DDXMLElement* element = [doc rootElement];
        DDXMLElement *item = [element.children objectAtIndex:1];
        DDXMLElement *itemE = [item elementForName:@"NewDataSet"];
        if (itemE == nil) {
            if (_delegate) {
                [_delegate getImageListRequestSuccess:nil];
            }
        }
        for (DDXMLElement *itemElement in itemE.children) {
            ImageObject *imageO = [[ImageObject alloc] initWithDDXMLElement:itemElement];
            //Imgage_Url[itemElement elementForName:@"Imgage_Url"].stringValue
            if (_delegate) {
                [_delegate getImageListRequestSuccess:imageO];
            }
        
        }
    }
}

//超时
-(void)actionRequestFailed:(ASIHTTPRequest *)request
{
    if (_delegate) {
        [_delegate getImageListRequestFailed:@"请检查网络是否可用后重试！"];
    }
}


@end
