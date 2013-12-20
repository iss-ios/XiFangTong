//
//  District.m
//  XiFangTong
//
//  Created by issuser on 13-8-15.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "District.h"

@implementation District

@synthesize districtID;
@synthesize districtName;
@synthesize districtOrder;

-(id)initWithDDXMLElement:(DDXMLElement *)element
{
    self = [super init];
    if (self) {
        [self setDistrictID:[element elementForName:@"ID"].stringValue];
        
        [self setDistrictName:[element elementForName:@"b_District"].stringValue];
        [self setDistrictOrder:[element elementForName:@"b_Order"].stringValue];
    }
    return self;
}

@end
