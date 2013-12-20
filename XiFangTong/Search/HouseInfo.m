//
//  HouseInfo.m
//  XiFangTong
//
//  Created by issuser on 13-8-20.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "HouseInfo.h"

@implementation HouseInfo

@synthesize houseID;
@synthesize fullName;
@synthesize shortName;
@synthesize referencePrice;
@synthesize buildAddress;
@synthesize opened;
@synthesize finishDate;
@synthesize tag;
@synthesize maketComment;
@synthesize buildTypeShowIntro;
@synthesize lng;
@synthesize lat;
@synthesize support;
@synthesize manageCorporation;
@synthesize manageMoney;
@synthesize cubage;
@synthesize greenRate;
@synthesize traffic;
@synthesize buildTypeCode;
@synthesize districtID;
@synthesize district;
@synthesize avgPrice;
@synthesize logoPath;
@synthesize imagePath;
@synthesize intro;
@synthesize tuan;
@synthesize actIntro;
@synthesize rowid;
-(id)initWithDDXMLElement:(DDXMLElement *)element
{
    self = [super init];
    if (self) {
        [self setHouseID:[element elementForName:@"ID"].stringValue];
        
        [self setFullName:[element elementForName:@"b_FullName"].stringValue];
        
        [self setShortName:[element elementForName:@"b_ShortName"].stringValue];
        
        [self setReferencePrice:[element elementForName:@"b_ReferencePrice"].stringValue];
        
        [self setBuildAddress:[element elementForName:@"b_BuildAddress"].stringValue];
        
        [self setOpened:[element elementForName:@"b_Opened"].stringValue];
        
        [self setFinishDate:[element elementForName:@"b_FinishDate"].stringValue];
        
        [self setTag:[element elementForName:@"b_Tag"].stringValue];
        
        [self setMaketComment:[element elementForName:@"b_MarketComment"].stringValue];
        
        [self setBuildTypeShowIntro:[element elementForName:@"b_BuildTypeShowIntro"].stringValue];
        
        [self setLng:[element elementForName:@"lng"].stringValue];
        
        [self setLat:[element elementForName:@"lat"].stringValue];
        
        [self setSupport:[element elementForName:@"b_Support"].stringValue];
        
        [self setManageCorporation:[element elementForName:@"b_ManageCorporation"].stringValue];
        
        [self setManageMoney:[element elementForName:@"b_ManageMoney"].stringValue];
        
        [self setCubage:[element elementForName:@"b_Cubage"].stringValue];
        
        [self setGreenRate:[element elementForName:@"b_GreenRate"].stringValue];
        
        [self setTraffic:[element elementForName:@"b_Traffic"].stringValue];
        
        [self setDistrictID:[element elementForName:@"b_DistrictID"].stringValue];
                
        [self setDistrict:[element elementForName:@"b_District"].stringValue];
       
        [self setBuildTypeCode:[element elementForName:@"b_BuildTypeCode"].stringValue];
        
        [self setAvgPrice:[element elementForName:@"avgPrice"].stringValue];
        
        [self setLogoPath:[element elementForName:@"LogoPath"].stringValue];
        
        [self setImagePath:[element elementForName:@"ImagePath"].stringValue];
        
        [self setIntro:[element elementForName:@"Intro"].stringValue];
        
        [self setTuan:[element elementForName:@"Tuan"].stringValue];
        
        [self setActIntro:[element elementForName:@"ActIntro"].stringValue];
        
        [self setRowid:[element elementForName:@"rowid"].stringValue];


    }
    return self;
}
@end
