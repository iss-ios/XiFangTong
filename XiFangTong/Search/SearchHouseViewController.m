//
//  SearchHouseViewController.m
//  XiFangTong
//
//  Created by issuser on 13-7-31.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "SearchHouseViewController.h"
#import "SearchHouseCell.h"
#import "MapViewController.h"
#import "CustomPickerView.h"
#import "HouseDetailViewController.h"
#import "HouseInfo.h"
#import "District.h"
#import "HouseType.h"

#define kStateKey   @"State"
#define kValueKey   @"Values"
#define NotificationKey @"NotificationTag"

@interface SearchHouseViewController ()
{
    NSString *houseDistrict;
    NSString *houseType;
    NSString *houseMinPrice;
    NSString *houseMaxPrice;
    NSString *houseFeature;
    int page;
}
@end

@implementation SearchHouseViewController

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
-(void)showPickerButtons
{    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if ([CommonData Instance].houseDistricts.count != 0) {
        for (District *dis in [CommonData Instance].houseDistricts) {
            [array addObject:dis.districtName];
        }
    }
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    if ([CommonData Instance].houseTypes.count != 0) {
        for (HouseType *type in [CommonData Instance].houseTypes) {
            [array2 addObject:type.typeName];
        }
    }
    CGFloat originalY = 97.0;
    //区域
    regionButton = [[ShowPickerButton alloc] initWithFrame:CGRectMake(0, originalY, 80, 35) pickerItems:array andTitle:@"区域"];
    regionButton.tag = kRegionButtonTag;
    [regionButton setDelegate:self];
    [self.view addSubview:regionButton];
    
    //价格
    priceButton = [[ShowPickerButton alloc] initWithFrame:CGRectMake(80, originalY, 80, 35) pickerItems:[NSArray arrayWithObjects:@"6000元以内",@"6000-7000元",@"7000-8000元",@"8000-9000元",@"9000-12000元",@"12000-15000元",@"15000元以上", nil] andTitle:@"价格"];
    priceButton.tag = kPriceButtonTag;
    [priceButton setDelegate:self];
    [self.view addSubview:priceButton];
    
    //类型 [type objectForKey:kValueKey]
    typeButton = [[ShowPickerButton alloc] initWithFrame:CGRectMake(160, originalY, 80, 35) pickerItems:array2 andTitle:@"类型"];
    typeButton.tag = kTypeButtonTag;
    [typeButton setDelegate:self];
    [self.view addSubview:typeButton];
    
    //特色
    featureButton = [[ShowPickerButton alloc] initWithFrame:CGRectMake(240, originalY, 80, 35) pickerItems:[CommonData Instance].houseFeatures andTitle:@"特色"];
    featureButton.tag = kFeatureButtonTag;
    [featureButton setDelegate:self];    
    [self.view addSubview:featureButton];
    
    houseDistrict = @"";
    houseMinPrice = @"";
    houseMaxPrice = @"";
    houseType = @"";
    houseFeature = @"";

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHouseInfos:) name:@"GetHouseDistricts" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHouseInfos:) name:@"GetHouseFeatures" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHouseInfos:) name:@"GetHouseTypes" object:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showPickerButtons];
    
    hiddenButton.frame = CGRectMake(0, 97, 320, screenHeight-97);
    [self.view addSubview:hiddenButton];
    hiddenButton.hidden = YES;
    
    _searchBar.frame = CGRectMake(0, 44, 320, 53);
    [_searchBar setBackgroundImage:[UIImage imageNamed:@"searchbar_yellow_big"]];
    [_searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_text_big"] forState:UIControlStateNormal];
    
    //table
    _totalNumberOfRows = 100;
    _refreshCount = 0;
    _dataSource = [[NSMutableArray alloc] initWithCapacity:4];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10.0, 0);
    
    searchRequest = [[SearchHouseRequest alloc] init];
    [searchRequest setDelegate:self];
    
    [self createHeaderView];
    [self showRefreshHeader:YES];
    page = 0;
    if (_dataSource.count == 0) {
        [self loadRefreshDataSource];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[CommonData Instance] downloadHouseInfos];
    [searchRequest setDelegate:self];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self finishReloadingData];
    [searchRequest setDelegate:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [_searchBar setDelegate:nil];
    _searchBar = nil;
    hiddenButton = nil;
    [searchRequest setDelegate:nil];
    searchRequest = nil;
    _dataSource = nil;
}
#pragma mark -
#pragma mark notification
-(void)refreshHouseInfos:(NSNotification *)notification
{//@"district"@"feature"type
    NSDictionary *dic = [notification userInfo];
    NSString *tagK = [dic objectForKey:NotificationKey];
    if ([tagK isEqualToString:@"district"]) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array insertObject:@"不限" atIndex:0];
        if ([CommonData Instance].houseDistricts.count != 0) {
            for (District *dis in [CommonData Instance].houseDistricts) {
                [array addObject:dis.districtName];
            }
        }
        
        [regionButton setPickerItems:array];
    }
    else if ([tagK isEqualToString:@"feature"]){
        NSMutableArray *array1 = [[NSMutableArray alloc] init];
        [array1 insertObject:@"不限" atIndex:0];
        [array1 addObjectsFromArray:[CommonData Instance].houseFeatures];
        [featureButton setPickerItems:array1];
    }
    else{
        NSMutableArray *array2 = [[NSMutableArray alloc] init];
        [array2 insertObject:@"不限" atIndex:0];
        if ([CommonData Instance].houseTypes.count != 0) {
            for (HouseType *type in [CommonData Instance].houseTypes) {
                [array2 addObject:type.typeName];
            }
        }
        

        [typeButton setPickerItems:array2];
    }
}
#pragma mark -
#pragma mark table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return _dataSource?_dataSource.count:0;
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
    if (_dataSource.count != 0) {
        HouseInfo *house = [_dataSource objectAtIndex:indexPath.row];
        [cell showHouseInfo:house];
    }    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HouseInfo *house = [_dataSource objectAtIndex:indexPath.row];
    HouseDetailViewController *houseDetail = [[HouseDetailViewController alloc] init];
    houseDetail.houseId = house.houseID;
    [self.navigationController pushViewController:houseDetail animated:YES];
}
#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
	
	if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
	
	if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark-
