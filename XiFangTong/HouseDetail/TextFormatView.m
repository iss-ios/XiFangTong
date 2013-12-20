//
//  HouseDetailHeaderView.m
//  XiFangTong
//
//  Created by issuser on 13-9-23.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "TextFormatView.h"

@implementation TextFormatView

-(id)initWithPoint:(CGPoint)point textTitleArray:(NSArray *)titles contentArray:(NSArray *)contents
{
    self = [super init];
    if (self) {
//        contentTexts = contents;
        CGFloat originalY = 0.0;
        
        for (int i = 0; i<contents.count; i++) {
           
            //文字内容
            UILabel *contentLabel = [[UILabel alloc] init];
            contentLabel.backgroundColor = [UIColor clearColor];
            contentLabel.textColor = [UIColor darkGrayColor];
            contentLabel.numberOfLines = 100;
            NSString *text = [contents objectAtIndex:i];
            contentLabel.text = text;
           
            //计算label的高度
            UIFont *font = [UIFont systemFontOfSize:17];
            CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(200.0f, 1000.0f) lineBreakMode:NSLineBreakByCharWrapping];
            
            contentLabel.frame = CGRectMake(85, originalY, size.width, size.height);
            if (size.height == 0) {
                contentLabel.frame = CGRectMake(85, originalY, size.width, 21);
            }
            contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
           
            [self addSubview:contentLabel];
            
            
            //文字标题
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textColor = [UIColor darkGrayColor];
            titleLabel.numberOfLines = 100;

            titleLabel.frame = CGRectMake(0, originalY, 85, 21);
            titleLabel.text = [titles objectAtIndex:i];
            [self addSubview:titleLabel];
          
            //view尺寸
            originalY = originalY+contentLabel.frame.size.height+5;
            self.frame = CGRectMake(point.x, point.y, 320, originalY);
            
        }
    }
    return self;
}
+(CGFloat)countViewHeightWithTextArray:(NSArray *)contents
{
    CGFloat originalY = 10.0;
    for (int i = 0; i<contents.count; i++) {
        
        NSString *text = [contents objectAtIndex:i];
        UIFont *font = [UIFont systemFontOfSize:17];
        CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(200.0f, 1000.0f) lineBreakMode:NSLineBreakByCharWrapping];
        
        originalY = originalY+size.height+5;
        if (size.height == 0) {
            originalY = originalY+21+5;

        }
    }
    return originalY;
}

@end
