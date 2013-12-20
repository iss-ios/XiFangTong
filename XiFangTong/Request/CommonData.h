//
//  CommonData.h
//  XiFangTong
//
//  Created by issuser on 13-8-16.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HouseDistrictRequest.h"
#import "HouseFeatureRequest.h"
#import "HouseTypeRequest.h"

@interface CommonData : NSObject<HouseDistrictRequestDelegate,HouseFeatureRequestDelegate,HouseTypeRequestDelegate>
{
    HouseDistrictRequest *districtRequest;
    HouseFeatureRequest  *featureRequest;
    HouseTypeRequest     *typeRequest;
}
@property (strong, nonatomic) NSMutableArray *houseDistricts;
@property (strong, nonatomic) NSMutableArray *houseTypes;
@property (strong, nonatomic) NSMutableArray *houseFeatures;
@property (strong, nonatomic) NSMutableArray *searchHouseDataSources;

-(void)downloadHouseInfos;

-(BOOL)firstLaunch;
-(NSInteger)getDistrictID:(NSString *)name;
-(NSString *)getDistrictName:(NSInteger)dId;
-(NSInteger)getTypeID:(NSString *)name;
-(void)phoneCall;

+(CommonData *) Instance;
+(id)allocWithZone:(NSZone *)zone;

@end
