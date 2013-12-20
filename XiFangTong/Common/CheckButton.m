//
//  CheckButton.m
//  XiFangTong
//
//  Created by issuser on 13-8-6.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "CheckButton.h"


@implementation CheckButton

#define buttonHeight  40.0

@synthesize checked;

-(id)initWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 5, 25, 25);
        [self addSubview:imageView];
        
        checked = NO;
        
        imageView.image = [UIImage imageNamed:@"radiobutton_notselected"];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(30, 7, 60, 21);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor darkGrayColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        titleLabel.text = title;
        [self addSubview:titleLabel];
                
    }
    return self;
}

-(void)setChecked:(BOOL)state
{
    checked = state;
    
    if (state) {
        imageView.image = [UIImage imageNamed:@"radiobutton_selected"];
    }
    else{
        imageView.image = [UIImage imageNamed:@"radiobutton_notselected"];
    }
}


@end
