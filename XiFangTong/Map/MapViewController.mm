//
//  MapViewController.m
//  XiFangTong
//
//  Created by issuser on 13-7-31.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "MapViewController.h"
#import "SearchHouseViewController.h"
#import "HouseDetailViewController.h"
#import "SearchHouseCell.h"
#import "MoreViewController.h"

static CGFloat kTransitionDuration = 0.45f;

@interface MapViewController ()
{
    NSMutableArray *houseList;
    NSMutableArray *annotationArray;
    NSInteger currectSelectedAnnotationIndex;
    BOOL didShowBubble;
    BOOL unclean;
    BOOL changeRegionUnRefresh;
    BOOL refresh;
}

@end

@implementation MapViewController
@synthesize houseInfo;
@synthesize backToRoot;
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
    myMapView.zoomEnabled = YES;
    myMapView.scrollEnabled = YES;
    [myMapView setDelegate:self];
    
    //BMKSearch
    _search = [[BMKSearch alloc] init];
    _search.delegate = self;
    
    
    //Request
    searchRequest = [[MapSearchRequest alloc] init];
    [searchRequest setDelegate:self];
    
    //初始化参数
    
    //楼盘数组
    houseList = [[NSMutableArray alloc] init];
    
    //标注数组
    annotationArray = [[NSMutableArray alloc] init];
    
    unclean = NO;
    
    //移动地图不刷新
    changeRegionUnRefresh = YES;
    currectSelectedAnnotationIndex = -1;
    table.hidden = YES;
    
    
    if (houseInfo != nil && ![houseInfo.lng isEqualToString:@"0"] && ![houseInfo.lat isEqualToString:@"0"]) {
        refresh = NO;
        CLLocation *loction = [[CLLocation alloc] initWithLatitude:[houseInfo.lat floatValue] longitude:[houseInfo.lng floatValue]];
        
        currentCoordinate = loction.coordinate;
        
        [searchRequest requestMapHouseListWithParameter:[self generateParaDictionary:loction.coordinate] showToast:NO];
    }
    else{
        if (houseInfo != nil) {
            [myMapView makeToastActivity];
            
            myMapView.userInteractionEnabled = NO;
            [_search geocode:houseInfo.buildAddress withCity:@"无锡"];
        }
        else{
            
            myMapView.showsUserLocation = YES;
            
        }
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    myMapView.delegate = self;
    if (searchRequest.delegate == nil) {
        [searchRequest setDelegate:self];
    }
    
    if (currentCoordinate.longitude != 0.0 && currentCoordinate.latitude != 0.0 && refresh) {
        [searchRequest requestMapHouseListWithParameter:[self generateParaDictionary:currentCoordinate] showToast:NO];
        
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
    if (backToRoot) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else{
        NSArray *controllers = [self.navigationController viewControllers];
        if (controllers.count <= 3) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            UIViewController *controller = [controllers objectAtIndex:1];
            if ([controller isKindOfClass:[MoreViewController class]]) {
                [self.navigationController popToViewController:[controllers objectAtIndex:2] animated:YES];
            }
            else{
                [self.navigationController popToViewController:[controllers objectAtIndex:1] animated:YES];
            }
        }
    }
}
-(void)onClickRight:(id)sender
{
    //title_right_map.png map_title_right.png
    if (table.hidden) {
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"title_right_map.png"] forState:UIControlStateNormal];
        table.hidden = NO;
        myMapView.hidden = YES;
        locateButton.hidden = YES;
        [table reloadData];
    }
    else{
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"map_title_right.png"] forState:UIControlStateNormal];
        table.hidden = YES;
        myMapView.hidden = NO;
        locateButton.hidden = NO;
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
    backToRoot = YES;
    refresh = YES;
    HouseInfo *house = [houseList objectAtIndex:tag];
    HouseDetailViewController *houseDetail = [[HouseDetailViewController alloc] init];
    houseDetail.houseId = house.houseID;
    [self.navigationController pushViewController:houseDetail animated:YES];
}
#pragma mark -
#pragma mark 定位
-(void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    mapView.showsUserLocation = NO;
    if (userLocation.location.coordinate.latitude != 0.0 && userLocation.location.coordinate.longitude != 0.0) {
        
        changeRegionUnRefresh = YES;
        mapView.centerCoordinate = userLocation.coordinate;
        BMKCoordinateRegion region;
        region.center.latitude = userLocation.location.coordinate.latitude;
        region.center.longitude = userLocation.location.coordinate.longitude ;
        currentCoordinate = userLocation.location.coordinate;
        
        region.span.latitudeDelta = 0.00;
        region.span.longitudeDelta = 0.00;
        mapView.region = region;
        
        [searchRequest requestMapHouseListWithParameter:[self generateParaDictionary:currentCoordinate] showToast:NO];
        
    }
    else{
        myMapView.showsUserLocation = YES;
    }
}

