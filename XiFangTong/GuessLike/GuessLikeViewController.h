//
//  LikeViewController.h
//  XiFangTong
//
//  Created by issuser on 13-7-30.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasedViewController.h"
#import "GuessLikeRequest.h"

@interface GuessLikeViewController : BasedViewController<UITableViewDataSource,UITableViewDelegate,GuessLikeRequestDelegate>
{
    IBOutlet UITableView *table;
    GuessLikeRequest *request;
    NSMutableArray *houseList;
    IBOutlet UILabel *emptyLabel;

}
@end
