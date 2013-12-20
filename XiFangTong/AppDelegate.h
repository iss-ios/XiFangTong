//
//  AppDelegate.h
//  XiFangTong
//
//  Created by issuser on 13-7-26.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reachability;
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    BMKMapManager *mapManager;
    Reachability  *hostReach;
}
@property (strong, nonatomic) UIWindow *window;

@end
