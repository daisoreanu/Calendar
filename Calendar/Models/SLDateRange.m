//
//  SLDateRange.m
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import "SLDateRange.h"
#import "NSDate+Additions.h"

@implementation SLDateRange

- (instancetype)init{
    if (self = [super init]) {
        self.allowsRangeSelection = YES;
    }
    return self;
}

- (void)updateDateRangeWithDate:(NSDate *)date{
    if (!self.endDate || !self.startDate) {
        self.endDate = date;
        self.startDate = date;
        return;
    }
    
    if ([date isLaterThanDateIgnoringTime:self.startDate] && [self.startDate isEqualToDateIgnoringTime:self.endDate] && self.allowsRangeSelection) {
        self.endDate = date;
        return;
    }
    
    self.startDate = date;
    self.endDate = date;
    return;
}

@end
