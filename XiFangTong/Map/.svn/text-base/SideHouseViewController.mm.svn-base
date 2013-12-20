//
//  SideHouseViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-23.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "SideHouseViewController.h"
#import "HouseDetailViewController.h"

static CGFloat kTransitionDuration = 0.45f;

@interface SideHouseViewController ()

@end

@implementation SideHouseViewController

@synthesize houseInfo;

#pragma mark -
#pragma mark view
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //BMKMapView
    myMapView.zoomLevel = 14;
    [myMapView setDelegate:self];
    
    //BMKSearch
    _search = [[BMKSearch alloc] init];
    _search.delegate = self;
    
    //Request
    searchRequest = [[SearchHouseRequest alloc] init];
    [searchRequest setDelegate:self];
    houseList = [[NSMutableArray alloc] init];
    annotationArray = [[NSMutableArray alloc] init];
    
    [[[[UIApplication sharedApplication] delegate] window] makeToastActivity];
    if (houseInfo != nil && ![houseInfo.lng isEqualToString:@"0"] && ![houseInfo.lat isEqualToString:@"0"]) {
        CLLocation *loction = [[CLLocation alloc] initWithLatitude:[houseInfo.lat floatValue] longitude:[houseInfo.lng floatValue]];
        BMKCoordinateRegion region;
        region.center.latitude = loction.coordinate.latitude;
        region.center.longitude = loction.coordinate.longitude;
        region.span.latitudeDelta = 0.00;
        region.span.longitudeDelta = 0.00;
        myMapView.region = region;
        [searchRequest requestHouseListWithParameter:[self generateParaDictionary:loction.coordinate]];
    }
    else{
        if (currentCoordinate.longitude == 0.0 && currentCoordinate.latitude == 0) {
            myMapView.showsUserLocation = YES;
        }
    }
    unclean = NO;
    changeRegionUnRefresh = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [myMapView setDelegate:self];
    if (houseList.count != 0) {
        for (int i =0;i<houseList.count;i++) {
            HouseInfo *house = [houseList objectAtIndex:i];
            KYPointAnnotation *cAnnotation = [[KYPointAnnotation alloc] init];
            CLLocation *loc = [[CLLocation alloc] initWithLatitude:[house.lat floatValue] longitude:[house.lng floatValue]];
            cAnnotation.index = i;
            cAnnotation.coordinate = loc.coordinate;
            [annotationArray addObject:cAnnotation];
            [myMapView addAnnotation:cAnnotation];
        }
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self cleanMap];
    [self showBubble:NO withFrame:CGRectNull];
    [myMapView setDelegate:nil];
}
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    [myMapView setDelegate:nil];
    myMapView = nil;
    if (houseList.count != 0) {
        [houseList removeAllObjects];
    }
    houseList = nil;
    if (annotationArray.count != 0) {
        [annotationArray removeAllObjects];
    }
    annotationArray = nil;
    bubbleView = nil;
    [searchRequest setDelegate:nil];
    searchRequest = nil;
    
}
#pragma mark -
#pragma mark button click

-(IBAction)onClickLocate:(id)sender
{
    myMapView.showsUserLocation = YES;
}
-(void)onClickDetailButton:(UIButton *)sender
{
    int tag = [sender tag];
    unclean = YES;
    HouseInfo *house = [houseList objectAtIndex:tag];
    HouseDetailViewController *houseDetail = [[HouseDetailViewController alloc] init];
    houseDetail.houseId = house.houseID;
    [self.navigationController pushViewController:houseDetail animated:YES];
}
#pragma mark -
#pragma mark  region
-(void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    [self showBubble:NO withFrame:CGRectNull];
    
}
-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self showBubble:NO withFrame:CGRectNull];
    if (!changeRegionUnRefresh) {
        [[[[UIApplication sharedApplication] delegate] window] makeToastActivity];
        [searchRequest requestHouseListWithParameter:[self generateParaDictionary:mapView.region.center]];
    }
}
#pragma mark -
#pragma mark 注释&大头针

-(void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    
}
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    
    static NSString *identifier = @"AnnotationView";
    BMKAnnotationView *annotationV = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationV == nil) {
        annotationV = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationV.image = [UIImage imageNamed:@"mark"];
        annotationV.canShowCallout = NO;
        annotationV.draggable = NO;
        annotationV.centerOffset = CGPointMake(0, -(annotationV.frame.size.height * 0.5));
    }
    annotationV.annotation = annotation;
    annotationV.tag = [(KYPointAnnotation*)annotation index];
    return annotationV;

}
-(void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    
    
}

