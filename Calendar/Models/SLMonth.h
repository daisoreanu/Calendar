//
//  SLMonth.h
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLDay.h"
#import "SLDateRange.h"
#import "NSDate+Additions.h"


@interface SLMonth : NSObject

- (instancetype)initWithDate:(NSDate *)date
                andDateRange:(SLDateRange*)dateRange;
@property (strong, nonatomic) NSMutableArray<SLDay*> *daysArray;
@property (strong, nonatomic) SLDateRange* dateRange;
@property (strong, nonatomic) NSDate *currentMonth;

@end
