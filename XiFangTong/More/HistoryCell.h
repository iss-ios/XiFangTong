//
//  HistoryCell.h
//  XiFangTong
//
//  Created by issuser on 13-8-5.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HouseInfo.h"
@interface HistoryCell : UITableViewCell{
    //add by yanbo 2013/08/15
    IBOutlet UIImageView *houseImage;
    IBOutlet UILabel *houseName;
    IBOutlet UILabel *price;
    
    NSURLConnection *connection;
    NSMutableData *data;
}

//add by yanbo 2013/08/15
-(void)setMessageWithHistory:(HouseInfo *)house;
@end
