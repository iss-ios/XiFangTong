//
//  JoinView.m
//  XiFangTong
//
//  Created by issuser on 13-8-29.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "JoinView.h"

@implementation JoinView
//@synthesize jStyle;
@synthesize name;
@synthesize phone;
@synthesize count;

-(id)initWithStyle:(JoinViewStyle)style
{
    if (style == kDefaultStyle) {
        //不含报名人数输入框的类型
        self = [[[NSBundle mainBundle] loadNibNamed:@"JoinViewDefault" owner:self options:nil] objectAtIndex:0];
    }
    else{
        //含报名人数输入框的类型
        self = [[[NSBundle mainBundle] loadNibNamed:@"JoinViewSpecial" owner:self options:nil] objectAtIndex:0];
    }
    
    if (self) {
        move = NO;
        jStyle = style;
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        
    }
    return self;
}
-(void)showInView:(UIView *)view
{
    /*
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"JoinActionSheet"];
     */
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.1];
	[UIView setAnimationDelegate:self];
	self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
	[UIView commitAnimations];
    
    if (jStyle == kDefaultStyle) {
        self.frame = CGRectMake((320-self.frame.size.width)/2.0, (screenHeight-240)/2.0, self.frame.size.width, self.frame.size.height);
    }
    else{
        self.frame = CGRectMake((320-self.frame.size.width)/2.0, (screenHeight-240)/2.0, self.frame.size.width, self.frame.size.height);
        
    }
    mBtnHidden=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 600)];
    mBtnHidden.alpha=0.3;
    mBtnHidden.backgroundColor=[UIColor blackColor];
    
    [mBtnHidden addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:mBtnHidden];
    
    [view addSubview:self];
}
-(void)hideView
{
    /*
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"JoinActionSheet"];
     */
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.1];
	[UIView setAnimationDelegate:self];
	self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
	[UIView commitAnimations];
    
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
    mBtnHidden.hidden=YES;
    mBtnHidden=0;
}
#pragma mark -
#pragma mark button & touch
-(void)cancel:(id)sender
{
    [nameTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    [countTextField resignFirstResponder];
}

-(IBAction)cancelButtonClicked:(id)sender
{
    if ([_delegate respondsToSelector:@selector(joinView:clickedButtonAtIndex:)])
        [_delegate joinView:self clickedButtonAtIndex:0];
    [self hideView];
    
}
-(IBAction)doneButtonClicked:(id)sender
{
    name = nameTextField.text;
    phone = phoneTextField.text;
    count = countTextField.text;
    
    if (jStyle == kDefaultStyle) {
        if (![nameTextField checkInputIsEmptyWithTip:@"请输入联系人姓名!"]&&![phoneTextField checkInputIsEmptyWithTip:@"请输入手机号码!"]&&[phoneTextField checkInputIsMobileNumber]) {
            if ([_delegate respondsToSelector:@selector(joinView:clickedButtonAtIndex:)])
                [_delegate joinView:self clickedButtonAtIndex:1];
            [self hideView];
        }
    }
    else{
        if (![nameTextField checkInputIsEmptyWithTip:@"请输入联系人姓名!"]&&![phoneTextField checkInputIsEmptyWithTip:@"请输入手机号码!"]&&![countTextField checkInputIsEmptyWithTip:@"请请输入报名人数!"]&&[phoneTextField checkInputIsMobileNumber]) {
            
            if ([_delegate respondsToSelector:@selector(joinView:clickedButtonAtIndex:)])
                [_delegate joinView:self clickedButtonAtIndex:1];
            [self hideView];
        }
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [nameTextField resignFirstResponder];
    [phoneTextField resignFirstResponder];
    [countTextField resignFirstResponder];
}

#pragma mark -
#pragma mark text field
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!move) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        self.frame = CGRectMake((320-self.frame.size.width)/2.0, (screenHeight-240-88)/2.0, self.frame.size.width, self.frame.size.height);
        [UIView commitAnimations];
        move = YES;
    }
}
@end
