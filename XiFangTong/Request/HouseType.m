//
//  HouseType.m
//  XiFangTong
//
//  Created by issuser on 13-9-10.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "HouseType.h"

@implementation HouseType

@synthesize typeID;
@synthesize typeName;
@synthesize typeOrder;

-(id)initWithDDXMLElement:(DDXMLElement *)element
{
    self = [super init];
    if (self) {
        [self setTypeID:[element elementForName:@"ID"].stringValue];
        
        [self setTypeName:[element elementForName:@"b_BuildType"].stringValue];
       
        [self setTypeOrder:[element elementForName:@"b_Order"].stringValue];
    }
    return self;
}

@end
