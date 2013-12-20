//
//  AKYBubbleView.h
//  XiFangTong
//
//  Created by issuser on 13-9-17.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HouseInfo.h"
#import <MapKit/MapKit.h>

@protocol AKYBubbleViewDelegate <NSObject>

@optional

-(void)onClickDetail;

@end

@interface AKYBubbleView : UIView{
    
    UILabel         *fullNameLabel;
    UILabel         *referencePriceLabel;
    UIImageView     *logoImageView;
    UIImageView     *backgroundImageView;
}
@property (nonatomic, strong) UIButton *detailButton;
@property (nonatomic, strong) HouseInfo *houseInfo;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) id<AKYBubbleViewDelegate> moveAndSelectDelegate;


- (BOOL)showFromRect:(CGRect)rect;


@end
