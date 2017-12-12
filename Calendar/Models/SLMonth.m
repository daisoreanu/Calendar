//
//  SLMonth.m
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import "SLMonth.h"
#import "NSDate+Additions.h"

@implementation SLMonth

- (instancetype)initWithDate:(NSDate *)date
                andDateRange:(SLDateRange*)dateRange{
    if (self = [super init]) {
        self.dateRange = dateRange;
        self.currentMonth = date;
        self.daysArray = [self createMonthUsingDate:date];
    }
    return self;
}

- (NSMutableArray<SLDay*> *)createMonthUsingDate:(NSDate *)date{
    
    NSMutableArray<SLDay *> *returnedArray = [NSMutableArray new];
    
    int numberOfDaysInMonth = [self getTheNumberOfDaysInMonthForDay:date];
    NSDate *firstDayOfTheMonth = [date updateDay:1];
    NSDate *lastDayOfTheMonth = [date updateDay:numberOfDaysInMonth];
    //first day of the week for the first day of the month => the first day in a month is not necessary the first day in the week
    NSDate *firstDateOfWeek = [firstDayOfTheMonth dateAtStartOfWeek];
    if (![firstDayOfTheMonth isEqualToDateIgnoringTime:firstDateOfWeek]) {
        //find out the needed number of days from previous month
        int numberOfDaysFromPreviousMonth = (int)[firstDayOfTheMonth weekday] - 1;
        //add the day from previous month in the daysArray
        for (int count = numberOfDaysFromPreviousMonth; count > 0; count--) {
            NSDate *previousDate = [firstDayOfTheMonth dateBySubtractingDays:count];
            SLDay *day = [[SLDay alloc] initWithDate:previousDate
                                             andType:[self getDateTypeForDate:previousDate]];
            [returnedArray addObject:day];
        }
    }
    
    //add the days from current month
    for (int count = 1; count <= numberOfDaysInMonth; count++) {
        NSDate *updatedDay = [date updateDay:count];
        SLDay *day = [[SLDay alloc] initWithDate:updatedDay
                                         andType:[self getDateTypeForDate:updatedDay]];
        [returnedArray addObject:day];
    }
    
    //find out the number of days from next month
    int defaultNumberOfRows = 6;
    int defaultNumberOfColumns = 7;
    int numberOfDays = defaultNumberOfRows * defaultNumberOfColumns;//42
    
    int daysNeededToBeAdded = numberOfDays - (int)returnedArray.count;

    if (daysNeededToBeAdded  != 0) {
        //add the day from next month in the daysArray
        for (int count = 1; count <= daysNeededToBeAdded; count++) {
            NSDate *previousDate = [lastDayOfTheMonth dateByAddingDays:count];
            SLDay *day = [[SLDay alloc] initWithDate:previousDate
                                             andType:[self getDateTypeForDate:previousDate]];
            [returnedArray addObject:day];
        }
    }
    
    if (returnedArray.count != numberOfDays) {
        @throw [NSException exceptionWithName:@"SLMonth" reason:@"The number of NSDate's in a month must be equal to 42!" userInfo:nil];
    }
    
    
    return returnedArray;
    
}

- (int)getTheNumberOfDaysInMonthForDay:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                   inUnit:NSCalendarUnitMonth
                  forDate:date];
    return (int) range.length;
}


- (SLDayType)getDateTypeForDate:(NSDate *)date{

    if ([date isSameMonthAsDate: self.currentMonth]) {
        //check if out of range => normal cell
        if ([date isLaterThanDateIgnoringTime:self.dateRange.endDate] ||
            [date isEarlierThanDateIgnoringTime:self.dateRange.startDate]) {
            return SLDayTypeCurrentMonthNormal;
        }
        //Only one day is selected
        if ([date isEqualToDateIgnoringTime:self.dateRange.endDate] && [date isEqualToDateIgnoringTime:self.dateRange.startDate]) {
            return SLDayTypeCurrentMonthSingleSelection;
        }
        //Equal with the start of range
        if ([date isEqualToDateIgnoringTime:self.dateRange.startDate]) {
            return SLDayTypeCurrentMonthSelectedBeginning;
        }
        //Equal with the end of range
        if ([date isEqualToDateIgnoringTime:self.dateRange.endDate]) {
            return SLDayTypeCurrentMonthSelectedEnd;
        }
        //Inside the range
        if ([date isLaterThanDateIgnoringTime:self.dateRange.startDate] ||
            [date isEarlierThanDateIgnoringTime:self.dateRange.endDate]) {
            return SLDayTypeCurrentMonthSelectedMid;
        }
    }else{
        
        //check if out of range => normal cell
        if ([date isLaterThanDateIgnoringTime:self.dateRange.endDate] ||
            [date isEarlierThanDateIgnoringTime:self.dateRange.startDate]) {
            return SLDayTypeOtherMonthNormal;
        }
        
        //Only one day is selected
        if ([self.dateRange.startDate isEqualToDateIgnoringTime:self.dateRange.endDate] && [date isEqualToDateIgnoringTime:self.dateRange.startDate]) {
            return SLDayTypeOtherMonthSingleSelection;
        }
        
        //Equal with the start of range
        if ([date isEqualToDateIgnoringTime:self.dateRange.startDate]) {
            return SLDayTypeOtherMonthSelectedBeginning;
        }
        //Equal with the end of range
        if ([date isEqualToDateIgnoringTime:self.dateRange.endDate]) {
            return SLDayTypeOtherMonthSelectedEnd;
        }
        //Inside the range
        if ([date isLaterThanDateIgnoringTime:self.dateRange.startDate] &&
            [date isEarlierThanDateIgnoringTime:self.dateRange.endDate]) {
            return SLDayTypeOtherMonthSelectedMid;
        }
        
        
    }

    return SLDayTypeCurrentMonthNormal;
}



@end
