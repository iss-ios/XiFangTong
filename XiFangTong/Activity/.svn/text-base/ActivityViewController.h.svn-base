//
//  ActivityViewController.h
//  XiFangTong
//
//  Created by issuser on 13-7-31.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasedViewController.h"
#import "ActivityRequest.h"
@interface ActivityViewController : BasedViewController<UIScrollViewDelegate,ActivityRequestDelegate>
{
    IBOutlet UIScrollView *mainScrollView;
    IBOutlet UIPageControl *mainPageControl;
    IBOutlet UILabel *pageLabel;
    IBOutlet UILabel *emptyLabel;
    ActivityRequest *request;
    NSMutableArray *activityList;
}
@property (copy, nonatomic) NSString *houseID;

-(void)onClickRight:(id)sender;

@end
