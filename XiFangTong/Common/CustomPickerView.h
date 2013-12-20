//
//  CustomPickerView.h
//  XiFangTong
//
//  Created by issuser on 13-7-31.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerItem.h"
@interface CustomPickerView : UIActionSheet<UIPickerViewDelegate, UIPickerViewDataSource>
{
//    IBOutlet UIPickerView *picker;
    UIButton *mBtnHidden;
//    NSArray *pickerItems;
}
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) PickerItem *selectedItem;
@property (strong, nonatomic) NSArray *pickerItems;
- (id)initWithPickerItems:(NSArray *)items delegate:(id /*<UIActionSheetDelegate>*/)delegate tag:(int)tag;

- (void)showInView:(UIView *)view;

@end
