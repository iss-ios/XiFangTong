//
//  District.h
//  XiFangTong
//
//  Created by issuser on 13-8-15.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDXMLElement.h"

@interface District : NSObject

@property (copy, nonatomic) NSString *districtID;
@property (copy, nonatomic) NSString *districtName;
@property (copy, nonatomic) NSString *districtOrder;

-(id)initWithDDXMLElement:(DDXMLElement *)element;

@end
