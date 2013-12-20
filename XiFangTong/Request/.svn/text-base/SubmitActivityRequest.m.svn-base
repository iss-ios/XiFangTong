//
//  SubmitActivityRequest.m
//  XiFangTong
//
//  Created by issuser on 13-8-29.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "SubmitActivityRequest.h"

@implementation SubmitActivityRequest
-(void)requestSubmitActivityWithPara:(NSDictionary *)para
{
    [self requestStart:@"SubmitAct" parameter:para];
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
        
        if ([element.stringValue intValue] != 2) {
            if (_delegate) {
                [_delegate submitActivityRequestSuccess:YES];
            }
            
        }
        else{
            [[[[UIApplication sharedApplication] delegate] window] makeToast:@"您已申请该项活动" duration:2.0 position:@"center"];
            
        }        
    }
}

//超时
-(void)actionRequestFailed:(ASIHTTPRequest *)request
{
    if (_delegate) {
        [_delegate submitActivityRequestFailed:@"请检查网络是否可用后重试！"];
    }
    
}

@end
