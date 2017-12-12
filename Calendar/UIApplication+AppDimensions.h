//
//  UIApplication+AppDimensions.h
//  Granular
//
//  Created by Valentin Diaconeasa on 3/24/14.
//  Copyright (c) 2014 Solum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (AppDimensions)
+(CGSize) currentSize;
+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation;
+ (UIDeviceOrientation)deviceOrientation;
+ (UIInterfaceOrientation)interfaceOrientation;
+ (double)statusBarHeight;
@end
