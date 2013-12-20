//
//  Constant.h
//  EFreeCard_Manager
//
//  Created by iss on 5/15/13.
//  Copyright (c) 2013 iss. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Constant <NSObject>

// debug server.
//#define SERVICE_WEBSERVICE_URL @"http://10.44.53.163/xft/MobileWS.asmx"
#define SERVICE_WEBSERVICE_URL @"http://www.wxhouse.com/xftpub/MobileWS.asmx"

#define ImagePathURL           @"http://www.wxhouse.com/UploadFiles/"    
#define HomeADURL              @"HomeAD"
#define HomeImageRefreshed     @"HomeImageRefreshed"
#define HomeImageRefreshTime   @"HomeImageRefreshTime"
#define GuideImageRefreshed    @"GuideImageRefreshed"
#define GuideImageRefreshTime  @"GuideImageRefreshTime"
#define HomeLocalImageName     @"HomeLocalImage"
#define GuideLocalImageName    @"GuideLocalImage"
#define AboutUsURL             @"About"
#define GuideURL               @"Guide"
#define GuessDistrictKey       @"GuessDistrict"
#define GuessTagKey            @"GuessTag"
#define GuessAvgPriceKey       @"GuessAvgPrice"
#define HouseLogoDefault       @"house_logo_default.png"
#define BigLogoDefault         @"other_logo_default.png"
#define BigLogoDefaultRetina   @"other_logo_default_2.png"
#define HouseDetailLogoDefault @"house_detail_logo_default.png"

//http://10.44.53.8:8040/MobileWS.asmx
@end
