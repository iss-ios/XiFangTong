//
//  HouseTypeRequest.m
//  XiFangTong
//
//  Created by issuser on 13-8-16.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "HouseTypeRequest.h"
#import "HouseType.h"

@implementation HouseTypeRequest
-(void)requestHouseType
{
    [self requestStart:@"GetBulidType" parameter:nil];
}
- (void)actionRequestSuccessful:(ASIHTTPRequest *)request
{
    
    
    if (request) {
        NSString *data = [request responseString];
        DDXMLDocument *doc = [[DDXMLDocument alloc] initWithXMLString:data options:0 error:nil];
        DDXMLElement* element = [doc rootElement];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (DDXMLElement *item in element.children) {
            HouseType *type = [[HouseType alloc] initWithDDXMLElement:item];
            [array addObject:type];
        }
        if (_delegate) {
            [_delegate houseTypeRequestSuccess:array];
        }
//        [[CommonData Instance] setHouseTypes:array];
    }
}

//超时
-(void)actionRequestFailed:(ASIHTTPRequest *)request
{
//    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"请检查网络是否可用" duration:1.0 position:@"bottom"];
    if (_delegate) {
        [_delegate houseTypeRequestFailed:@"请检查网络是否可用"];
    }
}


@end
