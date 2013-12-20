//
//  CheckButtonCombination.m
//  XiFangTong
//
//  Created by issuser on 13-8-7.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "CheckButtonCombination.h"

@interface CheckButtonCombination ()

/**
 Buttons target method
 */
- (void)segmentButtonPressed:(id)sender;

@end

@implementation CheckButtonCombination

-(id)initWithFrame:(CGRect)frame leftTitle:(NSString *)lTitle rightTitle:(NSString *)rTitle andSelecteIndex:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        
        leftCheckButton = [[CheckButton alloc] initWithFrame:CGRectMake(0, 0, 90, 35) andTitle:lTitle];
        leftCheckButton.tag = 0;
        rightCheckButton = [[CheckButton alloc] initWithFrame:CGRectMake(105, 0, 90, 35) andTitle:rTitle];
        rightCheckButton.tag = 1;
        
        [self addSubview:leftCheckButton];
        [self addSubview:rightCheckButton];

        [leftCheckButton addTarget:self action:@selector(segmentButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [rightCheckButton addTarget:self action:@selector(segmentButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self setSelectedIndex:index];
    }
    return self;
}
-(void)segmentButtonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (!button || ![button isKindOfClass:[UIButton class]])
        return;
    
    NSUInteger sindex = button.tag;
    if (sindex == 0 ) {
        if (!leftCheckButton.checked) {
            leftCheckButton.checked = YES;
            
            rightCheckButton.checked = NO;
            [self setSelectedIndex:0];
        }
        
    }
    else if(sindex == 1 )
    {
        if (!rightCheckButton.checked) {
            rightCheckButton.checked = YES;
            leftCheckButton.checked = NO;
            [self setSelectedIndex:1];
        }
        
    }
    if ([_delegate respondsToSelector:@selector(checkButtonBecomeFirstResponder:)])
        [_delegate checkButtonBecomeFirstResponder:self];
}
-(void)setSelectedIndex:(NSInteger)selectedSegIndex
{
    if (selectedSegIndex == 0) {
        leftCheckButton.checked = YES;
        rightCheckButton.checked = NO;
    }
    else{
        leftCheckButton.checked = NO;
        rightCheckButton.checked = YES;
    }
    if (_selectedIndex != selectedSegIndex )
    {
        _selectedIndex = selectedSegIndex;
        
        if ([_delegate respondsToSelector:@selector(checkStyleSegmentControl:touchedAtIndex:)])
            [_delegate checkStyleSegmentControl:self touchedAtIndex:selectedSegIndex];
    }
}

@end
