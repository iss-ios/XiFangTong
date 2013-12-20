//
//  MapViewController.h
//  XiFangTong
//
//  Created by issuser on 13-7-31.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasedViewController.h"
#import "KYBubbleView.h"
#import "KYPointAnnotation.h"
#import "MapSearchRequest.h"
#import "HouseInfo.h"

@interface MapViewController : BasedViewController<BMKMapViewDelegate,BMKSearchDelegate,MapSearchRequestDelegate,KYBubbleViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet BMKMapView *myMapView;
    IBOutlet UITableView *table;
    IBOutlet UIButton *locateButton;
    
    BMKSearch *_search;
    
    KYBubbleView *bubbleView;

    CLLocationCoordinate2D currentCoordinate;
    MapSearchRequest *searchRequest;
    
}

@property (strong, nonatomic) HouseInfo *houseInfo;
@property (nonatomic) BOOL backToRoot;
-(void)onClickRight:(id)sender;
-(void)onClickBack:(id)sender;

@end
