//
//  CommonData.m
//  XiFangTong
//
//  Created by issuser on 13-8-16.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "CommonData.h"
#import "District.h"
#import "HouseType.h"

#define NotificationKey @"NotificationTag"

@implementation CommonData

@synthesize houseDistricts;
@synthesize houseTypes;
@synthesize houseFeatures;
@synthesize searchHouseDataSources;

-(BOOL)firstLaunch
{
    BOOL flaunch;
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    if (![userdefaults boolForKey:@"everLaunched"]) {
        [userdefaults setBool:YES forKey:@"everLaunched"];
        [userdefaults setBool:YES forKey:@"firstLaunch"];
        
        
        NSString *s = @"";
        [userdefaults setValue:s forKey:GuessDistrictKey];
        [userdefaults setValue:s forKey:GuessAvgPriceKey];
        [userdefaults setValue:s forKey:GuessTagKey];

        [userdefaults setValue:s forKey:HomeImageRefreshTime];
        [userdefaults setValue:s forKey:GuideImageRefreshTime];
        [userdefaults setValue:s forKey:HomeLocalImageName];
        [userdefaults setValue:s forKey:GuideLocalImageName];
        
        [userdefaults synchronize];
        flaunch = YES;
        
    }
    else{
        [userdefaults setBool:NO forKey:@"firstLaunch"];
        flaunch = NO;
    }
    return flaunch;
}
#pragma mark -
#pragma mark
-(void)downloadHouseInfos
{
    //获取楼盘区域、特色、类型数据
    districtRequest = [[HouseDistrictRequest alloc] init];
    [districtRequest setDelegate:self];
    
    featureRequest = [[HouseFeatureRequest alloc] init];
    [featureRequest setDelegate:self];
    
    typeRequest = [[HouseTypeRequest alloc] init];
    [typeRequest setDelegate:self];
    if (houseDistricts.count == 0) {
        [districtRequest requestHouseDistrict];
    }
    if (houseFeatures.count == 0) {
        [featureRequest requestHouseFeature];
    }
    if (houseTypes.count == 0) {
        [typeRequest requestHouseType];
    }
}
-(void)houseDistrictRequestSuccess:(NSArray *)dataSources
{
    if (dataSources.count != 0) {
        [houseDistricts removeAllObjects];
    }
    houseDistricts = [[NSMutableArray alloc] initWithArray:dataSources];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetHouseDistricts" object:self userInfo:[NSDictionary dictionaryWithObject:@"district" forKey:NotificationKey]];
}
-(void)houseDistrictRequestFailed:(NSString *)message
{
    [districtRequest requestHouseDistrict];
}
-(void)houseFeatureRequestSuccess:(NSArray *)dataSources
{
    if (dataSources.count != 0) {
        [houseFeatures removeAllObjects];
    }
    houseFeatures = [[NSMutableArray alloc] initWithArray:dataSources];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetHouseFeatures" object:self userInfo:[NSDictionary dictionaryWithObject:@"feature" forKey:NotificationKey]];
}
-(void)houseFeatureRequestFailed:(NSString *)message
{
    [featureRequest requestHouseFeature];
}
-(void)houseTypeRequestSuccess:(NSArray *)dataSources
{
    if (dataSources.count != 0) {
        [houseTypes removeAllObjects];
    }
    houseTypes = [[NSMutableArray alloc] initWithArray:dataSources];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetHouseTypes" object:self userInfo:[NSDictionary dictionaryWithObject:@"type" forKey:NotificationKey]];
}
-(void)houseTypeRequestFailed:(NSString *)message
{
    [typeRequest requestHouseType];
}
#pragma mark -
#pragma mark
-(NSString *)getDistrictName:(NSInteger)dId
{
    for (District *district in houseDistricts) {
        if ([district.districtID integerValue] == dId) {
            return district.districtName ;
            break;
        }
    }
    return @"";
}
-(NSInteger)getDistrictID:(NSString *)name
{
    for (District *district in houseDistricts) {
        if ([district.districtName isEqualToString:name]) {
            return [district.districtID integerValue];
            break;
        }
    }
    return 0;
}
-(NSInteger)getTypeID:(NSString *)name
{
    for (HouseType *type in houseTypes) {
        if ([type.typeName isEqualToString:name]) {
            return [type.typeID integerValue];
            break;
        }
    }
    return 0;
}
-(void)phoneCall
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"您确认要拨打电话81889555?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self telephoneCall];
    }
}
-(void)telephoneCall{
    
    NSURL *telURL = [NSURL URLWithString:@"tel://051081889555"];
    [[UIApplication sharedApplication] openURL:telURL];
}
#pragma mark -
#pragma mark init
-(void)initWithCustom
{
    houseDistricts = [[NSMutableArray alloc] init];
    houseTypes = [[NSMutableArray alloc] init];
    houseFeatures = [[NSMutableArray alloc] init];
    searchHouseDataSources = [[NSMutableArray alloc] init];
    
}

static CommonData * instance = nil;
+(CommonData *)Instance
{
    @synchronized(self)
    {
        if (nil == instance)
        {
            [[self alloc] initWithCustom];
        }
    }
    return instance;
}
+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

@end
