//
//  HouseDistrictRequest.m
//  XiFangTong
//
//  Created by issuser on 13-8-16.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "HouseDistrictRequest.h"
#import "CommonData.h"
#import "District.h"

@implementation HouseDistrictRequest
-(void)requestHouseDistrict
{
    [self requestStart:@"GetDistrict" parameter:nil];
}

- (void)actionRequestSuccessful:(ASIHTTPRequest *)request
{
    if (request) {
        NSString *data = [request responseString];
        DDXMLDocument *doc = [[DDXMLDocument alloc] initWithXMLString:data options:0 error:nil];
        DDXMLElement* element = [doc rootElement];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (DDXMLElement *item in element.children) {
            District *district = [[District alloc] initWithDDXMLElement:item];
            [array addObject:district];
        }
        if (_delegate) {
            [_delegate houseDistrictRequestSuccess:array];
        }
    }
}

//超时
-(void)actionRequestFailed:(ASIHTTPRequest *)request
{
//    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"请检查网络是否可用" duration:1.0 position:@"bottom"];
    if (_delegate) {
        [_delegate houseDistrictRequestFailed:@"请检查网络是否可用"];
    }

}

@end
