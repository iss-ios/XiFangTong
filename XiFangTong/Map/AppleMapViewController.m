//
//  AppleMapViewController.m
//  XiFangTong
//
//  Created by issuser on 13-9-17.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "AppleMapViewController.h"
#import "AKYPointAnnotation.h"

#import "SearchHouseViewController.h"
#import "HouseDetailViewController.h"
#import "SearchHouseCell.h"
static CGFloat kTransitionDuration = 0.45f;

@interface AppleMapViewController ()

@end

@implementation AppleMapViewController

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
    
    //MKMapView
    
//    myMapView.zoomLevel = 14;
    
//    [myMapView setDelegate:self];
    
    //Request
    searchRequest = [[SearchHouseRequest alloc] init];
    [searchRequest setDelegate:self];
    houseList = [[NSMutableArray alloc] init];
    annotationArray = [[NSMutableArray alloc] init];
    unclean = NO;
    changeRegionUnRefresh = YES;
    
    if (houseInfo != nil && ![houseInfo.lng isEqualToString:@"0"] && ![houseInfo.lat isEqualToString:@"0"]) {
        CLLocation *loction = [[CLLocation alloc] initWithLatitude:[houseInfo.lat floatValue] longitude:[houseInfo.lng floatValue]];
        MKCoordinateRegion region;
        region.center.latitude = loction.coordinate.latitude;
        region.center.longitude = loction.coordinate.longitude;
        region.span.latitudeDelta = 0.00;
        region.span.longitudeDelta = 0.00;
        myMapView.region = region;
        [searchRequest requestHouseListWithParameter:[self generateParaDictionary:loction.coordinate] showToast:YES];
    }
    else{
        if (currentCoordinate.longitude == 0.0 && currentCoordinate.latitude == 0.0) {
            myMapView.showsUserLocation = YES;
        }
    }
    [[[[UIApplication sharedApplication] delegate] window] makeToastActivity];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    myMapView.delegate = self;
    [searchRequest setDelegate:self];
    
    if (currentCoordinate.longitude != 0.0 && currentCoordinate.latitude != 0.0) {
        [searchRequest requestHouseListWithParameter:[self generateParaDictionary:currentCoordinate] showToast:YES];
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    [self showBubble:NO withFrame:CGRectNull];
    [self cleanMap];
    [myMapView setDelegate:nil];
    [searchRequest setDelegate:nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self cleanMap];
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
    table.delegate = nil;
    table.dataSource = nil;
    table = nil;
    
}
#pragma mark -
#pragma mark table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return houseList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"like cell";
    SearchHouseCell *cell = (SearchHouseCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"SearchHouseCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[SearchHouseCell class]]){
                cell = (SearchHouseCell *)o;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
        }
    }
    if (houseList.count != 0) {
        HouseInfo *house = [houseList objectAtIndex:indexPath.row];
        [cell showHouseInfo:house];
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HouseInfo *house = [houseList objectAtIndex:indexPath.row];
    HouseDetailViewController *houseDetail = [[HouseDetailViewController alloc] init];
    houseDetail.houseId = house.houseID;
    [self.navigationController pushViewController:houseDetail animated:YES];
}

#pragma mark -
#pragma mark button click
-(void)onClickBack:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)onClickRight:(id)sender
{
    static BOOL showTabel = NO;
    //title_right_map.png map_title_right.png
    if (!showTabel) {
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"title_right_map.png"] forState:UIControlStateNormal];
        table.hidden = NO;
        myMapView.hidden = YES;
        locateButton.hidden = YES;
        [table reloadData];
        showTabel = YES;
    }
    else{
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"map_title_right.png"] forState:UIControlStateNormal];
        table.hidden = YES;
        myMapView.hidden = NO;
        locateButton.hidden = NO;
        showTabel = NO;
    }
}
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
#pragma mark 定位
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    mapView.showsUserLocation = NO;
    if (userLocation.location.coordinate.latitude != 0.0 && userLocation.location.coordinate.longitude != 0.0) {
        
        changeRegionUnRefresh = YES;
        MKCoordinateRegion region;
        region.center.latitude = userLocation.location.coordinate.latitude;
        region.center.longitude = userLocation.location.coordinate.longitude;
        currentCoordinate = userLocation.location.coordinate;
        
        region.span.latitudeDelta = 0.04;
        region.span.longitudeDelta = 0.04;
        mapView.region = region;
        
        [searchRequest requestHouseListWithParameter:[self generateParaDictionary:currentCoordinate] showToast:YES];
    }
    else{
        myMapView.showsUserLocation = YES;
    }
}

