//
//  HomeViewController.h
//  XiFangTong
//
//  Created by issuser on 13-7-26.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GetImageListRequest.h"

@interface HomeViewController : UIViewController<GetImageListRequestDelegate>
{
    IBOutlet UIImageView *pageImageView;
    IBOutlet UIImageView *topImageView;
    
    GetImageListRequest  *imageRequest;
}

@end
