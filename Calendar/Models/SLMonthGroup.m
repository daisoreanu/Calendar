//
//  SLMonthGroup.m
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import "SLMonthGroup.h"

@implementation SLMonthGroup

- (instancetype)initWithCurrentDate:(NSDate *)date
                   andSelectedRange:(SLDateRange *)dateRange
         andNumberOfMonthsPreloaded:(int)numberOfMonthsPreloaded{
    if (self = [super init]) {
        self.numberOfMonthsPreloaded = numberOfMonthsPreloaded;
        self.dateRange = dateRange;
        self.shouldAutoScroll = YES;
        [self createMonthsArrayWithDate:date];
    }
    return self;
}

- (void)createMonthsArrayWithDate:(NSDate *)date{
    
    NSMutableArray *newMonthsArray = [[NSMutableArray alloc] initWithArray:self.monthsArray];

    int startPoint = self.totalNumberOfMonths;
    int newMonthsCount = self.totalNumberOfMonths;
    int monthIndex = -self.middleCellIndex;
    if (self.monthsArray) {
        self.shouldAutoScroll = YES;
        newMonthsCount = self.numberOfMonthsPreloaded;
        SLMonth *middleMonth = [self.monthsArray objectAtIndex:self.middleCellIndex];
        BOOL movedForword = ![date isEarlierThanDate:middleMonth.currentMonth];
        if (movedForword) {
            startPoint = 0;
            monthIndex = self.middleCellIndex;
        }
    }
    
    //adding the new objects
    for (int count = 0; count < newMonthsCount; count++) {
        NSDate *newMonthDate = [date dateByAddingMonth:monthIndex + count];
        SLMonth *month = [[SLMonth alloc] initWithDate:newMonthDate andDateRange:self.dateRange];
        [newMonthsArray addObject:month];
    }
    
    if (newMonthsArray.count > [self totalNumberOfMonths]) {
        //sort the object by date
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"currentMonth"
                                                                       ascending:YES];
        newMonthsArray = [[NSMutableArray alloc] initWithArray:[newMonthsArray sortedArrayUsingDescriptors:@[sortDescriptor]]];
        
        //removing the old data newMonthsCount
        for (int count = startPoint; count < startPoint + newMonthsCount; count++) {
            [newMonthsArray removeObjectAtIndex:count];
        }
    }
    
    self.currentMonthDisplayedIndex = self.middleCellIndex;
    
    self.monthsArray = newMonthsArray;
}


//The index passed is the index of the MonthCell from the collection view
- (void)recreateMonthsGroupForIndex:(int)index{
    if (index == [self firstCellIndex] || index == [self lastCellIndex]) {
        //only recreate the group array if it reached the end of the array
        //we avoi unnecessary reloads
        SLMonth *month = [self.monthsArray objectAtIndex:index];
        [self createMonthsArrayWithDate:month.currentMonth];
    }else{
        self.currentMonthDisplayedIndex = index;
    }
}

- (void)updateAutoScroll:(BOOL)shouldAutoScroll{
    self.shouldAutoScroll = shouldAutoScroll;
}

- (void)updateDateRangeWithStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate{
    self.dateRange.startDate = startDate;
    self.dateRange.endDate = endDate;
    self.shouldAutoScroll = YES;
    NSDate *newDate = [[self.monthsArray objectAtIndex:self.middleCellIndex] currentMonth];
    self.monthsArray = nil;
    [self createMonthsArrayWithDate:newDate];
}

- (void)updateDateRangeWithDate:(NSDate *)date{
    [self.dateRange updateDateRangeWithDate:date];
    self.shouldAutoScroll = YES;
    NSDate *newDate = [[self.monthsArray objectAtIndex:self.middleCellIndex] currentMonth];
    self.monthsArray = nil;
    [self createMonthsArrayWithDate:newDate];
}

- (int)numberOfMonthsPreloaded{
    if (_numberOfMonthsPreloaded < 1) {
        _numberOfMonthsPreloaded = 1;
        @throw [NSException exceptionWithName:@"SLMonthGroup" reason:@"_numberOfMonthsPreloaded must be larger or equal with 1!" userInfo:nil];
    }
    return _numberOfMonthsPreloaded;
}

- (int)totalNumberOfMonths{
    _totalNumberOfMonths = [self numberOfMonthsPreloaded] * 2 + 1;
    if (_totalNumberOfMonths < 3) {
        _totalNumberOfMonths = 3;
        @throw [NSException exceptionWithName:@"SLMonthGroup" reason:@"_totalNumberOfMonths must have the value of a least 3!" userInfo:nil];
    }
    if (_totalNumberOfMonths % 2 != 1) {
        _totalNumberOfMonths++;
        @throw [NSException exceptionWithName:@"SLMonthGroup" reason:@"_totalNumberOfMonths must be an uneven number!" userInfo:nil];
    }
    return _totalNumberOfMonths;
}

- (int)firstCellIndex{
    return 0;
}

- (int)lastCellIndex{
    return self.numberOfMonthsPreloaded * 2;
}

- (int)middleCellIndex{
    return self.numberOfMonthsPreloaded;
}

- (NSString *)getMonthStringFromCurrentMonthDisplayed{
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"MMMM"];
    NSString *title = [df stringFromDate:self.currentMonthDisplayed.currentMonth];
    return title;
}

- (NSString *)getYearStringFromCurrentMonthDisplayed{
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy"];
    NSString *title = [df stringFromDate:self.currentMonthDisplayed.currentMonth];
    return title;
}

- (SLMonth *)currentMonthDisplayed{
    return [self.monthsArray objectAtIndex:self.currentMonthDisplayedIndex];
}

@end
