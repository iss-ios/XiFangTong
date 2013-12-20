//
//  CustomPickerView.m
//  XiFangTong
//
//  Created by issuser on 13-7-31.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "CustomPickerView.h"

#define kDuration 0.3

@implementation CustomPickerView
@synthesize selectedItem;
@synthesize picker;
@synthesize pickerItems;

#pragma mark -
#pragma mark init
- (id)initWithPickerItems:(NSArray *)items delegate:(id /*<UIActionSheetDelegate>*/)delegate tag:(int)tag
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"CustomPickerView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.delegate = delegate;
        picker.dataSource = self;
        picker.delegate = self;
        pickerItems = items;
        self.tag=tag;
        self.selectedItem = [[PickerItem alloc] init];
        self.selectedItem.itemValue = [pickerItems objectAtIndex:0];
        self.selectedItem.tag = 0;
    }
    return self;
}

- (void)showInView:(UIView *) view
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"CustomPickerView"];
    
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    
    mBtnHidden=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 600)];
    mBtnHidden.alpha=0.7;
    mBtnHidden.backgroundColor=[UIColor blackColor];
    [mBtnHidden addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:mBtnHidden];
    
    [view addSubview:self];
}

#pragma mark 
#pragma mark - picker view 
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
    self.selectedItem.itemValue = [pickerItems objectAtIndex:row];
    self.selectedItem.tag = row;
}

#pragma mark -
#pragma mark button lifecycle
-(void)hidePickerView
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"CPickerView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
}
- (IBAction)cancel:(id)sender
{
    
    [self hidePickerView];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
    mBtnHidden.hidden=YES;
    mBtnHidden=0;
}

- (IBAction)done:(id)sender
{
    [self hidePickerView];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
    mBtnHidden.hidden=YES;
    mBtnHidden=0;
}

@end
