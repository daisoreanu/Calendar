//
//  SLDateRange.h
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLDateRangeUpdateProtocol.h"

@interface SLDateRange : NSObject<SLDateRangeUpdateProtocol>

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (assign, nonatomic) BOOL allowsRangeSelection; //set by default to YES

- (void)updateDateRangeWithDate:(NSDate *)date;

@end
