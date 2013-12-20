//
//  HouseFeatureRequest.m
//  XiFangTong
//
//  Created by issuser on 13-8-16.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "HouseFeatureRequest.h"

@implementation HouseFeatureRequest
-(void)requestHouseFeature
{
    [self requestStart:@"GetTagList" parameter:nil];
}
- (void)actionRequestSuccessful:(ASIHTTPRequest *)request
{
    
    if (request) {
        NSString *data = [request responseString];
        DDXMLDocument *doc = [[DDXMLDocument alloc] initWithXMLString:data options:0 error:nil];
        DDXMLElement* element = [doc rootElement];
        
        NSMutableArray *array2 = [[NSMutableArray alloc] init];
        for (DDXMLElement *item in element.children) {
            
            [array2 addObject:item.stringValue];
        }
        if (_delegate) {
            [_delegate houseFeatureRequestSuccess:array2];
        }
//        [[CommonData Instance] setHouseFeatures:array2];
    }
}

//超时
-(void)actionRequestFailed:(ASIHTTPRequest *)request
{
    if (_delegate) {
        [_delegate houseFeatureRequestFailed:@"请检查网络是否可用"];
    }
//    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"请检查网络是否可用" duration:1.0 position:@"bottom"];
}


@end
