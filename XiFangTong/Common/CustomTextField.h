//
//  CustomTextField.h
//  XiFangTong
//
//  Created by issuser on 13-8-13.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldInputCheck.h"

@interface CustomTextField : UITextField
{
@private
    TextFieldInputCheck *inputCheck_;

}
@property (strong, nonatomic) IBOutlet TextFieldInputCheck *inputCheck;

- (BOOL) checkInputIsEmpty;
- (BOOL) checkInputIsEmptyWithTip:(NSString *)tip;
- (BOOL) checkInputIsMobileNumber;

@end
