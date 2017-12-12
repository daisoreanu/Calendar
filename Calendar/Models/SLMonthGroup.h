//
//  SLMonthGroup.h
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLMonth.h"
#import "SLCalendarDelegate.h"

@interface SLMonthGroup : NSObject<SLCalendarDelegate, SLDateRangeUpdateProtocol>

@property (strong, nonatomic) NSMutableArray *monthsArray;
@property (strong, nonatomic) SLDateRange *dateRange;
@property (assign, nonatomic) BOOL shouldAutoScroll;

//numberOfMonthsPreloaded = the number of months preloaded in one direction  - left or right.
//totalNumberOfMonths = numberOfMonthsPreloaded * 2(both sides, right + left) + 1(the cell situated in the middle)
//numberOfMonthsPreloaded must be an uneven number so we have a cell in the middle
//The minimum value for numberOfMonthsPreloaded must be 3(one left cell + one midddle cell + right cell)
@property (assign, nonatomic) int numberOfMonthsPreloaded;
@property (assign, nonatomic) int totalNumberOfMonths;
@property (assign, nonatomic) int firstCellIndex;
@property (assign, nonatomic) int lastCellIndex;
@property (assign, nonatomic) int middleCellIndex;
@property (assign, nonatomic) int currentMonthDisplayedIndex;
@property (strong, nonatomic) SLMonth *currentMonthDisplayed;

- (instancetype)initWithCurrentDate:(NSDate *)date
                   andSelectedRange:(SLDateRange *)dateRange
         andNumberOfMonthsPreloaded:(int)numberOfMonthsPreloaded;
- (void)updateAutoScroll:(BOOL)shouldAutoScroll;
- (void)updateDateRangeWithDate:(NSDate *)date;
- (void)updateDateRangeWithStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate;
- (void)recreateMonthsGroupForIndex:(int)index;
- (NSString *)getMonthStringFromCurrentMonthDisplayed;
- (NSString *)getYearStringFromCurrentMonthDisplayed;

@end
