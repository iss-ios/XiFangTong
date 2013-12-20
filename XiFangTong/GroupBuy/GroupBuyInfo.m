//
//  GroupBuyInfo.m
//  XiFangTong
//
//  Created by issuser on 13-8-27.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "GroupBuyInfo.h"

@implementation GroupBuyInfo

@synthesize groupBuyID;
@synthesize houseLogo;
@synthesize houseID;
@synthesize sDate;
@synthesize eDate;
@synthesize housePrice;
@synthesize houseAgio;
@synthesize houseInfo;
@synthesize itemInfo;
@synthesize companyInfo;
@synthesize mb_logo;
@synthesize mb_intro;
@synthesize mb_hire1;
@synthesize mb_hire2;
@synthesize mb_hire3;
@synthesize mb_hire4;
@synthesize dTime;
@synthesize state;
@synthesize hot;
@synthesize pri;
@synthesize webOpen;
@synthesize houseFullName;
@synthesize houseShortName;
@synthesize houseAddress;
@synthesize houseTuan;
@synthesize houseActIntro;

-(id)initWithDDXMLElement:(DDXMLElement *)element
{
    self = [super init];
    if (self) {
        [self setGroupBuyID:[element elementForName:@"ID"].stringValue];
        
        [self setHouseLogo:[element elementForName:@"HouseLogo"].stringValue];
        
        [self setHouseID:[element elementForName:@"HouseID"].stringValue];
        
        [self setSDate:[element elementForName:@"sDate"].stringValue];
        
        [self setEDate:[element elementForName:@"eDate"].stringValue];
        
        [self setHousePrice:[element elementForName:@"HousePrice"].stringValue];
        
        [self setHouseAgio:[element elementForName:@"HouseAgio"].stringValue];
        
        [self setHouseInfo:[element elementForName:@"HouseInfo"].stringValue];
        
        [self setItemInfo:[element elementForName:@"ItemInfo"].stringValue];
        
        [self setCompanyInfo:[element elementForName:@"CompanyInfo"].stringValue];
        
        [self setMb_logo:[element elementForName:@"mb_logo"].stringValue];
        
        [self setMb_intro:[element elementForName:@"mb_intro"].stringValue];
        
        [self setMb_hire1:[element elementForName:@"mb_hire1"].stringValue];
        
        [self setMb_hire2:[element elementForName:@"mb_hire2"].stringValue];
        
        [self setMb_hire3:[element elementForName:@"mb_hire3"].stringValue];
        
        [self setMb_hire4:[element elementForName:@"mb_hire4"].stringValue];
        
        [self setDTime:[element elementForName:@"Dtime"].stringValue];
        
        [self setState:[element elementForName:@"State"].stringValue];
        
        [self setHot:[element elementForName:@"Hot"].stringValue];
        
        [self setPri:[element elementForName:@"PRI"].stringValue];
        
        [self setWebOpen:[element elementForName:@"WebOpen"].stringValue];
        
        [self setHouseFullName:[element elementForName:@"b_FullName"].stringValue];
        
        [self setHouseShortName:[element elementForName:@"b_ShortName"].stringValue];
        
        [self setHouseAddress:[element elementForName:@"b_BuildAddress"].stringValue];
        

    }
    return self;
}

@end