#pragma mark overide methods
-(void)beginToReloadData:(EGORefreshPos)aRefreshPos
{
	[super beginToReloadData:aRefreshPos];
    
    if (aRefreshPos == EGORefreshHeader) {
        // pull down to refresh data
        [self performSelector:@selector(loadRefreshDataSource) withObject:nil afterDelay:2.0];
    }else if(aRefreshPos == EGORefreshFooter){
        // pull up to load more data
        [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:2.0];
    }
}

-(void)loadRefreshDataSource
{
//    [[[[UIApplication sharedApplication] delegate] window] makeToastActivity];
    page = 0;
    loadMore = NO;
   [searchRequest requestHouseListWithParameter:[self generateParaDictionary] showToast:NO];
}

-(void)loadMoreData
{
    page++;
    loadMore = YES;
    [searchRequest requestHouseListWithParameter:[self generateParaDictionary] showToast:NO];
}
-(NSDictionary *)generateParaDictionary
{
    NSString *houseName = @"";
   
    if (_searchBar.text.length != 0) {
        houseName = _searchBar.text;
    }
    int rowID = 0;
    if (loadMore) {
        HouseInfo *house = [_dataSource lastObject];
        rowID = [house.rowid intValue];
    }
    NSArray *values = [NSArray arrayWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:rowID],houseName,houseDistrict,houseType,houseFeature,houseMaxPrice,houseMinPrice,@"",@"",[NSNumber numberWithInt:5], nil];
    NSArray *keys = [NSArray arrayWithObjects:@"top",@"houseID",@"houseName",@"district",@"buildType",@"tag",@"maxPrice",@"minPrice",@"lng",@"lat",@"distance", nil];
    if (values.count == keys.count) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
        return dic;
    }
    return nil;
}
#pragma mark -
#pragma mark search bar
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    hiddenButton.hidden = NO;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    hiddenButton.hidden = YES;
    [_searchBar resignFirstResponder];
    loadMore = NO;

    [searchRequest requestHouseListWithParameter:[self generateParaDictionary] showToast:NO];
    [[[[UIApplication sharedApplication] delegate] window] makeToastActivity];

}
#pragma mark -
#pragma mark request
-(void)searchHouseRequestSuccess:(NSArray *)dataSources
{
    [self finishReloadingData];
    if (loadMore) {
        [_dataSource addObjectsFromArray:dataSources];
        
    }
    else{
        _dataSource = [NSMutableArray arrayWithArray:dataSources];
    }
    
    [self.tableView reloadData];
    
    emptyLabel.hidden = YES;
    self.tableView.hidden = NO;
    
    if (_dataSource.count <10) {
        if (_dataSource.count == 0) {
            emptyLabel.hidden = NO;
            self.tableView.hidden = YES;
        }
        [self removeFooterView];
    }
    else{
        [self setFooterView];
    }
    
    if (dataSources.count == 0 && loadMore) {
        [[[[UIApplication sharedApplication] delegate] window] makeToast:@"没有更多" duration:2.0 position:@"center"];
        [self removeFooterView];
    }
}
-(void)searchHouseRequestFailed:(NSString *)message
{
    [self finishReloadingData];
    
    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"数据加载失败" duration:2.0 position:@"center"];

}
#pragma mark -
#pragma mark button click
-(void)onClickRight:(id)sender
{
    MapViewController *map = [[MapViewController alloc] init];
    [self.navigationController pushViewController:map animated:YES];
}

