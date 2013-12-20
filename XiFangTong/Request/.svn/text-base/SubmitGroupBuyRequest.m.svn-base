//
//  SubmitGroupBuyRequest.m
//  XiFangTong
//
//  Created by issuser on 13-8-30.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "SubmitGroupBuyRequest.h"

@implementation SubmitGroupBuyRequest
-(void)requestSubmitGroupBuyWithPara:(NSDictionary *)para
{
    [self requestStart:@"SubmitTuan" parameter:para];
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
        
        if ([element.stringValue intValue]!=2) {
            if (_delegate) {
                [_delegate submitGroupBuyRequestSuccess:YES];
            }
        }
        else{
            [[[[UIApplication sharedApplication] delegate] window] makeToast:@"您已申请该项团购" duration:2.0 position:@"center"];
        }
    }
}

//超时
-(void)actionRequestFailed:(ASIHTTPRequest *)request
{
    if (_delegate) {
        [_delegate submitGroupBuyRequestFailed:@"请检查网络是否可用后重试！"];
    }
}
    
@end
