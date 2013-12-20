//
//  TaxObject.m
//  XiFangTong
//
//  Created by issuser on 13-8-30.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "TaxObject.h"

@implementation TaxObject
@synthesize houseUnitPrice;
@synthesize houseArea;
@synthesize houseType;
@synthesize withLift;
@synthesize houseIsOnly;
@synthesize houseTotalPrice;
@synthesize stampTax;
@synthesize propertyCosts;
@synthesize deedTax;

-(void)countTax
{
    houseTotalPrice = [NSString stringWithFormat:@"%.f元",[houseUnitPrice floatValue]*[houseArea floatValue]];
    if (houseType == kNormalType) {
        stampTax = @"0元";
        if (houseIsOnly == kOnlySmall) {
            deedTax = [NSString stringWithFormat:@"%.2f元",[houseTotalPrice floatValue]*1/100];

        }
        else if (houseIsOnly == kOnlyBig){
            deedTax = [NSString stringWithFormat:@"%.2f元",[houseTotalPrice floatValue]*1.5/100];

        }
        else{
            deedTax = [NSString stringWithFormat:@"%.2f元",[houseTotalPrice floatValue]*3/100];

        }
    }
    else if (houseType == kUnNormalType){
        stampTax = @"0元";
        deedTax = [NSString stringWithFormat:@"%.2f元",[houseTotalPrice floatValue]*3/100];
    }
    else{
        stampTax = [NSString stringWithFormat:@"%.2f元",[houseTotalPrice floatValue]*0.05/100];
        deedTax = [NSString stringWithFormat:@"%.2f元",[houseTotalPrice floatValue]*3/100];
    }
    if (withLift == kWithLift) {
        propertyCosts = [NSString stringWithFormat:@"%u元",[houseArea integerValue]*90];
    }
    else{
        propertyCosts = [NSString stringWithFormat:@"%u元",[houseArea integerValue]*50];
    }
}

@end