-(IBAction)onClickHidden:(id)sender
{
    [_searchBar resignFirstResponder];
    hiddenButton.hidden = YES;
}
-(IBAction)onClickSearch:(id)sender
{
    if (_searchBar.text.length != 0) {
        hiddenButton.hidden = YES;
        [_searchBar resignFirstResponder];
        loadMore = NO;
        
        [searchRequest requestHouseListWithParameter:[self generateParaDictionary] showToast:NO];
        [[[[UIApplication sharedApplication] delegate] window] makeToastActivity];

    }
}
-(void)showPickerButton:(ShowPickerButton *)picker didSelectItem:(PickerItem *)item
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    switch (picker.tag) {
        case kRegionButtonTag:
        {
            if (item.tag == 0) {
                houseDistrict = @"";
            }
            else{
                NSInteger dID = [[CommonData Instance] getDistrictID:item.itemValue];
                
                houseDistrict = [NSString stringWithFormat:@"%i",dID];
            }
            [defaults setValue:houseDistrict forKey:GuessDistrictKey];
        }
            break;
        case kPriceButtonTag:
        {
            if (item.tag == 0) {
                houseMinPrice = @"";
                houseMaxPrice = @"";
            }
            else{
                houseMinPrice = [Tool getMinPriceByString:item.itemValue];
                houseMaxPrice = [Tool getMaxPriceByString:item.itemValue];
            }
            [defaults setValue:item.itemValue forKey:GuessAvgPriceKey];
        }
            break;
        case kTypeButtonTag:
        {
            if (item.tag == 0) {
                houseType = @"";
            }
            else{
                NSInteger dID = [[CommonData Instance] getTypeID:item.itemValue];
                
                houseType = [NSString stringWithFormat:@"%i",dID];
            }
        }
            break;
        case kFeatureButtonTag:
        {
            if (item.tag == 0) {
                houseFeature = @"";
            }
            else{
                houseFeature = item.itemValue;
            }
            [defaults setValue:houseFeature forKey:GuessTagKey];
        }
            break;
        default:
            break;
    }
    [defaults synchronize];
    loadMore = NO;
    [searchRequest requestHouseListWithParameter:[self generateParaDictionary] showToast:NO];
    [[[[UIApplication sharedApplication] delegate] window] makeToastActivity];

}

@end
