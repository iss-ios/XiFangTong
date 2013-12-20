//
//  JoinSuccessView.h
//  XiFangTong
//
//  Created by issuser on 13-9-10.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinSuccessView : UIView
{
    IBOutlet UILabel *textLabel;
    IBOutlet UIButton *hiddenButton;
}
-(id)initWithText:(NSString *)text;
-(void)show;

@end
