//
//  MShowPickerButton.m
//  XiFangTong
//
//  Created by issuser on 13-8-7.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "MShowPickerButton.h"

@implementation MShowPickerButton

@synthesize pickerItems;

-(id)initWithBackgroundImage:(UIImage *)backImg pickerItems:(NSArray *)items andSelectIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        pickerItems = items;
        
        [self setBackgroundImage:backImg forState:UIControlStateNormal];
        [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonTitleLabel = [[UILabel alloc] init];
        buttonTitleLabel.frame = CGRectMake(2, 7, 150, 21);//0, 6, 55, 21
        buttonTitleLabel.backgroundColor = [UIColor clearColor];
        buttonTitleLabel.textColor = [UIColor darkGrayColor];
        buttonTitleLabel.font = [UIFont systemFontOfSize:14.0f];
        buttonTitleLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:buttonTitleLabel];
        
        if (actionPicker == nil) {
            actionPicker = [[CustomPickerView alloc] initWithPickerItems:pickerItems delegate:self tag:self.tag];
        }
        actionPicker.picker.delegate = self;
        actionPicker.picker.dataSource = self;
        actionPicker.selectedItem.tag = index;
        actionPicker.selectedItem.itemValue = [items objectAtIndex:index];
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
    [actionPicker showInView:[UIApplication sharedApplication].keyWindow];
    [actionPicker.picker selectRow:actionPicker.selectedItem.tag inComponent:0 animated:YES];
    [actionPicker.picker reloadAllComponents];
    if ([_delegate respondsToSelector:@selector(pickerButtonBecomeFirstResponder:)])
        [_delegate pickerButtonBecomeFirstResponder:self];
}
-(void)setSelectedItem:(PickerItem *)selectedPickerItem
{
    _selectedItem.tag = selectedPickerItem.tag;
    _selectedItem.itemValue = selectedPickerItem.itemValue;
    if ([_delegate respondsToSelector:@selector(pickerButton:didSelectItem:)])
        [_delegate pickerButton:self didSelectItem:selectedPickerItem];
}
#pragma mark -
#pragma mark action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    CustomPickerView *action = (CustomPickerView *)actionSheet;
    if(buttonIndex == 0) {
        
    }else {
        [self setSelectedItem:action.selectedItem];
    }
}
#pragma mark -
#pragma mark picker view delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerItems.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerItems objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    actionPicker.selectedItem.itemValue = [pickerItems objectAtIndex:row];
    actionPicker.selectedItem.tag = row;
    buttonTitleLabel.text = actionPicker.selectedItem.itemValue;
    [self setSelectedItem:actionPicker.selectedItem];
}

@end
