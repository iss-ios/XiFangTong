//
//  ActivityInfoRequest.m
//  XiFangTong
//
//  Created by issuser on 13-8-29.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "ActivityInfoRequest.h"

@implementation ActivityInfoRequest
-(void)requestActivityInfoWithHouseID:(NSString *)houseID
{
    [self requestStart:@"GetActInfo" parameter:[NSDictionary dictionaryWithObject:houseID forKey:@"houseID"]];
}
- (void)actionRequestSuccessful:(ASIHTTPRequest *)request
{
    
    if (request) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        if (array.count != 0) {
            [array removeAllObjects];
        }
        NSString *data = [request responseString];
        DDXMLDocument *doc = [[DDXMLDocument alloc] initWithXMLString:data options:0 error:nil];
        DDXMLElement* element = [doc rootElement];
        DDXMLElement *item = [element.children objectAtIndex:1];
        DDXMLElement *itemE = [item elementForName:@"NewDataSet"];
        
        for (DDXMLElement *itemElement in itemE.children) {
//            ActivityInfo *activity = [[ActivityInfo alloc] initWithDDXMLElement:itemElement];
//            [array addObject:activity];
        }
        if (_delegate) {
            [_delegate activityInfoRequestSuccess:array];
        }
        
    }
}

//超时
-(void)actionRequestFailed:(ASIHTTPRequest *)request
{
    if (_delegate) {
        [_delegate activityInfoRequestFailed:@"请检查网络是否可用后重试！"];
    }
    
}

@end