-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [bubbleView removeFromSuperview];
    if (bubbleView.superview == nil) {
        bubbleView = [[KYBubbleView alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
        bubbleView.hidden = YES;
        bubbleView.layer.zPosition = 1;
        [view.superview addSubview:bubbleView];
        [bubbleView.detailButton addTarget:self action:@selector(onClickDetailButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    bubbleView.houseInfo = [houseList objectAtIndex:view.tag];
    
    bubbleView.detailButton.tag = view.tag;
    
    [self showBubble:YES withFrame:view.frame];
    
}
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    [self showBubble:NO withFrame:CGRectNull];
}

#pragma mark -
#pragma mark 定位
-(void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    mapView.showsUserLocation = NO;
    if (userLocation.location.coordinate.latitude != 0.0 && userLocation.location.coordinate.longitude != 0.0) {
        
        changeRegionUnRefresh = YES;
        BMKCoordinateRegion region;
        region.center.latitude = userLocation.location.coordinate.latitude;
        region.center.longitude = userLocation.location.coordinate.longitude ;
        currentCoordinate = userLocation.location.coordinate;
        
        region.span.latitudeDelta = 0.00;
        region.span.longitudeDelta = 0.00;
        mapView.region = region;
        
        [searchRequest requestHouseListWithParameter:[self generateParaDictionary:currentCoordinate]];
    }
    else{
        myMapView.showsUserLocation = YES;
    }
}
-(void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    
}
-(void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    if (error != nil)
		NSLog(@"locate failed: %@", [error localizedDescription]);
	else {
		NSLog(@"locate failed");
	}
}

#pragma mark -
#pragma mark bubble
- (void)showBubble:(BOOL)show withFrame:(CGRect)frame {
    if (show) {
        [bubbleView showFromRect:frame];
        bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kTransitionDuration/3];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
        bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        bubbleView.hidden = NO;
        [UIView commitAnimations];
    }
    else {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kTransitionDuration/3];
        bubbleView.hidden = YES;
        [UIView commitAnimations];
        [bubbleView removeFromSuperview];
    }
}


-(void)cleanMap
{
    [self showBubble:NO withFrame:CGRectNull];
    [myMapView removeOverlays:myMapView.overlays];
    [bubbleView removeFromSuperview];
    if (annotationArray.count != 0) {
        [myMapView removeAnnotations:annotationArray];
        [annotationArray removeAllObjects];
    }
}

- (void)bounce4AnimationStopped
{
    
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/6];
	bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
	[UIView commitAnimations];
}

- (void)bounce3AnimationStopped
{
   	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/6];
	[UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce4AnimationStopped)];
	bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
	[UIView commitAnimations];
}

- (void)bounce2AnimationStopped
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/6];
	[UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce3AnimationStopped)];
	bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.05, 1.05);
	[UIView commitAnimations];
}

- (void)bounce1AnimationStopped
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kTransitionDuration/6];
	[UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
	bubbleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark request delegate

-(NSDictionary *)generateParaDictionary:(CLLocationCoordinate2D)coordinate
{
    int houseID = 0;
    NSArray *values = [NSArray arrayWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:houseID],@"",@"",@"",@"",@"",@"",[NSString stringWithFormat:@"%f",coordinate.longitude],[NSString stringWithFormat:@"%f",coordinate.latitude], nil];
    NSArray *keys = [NSArray arrayWithObjects:@"top",@"houseID",@"houseName",@"district",@"buildType",@"tag",@"maxPrice",@"minPrice",@"lng",@"lat", nil];
    if (values.count == keys.count) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
        return dic;
    }
    return nil;
}

-(void)searchHouseRequestSuccess:(NSArray *)dataSources
{
    if (houseList.count != 0) {
        [houseList removeAllObjects];
    }
    houseList = [NSMutableArray arrayWithArray:dataSources];
    [self cleanMap];
    for (int i =0;i<houseList.count;i++) {
        HouseInfo *house = [houseList objectAtIndex:i];
        KYPointAnnotation *cAnnotation = [[KYPointAnnotation alloc] init];
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[house.lat floatValue] longitude:[house.lng floatValue]];
        cAnnotation.index = i;
        cAnnotation.coordinate = loc.coordinate;
        [annotationArray addObject:cAnnotation];
        [myMapView addAnnotation:cAnnotation];
    }
    changeRegionUnRefresh = NO;
}
-(void)searchHouseRequestFailed:(NSString *)message
{
    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"数据加载失败" duration:1.0 position:@"center"];
}

@end
