//
//  SLDay.h
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 08/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLDayTypeEnum.h"

@interface SLDay : NSObject

@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) SLDayType dateType;

- (instancetype)initWithDate:(NSDate *) date
                     andType:(SLDayType)dateType;

@end
