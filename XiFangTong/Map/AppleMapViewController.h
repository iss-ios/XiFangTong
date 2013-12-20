//
//  AppleMapViewController.h
//  XiFangTong
//
//  Created by issuser on 13-9-17.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BasedViewController.h"
#import <MapKit/MapKit.h>
#import "AKYBubbleView.h"
#import "SearchHouseRequest.h"
#import "HouseInfo.h"

@interface AppleMapViewController : BasedViewController<MKMapViewDelegate,SearchHouseRequestDelegate,AKYBubbleViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet MKMapView *myMapView;
    IBOutlet UITableView *table;
    IBOutlet UIButton *locateButton;
    
    BMKSearch *_search;
    
    AKYBubbleView *bubbleView;
    
    CLLocationCoordinate2D currentCoordinate;
    SearchHouseRequest *searchRequest;
    NSMutableArray *houseList;
    NSMutableArray *annotationArray;
    
    BOOL unclean;
    BOOL changeRegionUnRefresh;
    
}

@property (strong, nonatomic) HouseInfo *houseInfo;
-(void)onClickRight:(id)sender;
-(void)onClickBack:(id)sender;


@end
