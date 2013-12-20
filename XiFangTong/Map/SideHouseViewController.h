//
//  SideHouseViewController.h
//  XiFangTong
//
//  Created by issuser on 13-8-23.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BasedViewController.h"
#import "KYBubbleView.h"
#import "KYPointAnnotation.h"
#import "SearchHouseRequest.h"
#import "HouseInfo.h"

@interface SideHouseViewController : BasedViewController<BMKMapViewDelegate,BMKSearchDelegate,SearchHouseRequestDelegate,KYBubbleViewDelegate>
{
    IBOutlet BMKMapView *myMapView;
    BMKSearch *_search;
    
    KYBubbleView *bubbleView;
    
    CLLocationCoordinate2D currentCoordinate;
    SearchHouseRequest *searchRequest;
    NSMutableArray *houseList;
    NSMutableArray *annotationArray;
    
    BOOL unclean;
    BOOL changeRegionUnRefresh;
}

@property (strong, nonatomic) HouseInfo *houseInfo;


@end
