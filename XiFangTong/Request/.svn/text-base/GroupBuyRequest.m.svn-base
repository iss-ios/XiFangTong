//
//  GroupBuyRequest.m
//  XiFangTong
//
//  Created by issuser on 13-8-27.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "GroupBuyRequest.h"
#import "GroupBuyInfo.h"

@implementation GroupBuyRequest
-(void)requestGroupBuyListWithDate:(NSString *)curDate
{
    
    [self requestStart:@"GetTuanList" parameter:[NSDictionary dictionaryWithObject:curDate forKey:@"curDate"]];
    
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
            GroupBuyInfo *info = [[GroupBuyInfo alloc] initWithDDXMLElement:itemElement];
            [array addObject:info];
        }
        if (_delegate) {
            [_delegate groupBuyRequestSuccess:array];
        }
        
    }
}

//超时
-(void)actionRequestFailed:(ASIHTTPRequest *)request
{
    if (_delegate) {
        [_delegate groupBuyRequestFailed:@"请检查网络是否可用后重试！"];
    }
    
}

@end
