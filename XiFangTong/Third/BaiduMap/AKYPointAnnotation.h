//
//  AKYPointAnnotation.h
//  XiFangTong
//
//  Created by issuser on 13-9-17.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface AKYPointAnnotation : MKPointAnnotation
{
    NSUInteger tag;
}

@property NSUInteger tag;

@end
