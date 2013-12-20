//
//  HouseType.h
//  XiFangTong
//
//  Created by issuser on 13-9-10.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDXMLElement.h"
@interface HouseType : NSObject

@property (copy, nonatomic) NSString *typeID;
@property (copy, nonatomic) NSString *typeName;
@property (copy, nonatomic) NSString *typeOrder;

-(id)initWithDDXMLElement:(DDXMLElement *)element;

@end
