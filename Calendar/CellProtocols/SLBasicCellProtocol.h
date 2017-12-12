//
//  SLBasicCellProtocol.h
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SLBasicCellProtocol <NSObject>

+ (CGFloat)cellHeight;
+ (NSString *)cellIdentifier;

@end

