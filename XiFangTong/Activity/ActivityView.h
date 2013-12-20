//
//  ActivityView.h
//  XiFangTong
//
//  Created by issuser on 13-8-6.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoinView.h"
#import "ActivityInfo.h"
#import "SubmitActivityRequest.h"
@interface ActivityView : UIView<UIActionSheetDelegate,JoinViewDelegate,SubmitActivityRequestDelegate>
{
//    UIImageView *contentImageView;
//    UIButton *joinButton;
    UIButton *phoneButton;
    SubmitActivityRequest *request;
}
@property (strong, nonatomic) UIButton *joinButton;
@property (strong, nonatomic) UIImageView *activityImageView;
@property (strong, nonatomic) ActivityInfo *activity;

-(id)initWithFrame:(CGRect)frame contentImage:(UIImage *)image andPhone:(NSString *)phoneString;
-(void)showActivity:(ActivityInfo *)info;
@end
