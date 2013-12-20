//
//  BaseWebRequest.m
//  EFreeCard_Manager
//
//  Created by iss on 5/29/13.
//  Copyright (c) 2013 iss. All rights reserved.
//

#import "BaseWebRequest.h"

@implementation BaseWebRequest

#define DES3_KEY @"b9de309f8c9491891f845845"



-(void) requestStart:(NSString*)_method parameter:(NSDictionary*)_para
{
    NSString *encryptedUrl = [NSString stringWithFormat:@"%@/%@", SERVICE_WEBSERVICE_URL, _method];

    
    if (mRequest != nil) {
        [mRequest clearDelegatesAndCancel];
        mRequest = nil;
    }
    
    mRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:encryptedUrl]];
    [mRequest setDelegate:self];
    [mRequest setRequestMethod:@"POST"];
	[mRequest addRequestHeader:@"Content-Type" value:  @"text/xml; charset=utf-8" ];
    [mRequest buildRequestHeaders];
    [mRequest setTimeOutSeconds:10.0];
    [mRequest setNumberOfTimesToRetryOnTimeout:1]; // 超时重试1次。
    [mRequest setShouldAttemptPersistentConnection:NO];
//    [mRequest setResponseEncoding:NSUTF8StringEncoding];
    if (_para != nil) {
        NSEnumerator *enumerator = [_para keyEnumerator];
        id key;
        
        while ((key = [enumerator nextObject])) {
           [mRequest setPostValue:[_para objectForKey:key] forKey:key];
        }
    }
    [mRequest setDidFailSelector:@selector(requestFailedComplete:)];
    [mRequest setDidFinishSelector:@selector(requestSuccessComplete:)];

    [mRequest startAsynchronous];
}

//请求成功
- (void)requestSuccessComplete:(ASIHTTPRequest *)request
{
    if (request) {
        
        [self performSelector:@selector(actionRequestSuccessful:) withObject:request];
        [[[[UIApplication sharedApplication] delegate] window] hideToastActivity];
//        NSLog(@"接口返回：%@",[request responseString]);
    }else{
        NSLog(@"resquest has been released");
    }
}
//请求失败
- (void)requestFailedComplete:(ASIHTTPRequest *)request
{
    if (request) {
        [[[[UIApplication sharedApplication] delegate] window] hideToastActivity];
        [self performSelector:@selector(actionRequestFailed:) withObject:request];
    }else{
        NSLog(@"resquest has been released");
    }
}

-(void)dealloc
{
    [mRequest clearDelegatesAndCancel];
    [[[[UIApplication sharedApplication] delegate] window] hideToastActivity];
    
}
@end