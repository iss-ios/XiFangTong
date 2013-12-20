//
//  HouseDetailCell.h
//  XiFangTong
//
//  Created by issuser on 13-8-12.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    kDefaultType,
    kHighlightedType
}CellType;

@interface HouseDetailCell : UITableViewCell
@property (nonatomic) CellType type;
@property (strong, nonatomic) IBOutlet UILabel *topLabel;//标题label
@property (strong, nonatomic) IBOutlet UILabel *bottomLabel;//内容label
@property (strong, nonatomic) IBOutlet UIImageView *topImageView;

-(void)setType:(CellType)cellType;
-(void)showBottomText:(NSString *)text;

@end
