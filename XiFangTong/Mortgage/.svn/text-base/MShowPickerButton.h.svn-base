//
//  MShowPickerButton.h
//  XiFangTong
//
//  Created by issuser on 13-8-7.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPickerView.h"
#import "PickerItem.h"
@class MShowPickerButton;

@protocol MShowPickerButtonDelegate <NSObject>

@optional
- (void)pickerButton:(MShowPickerButton *)picker didSelectItem:(PickerItem *)item;
- (void)pickerButtonBecomeFirstResponder:(MShowPickerButton *)picker;
@end

@interface MShowPickerButton : UIButton<UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
//    NSArray *pickerItems;
    NSString *buttonDefaultTitle;
    UILabel *buttonTitleLabel;
    CustomPickerView *actionPicker;
}
@property (assign, nonatomic) id<MShowPickerButtonDelegate> delegate;
@property (strong, nonatomic) PickerItem *selectedItem;
@property (strong, nonatomic) NSArray *pickerItems;

-(id)initWithBackgroundImage:(UIImage *)backImg pickerItems:(NSArray *)items andSelectIndex:(NSInteger)index;
-(void)setSelectedItem:(PickerItem *)selectedPickerItem;


@end
