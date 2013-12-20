//
//  GuessLikeRequest.m
//  XiFangTong
//
//  Created by issuser on 13-8-26.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "GuessLikeRequest.h"
#import "HouseInfo.h"

@implementation GuessLikeRequest
-(void)requestHouseListWithParameter:(NSDictionary *)para
{
    [self requestStart:@"Guess" parameter:para];
    
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
            HouseInfo *house = [[HouseInfo alloc] initWithDDXMLElement:itemElement];
            [array addObject:house];
        }
        if (_delegate) {
            [_delegate guessLikeRequestSuccess:array];
        }
        
    }
}

//超时
-(void)actionRequestFailed:(ASIHTTPRequest *)request
{
    if (_delegate) {
        [_delegate guessLikeRequestFailed:@"请检查网络是否可用后重试！"];
    }
    
}


@end
