//
//  CheckButtonCombination.h
//  XiFangTong
//
//  Created by issuser on 13-8-7.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckButton.h"

@class CheckButtonCombination;

@protocol CheckButtonCombinationDelegate <NSObject>

@optional
- (void)checkStyleSegmentControl:(CheckButtonCombination *)segmentedControl touchedAtIndex:(NSUInteger)index;
- (void)checkButtonBecomeFirstResponder:(CheckButtonCombination *)segmentedControl;

@end

@interface CheckButtonCombination : UIView
{
    CheckButton *leftCheckButton;
    CheckButton *rightCheckButton;
}
@property (nonatomic, assign) id<CheckButtonCombinationDelegate> delegate;

@property (nonatomic) NSInteger selectedIndex;

-(id)initWithFrame:(CGRect)frame leftTitle:(NSString *)lTitle rightTitle:(NSString *)rTitle andSelecteIndex:(NSInteger)index;
-(void)setSelectedIndex:(NSInteger)selectedSegIndex;

@end