-(void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [[[[UIApplication sharedApplication] delegate] window] hideToastActivity];
    if (error.code == kCLErrorNetwork){
		[[[[UIApplication sharedApplication] delegate] window] makeToast:@"定位失败" duration:1.0 position:@"center"];
    }
	else if(error.code == kCLErrorDenied){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"检测到您未开启定位服务，请在手机设置中打开定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
	}
}
#pragma mark -
#pragma mark  region

-(void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    
}
-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self showBubble:NO withFrame:CGRectNull];
    if (!changeRegionUnRefresh) {
        currentCoordinate = mapView.region.center;
        [searchRequest requestMapHouseListWithParameter:[self generateParaDictionary:mapView.region.center] showToast:NO];
    }
}
#pragma mark -
#pragma mark 注释&大头针

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
    if (houseInfo != nil && changeRegionUnRefresh) {
        if (!didShowBubble) {
            if (currectSelectedAnnotationIndex >-1) {
                BMKAnnotationView *annotationV = [views objectAtIndex:0];
                [mapView selectAnnotation:annotationV.annotation animated:YES];
                didShowBubble = YES;
            }
            
        }
    }
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
#pragma mark search
-(void)onGetAddrResult:(BMKAddrInfo *)result errorCode:(int)error
{
    myMapView.userInteractionEnabled = YES;
    
    if (error == 0) {
        refresh = NO;
        changeRegionUnRefresh = YES;
        
        myMapView.centerCoordinate =result.geoPt;
        BMKCoordinateRegion region;
        region.center.latitude = result.geoPt.latitude;
        region.center.longitude = result.geoPt.longitude;
        region.span.latitudeDelta = 0.00;
        region.span.longitudeDelta = 0.00;
        myMapView.region = region;
        currentCoordinate = region.center;
        
        [searchRequest requestMapHouseListWithParameter:[self generateParaDictionary:result.geoPt] showToast:NO];
    }
    else{
        myMapView.showsUserLocation = YES;
    }    
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
}
- (void)showBubble:(BOOL)show withFrame:(CGRect)frame
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
    NSArray *values = [NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSString stringWithFormat:@"%f",coordinate.longitude],[NSString stringWithFormat:@"%f",coordinate.latitude], nil];
    NSArray *keys = [NSArray arrayWithObjects:@"distance",@"lng",@"lat", nil];
    if (values.count == keys.count) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
        return dic;
    }
    return nil;
}

-(void)mapSearchRequestSuccess:(NSArray *)dataSources
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
        if (houseInfo != nil && [house.houseID isEqualToString:houseInfo.houseID]&& !didShowBubble) {
            currectSelectedAnnotationIndex = i;
            myMapView.centerCoordinate = loc.coordinate;
            BMKCoordinateRegion region;
            region.center.latitude = loc.coordinate.latitude;
            region.center.longitude = loc.coordinate.longitude;
            region.span.latitudeDelta = 0.00;
            region.span.longitudeDelta = 0.00;
            myMapView.region = region;
            
        }
        [annotationArray addObject:cAnnotation];
        
        [myMapView addAnnotation:cAnnotation];
    }
    if (houseList.count == 0) {
        if (houseInfo != nil && ![houseInfo.lng isEqualToString:@"0"] && ![houseInfo.lat isEqualToString:@"0"] && !didShowBubble) {
            [houseList addObject:houseInfo];
            changeRegionUnRefresh = YES;
            
            KYPointAnnotation *cAnnotation = [[KYPointAnnotation alloc] init];
            CLLocation *loc = [[CLLocation alloc] initWithLatitude:[houseInfo.lat floatValue] longitude:[houseInfo.lng floatValue]];
            cAnnotation.index = 0;
            cAnnotation.coordinate = loc.coordinate;
            //            if (!didShowBubble) {
            currectSelectedAnnotationIndex = 0;
            myMapView.centerCoordinate = loc.coordinate;
            BMKCoordinateRegion region;
            region.center.latitude = loc.coordinate.latitude;
            region.center.longitude = loc.coordinate.longitude;
            region.span.latitudeDelta = 0.00;
            region.span.longitudeDelta = 0.00;
            myMapView.region = region;
            //            }
            [annotationArray addObject:cAnnotation];
            
            [myMapView addAnnotation:cAnnotation];
        }
        else{
            [[[[UIApplication sharedApplication] delegate] window] makeToast:@"此区域暂无房源" duration:1.0 position:@"center"];
        }
    }
    changeRegionUnRefresh = NO;
    
}
-(void)mapSearchRequestFailed:(NSString *)message
{
    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"数据加载失败" duration:2.0 position:@"center"];
}

@end
