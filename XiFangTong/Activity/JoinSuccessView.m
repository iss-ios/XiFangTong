//
//  JoinSuccessView.m
//  XiFangTong
//
//  Created by issuser on 13-9-10.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "JoinSuccessView.h"

@implementation JoinSuccessView

-(id)initWithText:(NSString *)text
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"JoinSuccessView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        textLabel.text = text;
    }
    return self;
}
-(void)show
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.1];
	[UIView setAnimationDelegate:self];
	self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
	[UIView commitAnimations];
    
    self.frame = CGRectMake((320-self.frame.size.width)/2.0,0,self.frame.size.width,screenHeight+20);
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void)hideView
{
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
}
-(IBAction)hiddenButtonClicked:(id)sender
{
    [self hideView];
}

@end
