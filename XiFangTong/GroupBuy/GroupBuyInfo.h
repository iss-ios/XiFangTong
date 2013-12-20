//
//  GroupBuyInfo.h
//  XiFangTong
//
//  Created by issuser on 13-8-27.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDXMLElement.h"

@interface GroupBuyInfo : NSObject

@property (copy, nonatomic) NSString *groupBuyID;
@property (copy, nonatomic) NSString *houseLogo;
@property (copy, nonatomic) NSString *houseID;
@property (copy, nonatomic) NSString *sDate;
@property (copy, nonatomic) NSString *eDate;
@property (copy, nonatomic) NSString *housePrice;
@property (copy, nonatomic) NSString *houseAgio;
@property (copy, nonatomic) NSString *houseInfo;
@property (copy, nonatomic) NSString *itemInfo;
@property (copy, nonatomic) NSString *companyInfo;
@property (copy, nonatomic) NSString *mb_logo;
@property (copy, nonatomic) NSString *mb_intro;
@property (copy, nonatomic) NSString *mb_hire1;
@property (copy, nonatomic) NSString *mb_hire2;
@property (copy, nonatomic) NSString *mb_hire3;
@property (copy, nonatomic) NSString *mb_hire4;
@property (copy, nonatomic) NSString *dTime;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *hot;
@property (copy, nonatomic) NSString *pri;
@property (copy, nonatomic) NSString *webOpen;

@property (copy, nonatomic) NSString *houseFullName;
@property (copy, nonatomic) NSString *houseShortName;
@property (copy, nonatomic) NSString *houseAddress;
@property (copy, nonatomic) NSString *houseTuan;
@property (copy, nonatomic) NSString *houseActIntro;

-(id)initWithDDXMLElement:(DDXMLElement *)element;

@end
