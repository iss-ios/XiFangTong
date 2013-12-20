//
//  GroupBuyView.h
//  XiFangTong
//
//  Created by issuser on 13-8-5.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupBuyInfo.h"
#import "JoinView.h"
#import "SubmitGroupBuyRequest.h"

@interface GroupBuyView : UIView<JoinViewDelegate,SubmitGroupBuyRequestDelegate>
{
    UIImageView *contentImageView;
    UIButton *joinButton;
    UIButton *phoneButton;
    SubmitGroupBuyRequest *request;
    SDWebImageManager *manager;
}
//@property (strong, nonatomic) UIImageView *contentImageView;
@property (strong, nonatomic) GroupBuyInfo *groupBuy;
-(void)showGroupBuy:(GroupBuyInfo *)info;
-(id)initWithFrame:(CGRect)frame contentImage:(UIImage *)image andPhone:(NSString *)phoneString;

@end
