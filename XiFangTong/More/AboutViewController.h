//
//  AboutViewController.h
//  XiFangTong
//
//  Created by issuser on 13-8-2.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasedViewController.h"
#import "GetImageListRequest.h"
@interface AboutViewController : BasedViewController<GetImageListRequestDelegate>
{
    IBOutlet UIImageView *aboutImageView;
    GetImageListRequest *imageRequest;
}
@end
