//
//  ShowPickerButton.h
//  XiFangTong
//
//  Created by issuser on 13-8-2.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPickerView.h"
@class ShowPickerButton;

@protocol ShowPickerButtonDelegate <NSObject>

@optional
- (void)showPickerButton:(ShowPickerButton *)picker didSelectItem:(PickerItem *)item;

@end

@interface ShowPickerButton : UIButton<UIActionSheetDelegate>
{
    @private
//    NSMutableArray *pickerItems;
    NSString *buttonDefaultTitle;
    UILabel *buttonTitleLabel;
    UIImageView *arrowImageView;
    CustomPickerView *actionPicker;
}

@property (assign, nonatomic) id<ShowPickerButtonDelegate> delegate;
@property (strong, nonatomic) PickerItem *selectedItem;
@property (strong, nonatomic) NSMutableArray *pickerItems;

-(id)initWithFrame:(CGRect)frame pickerItems:(NSArray *)items andTitle:(NSString *)title;
-(void)setSelectedItem:(PickerItem *)selectedPickerItem;
-(void)setPickerItems:(NSMutableArray *)items;
@end
