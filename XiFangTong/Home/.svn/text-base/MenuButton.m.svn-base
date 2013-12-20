//
//  MenuButton.m
//  XiFangTong
//
//  Created by issuser on 13-9-6.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "MenuButton.h"

@implementation MenuButton

-(id)initWithFrame:(CGRect)frame text:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
                
        //显示文字
        textLabel = [[UILabel alloc] init];
        textLabel.frame = CGRectMake(15, 15, 70, 21);
        textLabel.font = [UIFont boldSystemFontOfSize:16.0];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:textLabel];
        textLabel.text = title;
    }
    return self;
}
/**
 设置按钮点击后文字颜色
 **/
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    textLabel.textColor = [UIColor colorWithRed:102/255.0 green:0 blue:0 alpha:1];
    return YES;
}
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.state == UIControlStateHighlighted) {
        textLabel.textColor = [UIColor colorWithRed:102/255.0 green:0 blue:0 alpha:1];
    }
    else{
        textLabel.textColor = [UIColor whiteColor];
    }
    return YES;
}
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    textLabel.textColor = [UIColor whiteColor];
}
-(void)cancelTrackingWithEvent:(UIEvent *)event
{
    textLabel.textColor = [UIColor whiteColor];
}

@end
