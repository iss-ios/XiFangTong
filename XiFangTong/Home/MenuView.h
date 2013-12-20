//
//  MenuView.h
//  XiFangTong
//
//  Created by issuser on 13-7-26.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView
{
    IBOutlet UIImageView *backgroundImageView;
    IBOutlet UILabel *textLabel;
    IBOutlet UIImageView *imageView;
//    IBOutlet UIButton *button;
}
//@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
//@property (strong, nonatomic) IBOutlet UILabel *textLabel;
//@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *button;


// backgroundImage:(UIImage *)backgroundImage
-(id)initWithFrame:(CGRect)frame text:(NSString *)title;

@end
