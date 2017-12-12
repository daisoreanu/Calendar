//
//  SLDay.m
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 08/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import "SLDay.h"

@implementation SLDay
- (instancetype)initWithDate:(NSDate *) date
                     andType:(SLDayType)dateType{
    if (self = [super init]) {
        self.date = date;
        self.dateType = dateType;
    }
    return self;
}
@end
