//
//  MenuView.m
//  XiFangTong
//
//  Created by issuser on 13-7-26.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "MenuView.h"
#import "GuessLikeViewController.h"
@implementation MenuView
@synthesize button;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    
    }
    return self;
}

// backgroundImage:(UIImage *)backgroundImage
-(id)initWithFrame:(CGRect)frame text:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        //背景图片
//        backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        [self addSubview:backgroundImageView];
                
        //小图
//        imageView = [[UIImageView alloc] init];
//        [self addSubview:imageView];
        
        //按钮
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//        [button addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
//        [button addTarget:self action:@selector(buttonTouchCancel:) forControlEvents:UIControlEventTouchUpOutside];
        [self addSubview:button];
        [button setTitleColor:[UIColor colorWithRed:102/255.0 green:0/255.0 blue:0 alpha:1] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        backgroundImageView.image = backgroundImage;
        
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
-(void)buttonTouchDown:(id)sender
{
    textLabel.textColor = [UIColor colorWithRed:102/255.0 green:0/255.0 blue:0 alpha:1];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
