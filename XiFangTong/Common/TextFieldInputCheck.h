//
//  TextFieldInputCheck.h
//  NewGMemo
//
//  Created by you on 13-5-16.
//  Copyright (c) 2013年 YanYou. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const InputErrorDomain = @"TextFieldInputErrorDomain";

@interface TextFieldInputCheck : NSObject

//验证textfield输入是否为空，若为空则提示
- (BOOL) checkTextFieldInputIsEmpty:(UITextField *) input tip:(NSString *) tipTitle error:(NSError **) error;

//验证邮箱合法性
- (BOOL) checkTextFieldInputIsValidateEmail:(UITextField *) input error:(NSError **) error;

//验证textfield输入字符是否与指定字符相同
- (BOOL) checkTextFieldInputIsEqualToString:(UITextField *) input string:(NSString *)string tip:(NSString *)tipTitle error:(NSError **)error;

//验证textfield输入字符是否为正确的手机号码格式
- (BOOL)checkTextFieldInputIsMobileNumber:(UITextField*)textField;


@end
