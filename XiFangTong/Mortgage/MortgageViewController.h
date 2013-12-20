//
//  MortgageViewController.h
//  XiFangTong
//
//  Created by issuser on 13-8-6.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BasedViewController.h"
#import "MortgageTableView.h"
#import "CheckButtonCombination.h"
#import "AKSegmentedControl.h"
#import "MShowPickerButton.h"

typedef enum
{
    kPercentTag,
    kYearTag,
    kFundRateTag,
    kLoanRateTag,
    kCombinationRateTag
    
}PickerButtonTag;

@interface MortgageViewController : BasedViewController<UITableViewDataSource,UITableViewDelegate,CheckButtonCombinationDelegate,AKSegmentedControlDelegate,UITextFieldDelegate,MShowPickerButtonDelegate>
{
    IBOutlet MortgageTableView *table;
    AKSegmentedControl *topSegment;
    NSIndexPath *editingIndexPath;
}

@end
