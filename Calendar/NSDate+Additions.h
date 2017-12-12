//
//  NSDate+Additions.h
//  Solum
//
//  Created by Valentin Diaconeasa on 10/16/13.
//  Copyright (c) 2013 Solum. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR      3600
#define D_DAY		86400
#define D_WEEK      604800
#define D_YEAR      31556926

@interface NSDate (Additions)

+ (NSInteger)hourDifferenceBetweenDates:(NSDate*)firstDate andSecondDate:(NSDate*)secondDate;
+ (NSString*)dateStringWithEasyFormatFromDate:(NSDate*)date;
+ (NSString*)dateStringUsingFormat:(NSString *)stringFormat
                           andDate:(NSDate *)date;
- (NSDate*)midnightDate;
- (NSDate*)midnightDateWithTimeZone:(NSTimeZone*)timeZone;

- (NSInteger)getYearUsingTimezone:(NSTimeZone *)timeZone;
- (NSString *)lastUpdate;

// Relative dates from the current date
+ (NSDate *)dateTomorrow;
+ (NSDate *)dateYesterday;

- (NSDate *)dateAtStartOfDay;
- (NSDate *)dateAtEndOfDay;
- (NSDate *)dateAtStartOfWeek;
- (NSDate *)dateAtEndOfWeek;
- (NSDate *)dateAtStartOfMonth;

- (NSDate *)updateDay:(NSInteger)day;
- (NSDate *)updateWeekday:(NSInteger)weekday;
- (NSDate *)updateMonth:(NSInteger)month;
- (NSDate *)updateYear:(NSInteger)year;

+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)dateWithHoursFromNow:(NSInteger)hours;
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)hours;
+ (NSDate *)dateWithMinutesFromNow:(NSInteger)minutes;
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)minutes;

// Adjusting dates
- (NSDate *)dateByAddingYear:(NSInteger)year;
- (NSDate *)dateBySubtractingYear:(NSInteger)year;
- (NSDate *)dateByAddingMonth:(NSInteger)month;
- (NSDate *)dateBySubtractingMonth:(NSInteger)month;
- (NSDate *)dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)dateBySubtractingWeeks:(NSInteger)weeks;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateBySubtractingDays:(NSInteger)days;
- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateBySubtractingHours:(NSInteger)hours;
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes;

// Retrieving intervals
- (NSInteger)minutesAfterDate:(NSDate *)date;
- (NSInteger)minutesBeforeDate:(NSDate *)date;
- (NSInteger)hoursAfterDate:(NSDate *)date;
- (NSInteger)hoursBeforeDate:(NSDate *)date;
- (NSInteger)daysAfterDate:(NSDate *)date;
- (NSInteger)daysBeforeDate:(NSDate *)date;

// Comparing dates
- (BOOL)isEarlierThanDateIgnoringTime:(NSDate *)date;
- (BOOL)isLaterThanDateIgnoringTime:(NSDate *)date;
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)date;
- (BOOL)isEqualToTimeIgnoringDate:(NSDate *)date;
- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;
- (BOOL)isSameWeekAsDate:(NSDate *)date;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;
- (BOOL)isSameMonthAsDate:(NSDate *)date;
//- (BOOL)isThisWeek;
//- (BOOL)isNextWeek;
//- (BOOL)isLastWeek;
- (BOOL)isSameYearAsDate:(NSDate *)date;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;
- (BOOL)isEarlierThanDate:(NSDate *)date;
- (BOOL)isLaterThanDate:(NSDate *)date;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

// Generate formatted strings
- (NSString *)string;
- (NSString *)stringDateWithFormat:(NSString *)format;
- (NSString *)stringDateWithStyle:(NSDateFormatterStyle)style;
- (NSString *)stringTimeWithStyle:(NSDateFormatterStyle)style;
- (NSString *)stringDateTimeWithStyle:(NSDateFormatterStyle)style;
- (NSString *)stringUTCDateTimeWithStyle:(NSDateFormatterStyle)style;
- (NSString*)formatRelativeTimeForDay:(NSString *)d hour:(NSString *)h minute:(NSString *)m second:(NSString *)s;

+ (NSString*)formatedTimeStampFromIntervals:(int)intervals;

// Generate dates
+ (NSDate *)dateWithDatePart:(NSDate *)date andTimePart:(NSDate *)time;
+ (NSDate *)dateFromInternetDateTimeString:(NSString *)dateString;


- (NSDate *)dateToGMT;

@end

@interface NSCalendar (Extra)
+ (id)UTCCalendar;
+ (id)defaultSystemCalendar;
+ (id)calendarWithTimeZone:(NSString *)timezone;
@end
