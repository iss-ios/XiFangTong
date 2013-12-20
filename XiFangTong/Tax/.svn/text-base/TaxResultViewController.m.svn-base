//
//  TaxResultViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-30.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "TaxResultViewController.h"
#import "TaxResultCell.h"

@interface TaxResultViewController ()
{
    NSArray *cellTitles;
    NSArray *cellValues;
}
@end

@implementation TaxResultViewController

@synthesize taxObject;

#pragma mark -
#pragma mark view
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    cellTitles = [NSArray arrayWithObjects:@"房  屋   总  价:",@"合 同 印 花 税:",@"契              税:",@"物业维修资金:", nil];
    if (taxObject != nil) {
        [taxObject countTax];
    }
    cellValues = [NSArray arrayWithObjects:taxObject.houseTotalPrice,taxObject.stampTax,taxObject.deedTax,taxObject.propertyCosts, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{    
    return @"*以上计算仅供参考，具体按实际结算金额为准";
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Tax cell";
    TaxResultCell *cell = (TaxResultCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"TaxResultCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[TaxResultCell class]]){
                cell = (TaxResultCell *)o;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
        }
    }
    cell.leftLabel.text = [cellTitles objectAtIndex:indexPath.row];
    cell.rightLabel.text = [cellValues objectAtIndex:indexPath.row];
    
    return cell;
    
}

@end
