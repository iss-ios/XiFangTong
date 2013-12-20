//
//  HouseInfoRequest.m
//  XiFangTong
//
//  Created by issuser on 13-8-22.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "HouseInfoRequest.h"

@implementation HouseInfoRequest
-(void)requestHouseInfoWithID:(NSString *)houseID
{
    [self requestStart:@"GetBulidInfo" parameter:[NSDictionary dictionaryWithObject:houseID forKey:@"houseID"]];
}
- (void)actionRequestSuccessful:(ASIHTTPRequest *)request
{
    
    if (request) {
        
        NSString *data = [request responseString];
        DDXMLDocument *doc = [[DDXMLDocument alloc] initWithXMLString:data options:0 error:nil];
        DDXMLElement* element = [doc rootElement];
        DDXMLElement *item = [element.children objectAtIndex:1];
        DDXMLElement *itemE = [item elementForName:@"NewDataSet"];
        
        for (DDXMLElement *itemElement in itemE.children) {
            HouseInfo *house = [[HouseInfo alloc] initWithDDXMLElement:itemElement];
            if (_delegate) {
                [_delegate houseInfoRequestSuccess:house];
            }
        
        }
    }
}

//超时
-(void)actionRequestFailed:(ASIHTTPRequest *)request
{
    if (_delegate) {
        [_delegate houseInfoRequestFailed:@"请检查网络是否可用后重试！"];
    }
    
}


@end
