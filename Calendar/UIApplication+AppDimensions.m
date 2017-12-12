//
//  UIApplication+AppDimensions.m
//  Granular
//
//  Created by Valentin Diaconeasa on 3/24/14.
//  Copyright (c) 2014 Solum. All rights reserved.
//

#import "UIApplication+AppDimensions.h"
#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@implementation UIApplication (AppDimensions)

+(CGSize) currentSize
{
    return [UIApplication sizeInOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIApplication *application = [UIApplication sharedApplication];
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        size = CGSizeMake(size.height, size.width);
    }
    if (application.statusBarHidden == NO)
    {
        size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
    }
    return size;
}




+ (UIDeviceOrientation)deviceOrientation{
    return [[UIDevice currentDevice] orientation];
}

+ (UIInterfaceOrientation)interfaceOrientation{
    return [[UIApplication sharedApplication] statusBarOrientation];
}

+ (double)statusBarHeight{
    if ([UIApplication sharedApplication].statusBarHidden == NO)
    {
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return 0.0;
}




@end

