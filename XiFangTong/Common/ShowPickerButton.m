//
//  ShowPickerButton.m
//  XiFangTong
//
//  Created by issuser on 13-8-2.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "ShowPickerButton.h"
//#import "CustomPickerView.h"

@implementation ShowPickerButton
@synthesize pickerItems;

-(id)initWithFrame:(CGRect)frame pickerItems:(NSArray *)items andTitle:(NSString *)title 
{
    self = [super initWithFrame:frame];
    if (self) {
        pickerItems = [[NSMutableArray alloc] init];

        [self setExclusiveTouch:YES];
        [self setBackgroundImage:[UIImage imageNamed:@"select_btn_bg2.png"] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonTitleLabel = [[UILabel alloc] init];
        buttonTitleLabel.frame = CGRectMake(0, 6, 55, 21);//0, 6, 55, 21
        buttonTitleLabel.backgroundColor = [UIColor clearColor];
        buttonTitleLabel.textColor = [UIColor darkGrayColor];
        buttonTitleLabel.font = [UIFont systemFontOfSize:14.0f];
        buttonTitleLabel.textAlignment = NSTextAlignmentCenter;
        buttonTitleLabel.text = title;
        [self addSubview:buttonTitleLabel];
        buttonDefaultTitle = title;
        
        arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 15, 8, 5)];//55, 15, 8, 5
        arrowImageView.image = [UIImage imageNamed:@"arrow.png"];
        [self addSubview:arrowImageView];
        
        if (items.count == 0) {
            pickerItems = [NSMutableArray arrayWithObject:@"不限"];
        }
        else{
            [pickerItems insertObject:@"不限" atIndex:0];
            [pickerItems addObjectsFromArray:items];
        }
        if (actionPicker == nil) {
            actionPicker = [[CustomPickerView alloc] initWithPickerItems:pickerItems delegate:self tag:self.tag];
        }
        actionPicker.selectedItem.tag = 0;
        actionPicker.selectedItem.itemValue = title;
        [self setSelectedItem:actionPicker.selectedItem];
        buttonTitleLabel.text = actionPicker.selectedItem.itemValue;
        
    }
    return self;

}

-(void)buttonClicked:(id)sender
{
    if (actionPicker == nil) {
        actionPicker = [[CustomPickerView alloc] initWithPickerItems:pickerItems delegate:self tag:self.tag];
    }
    [actionPicker showInView:self.superview];
    [actionPicker.picker selectRow:actionPicker.selectedItem.tag inComponent:0 animated:NO];
    [actionPicker.picker reloadAllComponents];
}

-(void)setSelectedItem:(PickerItem *)selectedPickerItem
{
    _selectedItem.tag = selectedPickerItem.tag;
    _selectedItem.itemValue = selectedPickerItem.itemValue;
    if ([_delegate respondsToSelector:@selector(showPickerButton:didSelectItem:)])
        [_delegate showPickerButton:self didSelectItem:selectedPickerItem];
}
-(void)setPickerItems:(NSMutableArray *)items
{
//    [pickerItems insertObject:@"不限" atIndex:0];
//    [pickerItems addObjectsFromArray:items];
    actionPicker.pickerItems = items;
    [actionPicker.picker selectRow:actionPicker.selectedItem.tag inComponent:0 animated:YES];
    [actionPicker.picker reloadAllComponents];

}
#pragma mark -
#pragma mark action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    CustomPickerView *action = (CustomPickerView *)actionSheet;
    if(buttonIndex == 0) {
        
    }else {
        if (action.selectedItem.tag == 0) {
            buttonTitleLabel.text = buttonDefaultTitle;
        }
        else{
            buttonTitleLabel.text = action.selectedItem.itemValue;
            CGRect frame = buttonTitleLabel.frame;
            
            if ([Tool countLengthOfString:buttonTitleLabel.text] >3 ) {
                buttonTitleLabel.frame = CGRectMake(frame.origin.x, frame.origin.y, 65, 21);
            }
            else{
                buttonTitleLabel.frame = CGRectMake(frame.origin.x, frame.origin.y, 55, 21);
            }
            arrowImageView.frame = CGRectMake(buttonTitleLabel.frame.size.width+buttonTitleLabel.frame.origin.x, 15, 8, 5);
        }

        [self setSelectedItem:action.selectedItem];
    }
}

@end
