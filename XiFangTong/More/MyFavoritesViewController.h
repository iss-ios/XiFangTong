//
//  MyFavorotesViewController.h
//  XiFangTong
//
//  Created by issuser on 13-8-2.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BasedViewController.h"

@interface MyFavoritesViewController : BasedViewController<UITableViewDelegate>
{
    IBOutlet UITableView *table;
    IBOutlet UILabel *emptyLabel;
    //add by yanbo start 2013/08/16
    NSMutableArray *favorireList;
}

//add by yanbo 2013/08/16
//临时数据制作
//-(void)newDataFavorite;

//获取活动信息
-(NSMutableArray *)getFavorite;


@end
