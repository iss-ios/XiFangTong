//
//  SearchHouseViewController.h
//  XiFangTong
//
//  Created by issuser on 13-7-31.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshTableViewController.h"
#import "ShowPickerButton.h"
#import "SearchHouseRequest.h"
@class ShowPickerButton;
typedef enum
{
    kRegionButtonTag,
    kPriceButtonTag,
    kTypeButtonTag,
    kFeatureButtonTag
    
}SPickerButtonTag;

@interface SearchHouseViewController : RefreshTableViewController<UITabBarDelegate,UITableViewDataSource,EGORefreshTableDelegate,ShowPickerButtonDelegate,UISearchBarDelegate,SearchHouseRequestDelegate>
{
//    IBOutlet UITableView *table;
    IBOutlet UISearchBar *_searchBar;
    IBOutlet UIButton   *hiddenButton;
    IBOutlet UILabel    *emptyLabel;
    ShowPickerButton *regionButton;
    ShowPickerButton *priceButton;
    ShowPickerButton *typeButton;
    ShowPickerButton *featureButton;
    SearchHouseRequest *searchRequest;
    
@private
    NSMutableArray *_dataSource;
    NSInteger _totalNumberOfRows;
    NSInteger _refreshCount;
    NSInteger _loadMoreCount;
    BOOL loadMore;
}

-(void)onClickRight:(id)sender;

@end
