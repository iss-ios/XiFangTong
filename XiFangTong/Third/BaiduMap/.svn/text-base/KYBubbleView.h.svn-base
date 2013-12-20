//
//  KYBubbleView.h
//  DrugRef
//
//  Created by chen xin on 12-6-6.
//  Copyright (c) 2012年 Kingyee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "HouseInfo.h"

@protocol KYBubbleViewDelegate <NSObject>
@optional

-(void)onClickDetail;

@end

@interface KYBubbleView : UIView {
    
    UILabel         *fullNameLabel;
    UILabel         *referencePriceLabel;
    UIImageView     *logoImageView;
    UIImageView     *backgroundImageView;
}
@property (nonatomic, strong) UIButton *detailButton;
@property (nonatomic, strong) HouseInfo *houseInfo;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) id<KYBubbleViewDelegate> moveAndSelectDelegate;


- (BOOL)showFromRect:(CGRect)rect;



@end