-(void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [[[[UIApplication sharedApplication] delegate] window] hideToastActivity];
    if (error.code != kCLErrorDenied)
		[[[[UIApplication sharedApplication] delegate] window] makeToast:@"定位失败" duration:1.0 position:@"center"];
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"检测到您未开启定位服务，请在手机设置中打开定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
	}
}
#pragma mark -
#pragma mark  region
-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    [self showBubble:NO withFrame:CGRectNull];
}
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self showBubble:NO withFrame:CGRectNull];
    if (!changeRegionUnRefresh) {
        currentCoordinate = mapView.region.center;
        [[[[UIApplication sharedApplication] delegate] window] makeToastActivity];
        [searchRequest requestHouseListWithParameter:[self generateParaDictionary:mapView.region.center] showToast:YES];
    }
}
#pragma mark -
#pragma mark 注释&大头针
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"AnnotationView";
    MKAnnotationView *annotationV = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationV == nil) {
        annotationV = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationV.image = [UIImage imageNamed:@"mark2"];
        annotationV.canShowCallout = NO;
        annotationV.draggable = NO;
        annotationV.centerOffset = CGPointMake(0, -(annotationV.frame.size.height * 0.5));
    }
    annotationV.annotation = annotation;
    if ([annotation isKindOfClass:[AKYPointAnnotation class]]) {
        annotationV.tag = [(AKYPointAnnotation*)annotation tag];
    }
    
    return annotationV;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [bubbleView removeFromSuperview];
    if (bubbleView.superview == nil) {
        bubbleView = [[AKYBubbleView alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
        bubbleView.hidden = YES;
        bubbleView.layer.zPosition = 1;
        [view.superview addSubview:bubbleView];
        [bubbleView.detailButton addTarget:self action:@selector(onClickDetailButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    bubbleView.houseInfo = [houseList objectAtIndex:view.tag];
    
    bubbleView.detailButton.tag = view.tag;
    
    [self showBubble:YES withFrame:view.frame];
    
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    [self showBubble:NO withFrame:CGRectNull];
}

#pragma mark -
#pragma mark bubble
-(void)cleanMap
{
    [self showBubble:NO withFrame:CGRectNull];
    [myMapView removeOverlays:myMapView.overlays];
    [bubbleView removeFromSuperview];
    if (annotationArray.count != 0) {
        [myMapView removeAnnotations:annotationArray];
        [annotationArray removeAllObjects];
    }
}- (void)showBubble:(BOOL)show withFrame:(CGRect)frame
{
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
        AKYPointAnnotation *cAnnotation = [[AKYPointAnnotation alloc] init];
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[house.lat floatValue] longitude:[house.lng floatValue]];
        cAnnotation.tag = i;
        cAnnotation.coordinate = loc.coordinate;
        cAnnotation.title = @"a";
        [annotationArray addObject:cAnnotation];
        [myMapView addAnnotation:cAnnotation];
        
        
    }
    changeRegionUnRefresh = NO;
    if (houseList.count == 0) {
        [[[[UIApplication sharedApplication] delegate] window] makeToast:@"暂无数据" duration:3.0 position:@"center"];
    }
}
-(void)searchHouseRequestFailed:(NSString *)message
{
    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"数据加载失败" duration:2.0 position:@"center"];
}

@end
