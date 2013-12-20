//
//  MenuViewGenerator.m
//  XiFangTong
//
//  Created by issuser on 13-7-30.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "MenuViewGenerator.h"

#import "MenuButton.h"

#import "GuessLikeViewController.h"
#import "SearchHouseViewController.h"
#import "ActivityViewController.h"
#import "MapViewController.h"
#import "MoreViewController.h"
#import "GuideViewController.h"
#import "GroupBuyViewController.h"
#import "TaxViewController.h"
#import "MortgageViewController.h"
#import "AppleMapViewController.h"

@implementation MenuViewGenerator


-(id)initWithFrame:(CGRect)frame titles:(NSArray *)titles activeController:(UIViewController *)controller
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        activeController_ = controller;
        for (int i = 0; i < titles.count; i++) {
            
            NSString *title = [titles objectAtIndex:i];
            
            CGFloat w = (320-95*3)/4.0;
            CGFloat h = (frame.size.height-110*3)/4.0;
           
            MenuButton *menuView = [[MenuButton alloc] initWithFrame:CGRectMake(w+w*(i%3)+(i%3)*95, h+h*(i/3)+(i/3)*110, 95, 110) text:title];
            menuView.tag = i;
            
            [menuView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"grid_bg%i",i+1]] forState:UIControlStateNormal];
            
            [menuView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"grid_bg%i_pressed",i+1]] forState:UIControlStateHighlighted];
            
            [menuView addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

            [self addSubview:menuView];
            
            if (i == 6 || i == 8) {
                UIImageView *leftDownImageView = [[UIImageView alloc] init];
                if (i == 6) {
                    leftDownImageView.image = [UIImage imageNamed:@"leftdown_bg.png"];
                }
                else{
                    leftDownImageView.image = [UIImage imageNamed:@"rightdown_bg.png"];
                }
                leftDownImageView.frame = CGRectMake(menuView.frame.origin.x, menuView.frame.origin.y+menuView.frame.size.height, menuView.frame.size.width, screenHeight-menuView.frame.origin.y-menuView.frame.size.height);
                leftDownImageView.alpha = 0.7;
                [self addSubview:leftDownImageView];
            }
        }
    }
    return self;
}
//主界面按钮点击事件
-(void)buttonClicked:(UIButton *)sender
{
    int btag = [sender tag];
    switch (btag) {
        case 0:
        {
            SearchHouseViewController *searchHouse = [[SearchHouseViewController alloc] init];
            [activeController_.navigationController pushViewController:searchHouse animated:YES];
        }
            break;
        case 1:
        {
//            AppleMapViewController *appleMap = [[AppleMapViewController alloc] init];
//            [activeController_.navigationController pushViewController:appleMap animated:YES];
            MapViewController *map = [[MapViewController alloc] init];
            [activeController_.navigationController pushViewController:map animated:YES];
        }
            break;
        case 2:
        {
            GuessLikeViewController *like = [[GuessLikeViewController alloc] init];
            [activeController_.navigationController pushViewController:like animated:YES];
        }
            break;
        case 3:
        {
            ActivityViewController *activity = [[ActivityViewController alloc] init];
            [activeController_.navigationController pushViewController:activity animated:YES];
        }
            break;
        case 4:
        {
            GuideViewController *guide = [[GuideViewController alloc] init];
            [activeController_.navigationController pushViewController:guide animated:YES];
        }
            break;
        case 5:
        {
            GroupBuyViewController *groupBuy = [[GroupBuyViewController alloc] init];
            [activeController_.navigationController pushViewController:groupBuy animated:YES];
            
        }
            break;
        case 6:
        {
            MortgageViewController *mortgage = [[MortgageViewController alloc] init];
            [activeController_.navigationController pushViewController:mortgage animated:YES];
        }
            break;
        case 7:
        {
            TaxViewController *tax = [[TaxViewController alloc] init];
            [activeController_.navigationController pushViewController:tax animated:YES];
        }
            break;
        case 8:
        {
            MoreViewController *more = [[MoreViewController alloc] init];
            [activeController_.navigationController pushViewController:more animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

@end
