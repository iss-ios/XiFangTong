//
//  JoinView.h
//  XiFangTong
//
//  Created by issuser on 13-8-29.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//
//活动、团购界面点击“我要报名”或“我要参团”弹出的报名界面

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "TextFieldInputCheck.h"
typedef enum
{
    kDefaultStyle,
    kSpecialStyle
}JoinViewStyle;

@class JoinView;
@protocol JoinViewDelegate <NSObject>

-(void)joinView:(JoinView *)joinView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface JoinView : UIView<UITextFieldDelegate>
{
    IBOutlet UIButton *cancelButton;
    IBOutlet UIButton *doneButton;
    IBOutlet CustomTextField *nameTextField;
    IBOutlet CustomTextField *phoneTextField;
    IBOutlet CustomTextField *countTextField;
    UIButton *mBtnHidden;
    JoinViewStyle jStyle;
    IBOutlet TextFieldInputCheck *inputCheck;
    BOOL move;
}
@property (assign, nonatomic) id<JoinViewDelegate> delegate;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *count;

-(id)initWithStyle:(JoinViewStyle)style;
-(void)showInView:(UIView *)view;

@end
