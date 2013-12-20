//
//  CustomTextField.m
//  XiFangTong
//
//  Created by issuser on 13-8-13.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField
@synthesize inputCheck;

- (BOOL) checkInputIsEmpty
{
    [self resignFirstResponder];
    NSError *error = nil;
    inputCheck_ = [[TextFieldInputCheck alloc] init];
    BOOL empty = [inputCheck_ checkTextFieldInputIsEmpty:self tip:@"输入字段不能为空" error:&error];
    if (empty) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                            message:[error localizedFailureReason]
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"确认", @"") otherButtonTitles:nil];
        [alertView show];
    }
        
    return empty;
}
-(BOOL)checkInputIsEmptyWithTip:(NSString *)tip
{
    inputCheck_ = [[TextFieldInputCheck alloc] init];
    [self resignFirstResponder];
    NSError *error = nil;
    
    BOOL empty = [inputCheck_ checkTextFieldInputIsEmpty:self tip:tip error:&error];
    if (empty) {
        
        [[[[UIApplication sharedApplication] delegate] window] makeToast:[error localizedFailureReason] duration:1.0 position:@"center"];
    }
    
    return empty;
}
-(BOOL)checkInputIsMobileNumber
{
    [self resignFirstResponder];
    BOOL result = [inputCheck_ checkTextFieldInputIsMobileNumber:self];
    if (!result) {
        [[[[UIApplication sharedApplication] delegate] window] makeToast:@"请输入正确的手机号!" duration:1.0 position:@"center"];
        return NO;
    }
    return YES;
}

@end
