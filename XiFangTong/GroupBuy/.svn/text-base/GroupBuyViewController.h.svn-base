//
//  GroupBuyViewController.h
//  XiFangTong
//
//  Created by issuser on 13-8-5.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BasedViewController.h"
#import "GroupBuyRequest.h"
@interface GroupBuyViewController : BasedViewController<UIScrollViewDelegate,GroupBuyRequestDelegate>
{
    IBOutlet UIScrollView *mainScrollView;
    IBOutlet UIPageControl *mainPageControl;
    IBOutlet UILabel *pageLabel;
    GroupBuyRequest *request;
    NSMutableArray *groupBuyList;
    IBOutlet UILabel *emptyLabel;
}
@property (copy, nonatomic) NSString *houseID;

-(void)onClickRight:(id)sender;

@end
