//
//  NSDate+Additions.m
//  Solum
//
//  Created by Valentin Diaconeasa on 10/16/13.
//  Copyright (c) 2013 Solum. All rights reserved.
//

#import "NSDate+Additions.h"
#import <CoreGraphics/CoreGraphics.h>

#define kToday  [NSDate date]

@interface NSDate (Private)
+ (NSInteger)components;
@end

@implementation NSDate (Additions)

+ (NSInteger)hourDifferenceBetweenDates:(NSDate*)firstDate andSecondDate:(NSDate*)secondDate{

    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitHour
                                                        fromDate:secondDate
                                                          toDate:firstDate
                                                         options:0];
    
    return components.hour;
}




+ (NSString*)dateStringWithEasyFormatFromDate:(NSDate*)date{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterLongStyle]; 
    [df setTimeStyle:NSDateFormatterNoStyle]; 
    
    NSString *dateString = [df stringFromDate:date];
    
    return dateString;
}

+ (NSString*)dateStringUsingFormat:(NSString *)stringFormat
                           andDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:stringFormat];
    return [dateFormatter stringFromDate:date];
    
}

- (NSDate*)midnightDate {
    NSCalendar *currCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [currCalendar setTimeZone:[NSTimeZone systemTimeZone]];
    NSUInteger preservedComponents = (kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay);
    
    NSDate* midnightDate = [currCalendar dateFromComponents:[currCalendar components:preservedComponents fromDate:self]];
    return midnightDate;
};

- (NSDate*)midnightDateWithTimeZone:(NSTimeZone*)timeZone {
    NSCalendar *currCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [currCalendar setTimeZone:timeZone];
    NSUInteger preservedComponents = (kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay);
    
    NSDate* midnightDate = [currCalendar dateFromComponents:[currCalendar components:preservedComponents fromDate:self]];
    return midnightDate;
}

- (NSInteger)getYearUsingTimezone:(NSTimeZone *)timeZone{
    
    NSCalendar *currCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [currCalendar setTimeZone:timeZone];
    NSDateComponents *components = [currCalendar components:NSCalendarUnitYear
                                                   fromDate:self];
    return [components year];

}

- (NSString *)lastUpdate{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setTimeZone:currentTimeZone];
    [dateFormatter setDateFormat:@"MMM. dd"];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [timeFormatter setTimeZone:currentTimeZone];
    [timeFormatter setDateFormat:@"hh:mm a"];
    
    NSString *returnText = @"";
    if (self == nil) {
        returnText = NSLocalizedString(@"Last updated: never", nil);
    }
    else
        returnText = [NSString stringWithFormat:NSLocalizedString(@"Last updated %@, %@",nil),
                       [dateFormatter stringFromDate:self],
                      [[timeFormatter stringFromDate:self] lowercaseString]];
    
    return returnText;

}

+ (NSInteger)components
{
    return NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitHour | NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal;
}

#pragma mark Relative Dates

+ (NSDate *)dateWithDaysFromNow:(NSInteger)days
{
    NSTimeInterval aTimeInterval = [kToday timeIntervalSinceReferenceDate] + D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days
{
    NSTimeInterval aTimeInterval = [kToday timeIntervalSinceReferenceDate] - D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateTomorrow
{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *)dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

- (NSDate *)dateAtStartOfDay
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [[NSCalendar UTCCalendar] dateFromComponents:components];
}

- (NSDate *)dateAtEndOfDay
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    return [[NSCalendar UTCCalendar] dateFromComponents:components];
}

- (NSDate *)dateAtStartOfWeek
{
    NSDate *aDate = nil;
    BOOL success = [[NSCalendar UTCCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&aDate interval:NULL forDate:self];
    if (success)
        ;
    NSAssert1(success, @"Failed to calculate the first day the month based on %@", self);
    return aDate;
}

- (NSDate *)dateAtEndOfWeek
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    NSDateComponents *componentsNew = [[NSDateComponents alloc] init];
    [componentsNew setDay:(7 - [components weekday])];
    return [[NSCalendar UTCCalendar] dateByAddingComponents:componentsNew toDate:self options:0];
}

- (NSDate *)dateAtStartOfMonth
{
    NSDate *aDate = nil;
    BOOL success = [[NSCalendar UTCCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&aDate interval:NULL forDate:self];
    if (success)
        ;
    NSAssert1(success, @"Failed to calculate the first day the month based on %@", self);
    return aDate;
}

//- (NSDate *)dateAtEndOfMonth
//{
//    NSDate *aDate = nil;
//    BOOL success = [[NSCalendar UTCCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&aDate interval:NULL forDate:[self];
//    NSAssert1(success, @"Failed to calculate the first day the month based on %@", self);
//    return aDate;
//}

- (NSDate *)updateDay:(NSInteger)day
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    components.day = day;
    return [[NSCalendar UTCCalendar] dateFromComponents:components];
}

- (NSDate *)updateMonth:(NSInteger)month
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    components.month = month;
    return [[NSCalendar UTCCalendar] dateFromComponents:components];
}

- (NSDate *)updateWeekday:(NSInteger)weekday
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    components.weekday = weekday;
    return [[NSCalendar UTCCalendar] dateFromComponents:components];
}

- (NSDate *)updateYear:(NSInteger)year
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    components.year = year;
    return [[NSCalendar UTCCalendar] dateFromComponents:components];
}

+ (NSDate *)dateWithHoursFromNow:(NSInteger)hours
{
    NSTimeInterval aTimeInterval = [kToday timeIntervalSinceReferenceDate] + D_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)hours
{
    NSTimeInterval aTimeInterval = [kToday timeIntervalSinceReferenceDate] - D_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithMinutesFromNow:(NSInteger)minutes
{
    NSTimeInterval aTimeInterval = [kToday timeIntervalSinceReferenceDate] + D_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)minutes
{
    NSTimeInterval aTimeInterval = [kToday timeIntervalSinceReferenceDate] - D_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}


#pragma mark Adjusting Dates

- (NSDate *)dateByAddingYear:(NSInteger)year
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    [components setYear:components.year + year];
    return [[NSCalendar UTCCalendar] dateFromComponents:components];
}

- (NSDate *)dateBySubtractingYear:(NSInteger)year
{
    return [self dateByAddingYear:(year * -1)];
}

- (NSDate *)dateByAddingMonth:(NSInteger)month
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    
    int totalMonth = (int)components.month + (int)month;
    if (totalMonth > 12)
    {
        [components setMonth:totalMonth % 12];
        [components setYear:components.year + (NSInteger)(totalMonth / 12)];
    }
    else
    {
        [components setMonth:totalMonth];
    }
    
    return [[NSCalendar UTCCalendar] dateFromComponents:components];
}

- (NSDate *)dateBySubtractingMonth:(NSInteger)month
{
    return [self dateByAddingMonth:(month * -1)];
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_WEEK * weeks;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingWeeks:(NSInteger)weeks
{
    return [self dateByAddingWeeks:(weeks * -1)];
}

- (NSDate *)dateByAddingDays:(NSInteger)days
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingDays:(NSInteger)days
{
    return [self dateByAddingDays:(days * -1)];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingHours:(NSInteger)hours
{
    return [self dateByAddingHours:(hours * -1)];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes
{
    return [self dateByAddingMinutes:(minutes * -1)];
}


- (NSDateComponents *)componentsWithOffsetFromDate:(NSDate *)date
{
    NSDateComponents *dTime = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:date toDate:self options:0];
    return dTime;
}

- (NSDate *)dateWithTimeZone:(CGFloat)timeZone {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setLocale:[NSLocale currentLocale]];
    [formater setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:(timeZone * 3600)]];
    
    [formater setDateStyle:NSDateFormatterShortStyle];
    [formater setTimeStyle:NSDateFormatterShortStyle];
    
    return [formater dateFromString:[formater stringFromDate:self]];
}

//- (NSDate *)startDateOfWeekFromCurrentWeekByAddingWeek:(NSInteger)week {
//	// Get current calendar
//	NSCalendar *gregorian = [NSCalendar currentCalendar];
//
//	NSDateComponents *component = [[NSDateComponents alloc] init];
//	[component setWeek:week];
//	return [gregorian dateByAddingComponents:component toDate:self options:0];
//}


#pragma mark Retrieving Intervals

- (NSInteger)minutesAfterDate:(NSDate *)date
{
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    return fabs(ti / D_MINUTE);
}

- (NSInteger)minutesBeforeDate:(NSDate *)date
{
    NSTimeInterval ti = [date timeIntervalSinceDate:self];
    return fabs(ti / D_MINUTE);
}

- (NSInteger)hoursAfterDate:(NSDate *)date
{
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    return fabs(ti / D_HOUR);
}

- (NSInteger)hoursBeforeDate:(NSDate *)date
{
    NSTimeInterval ti = [date timeIntervalSinceDate:self];
    return fabs(ti / D_HOUR);
}

- (NSInteger)daysAfterDate:(NSDate *)date
{
    NSTimeInterval ti = [date timeIntervalSinceDate:self];
    return fabs(ti / D_DAY);
}

- (NSInteger)daysBeforeDate:(NSDate *)date
{
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    return fabs(ti / D_DAY);
}


#pragma mark Comparing Dates
- (BOOL)isEarlierThanDateIgnoringTime:(NSDate *)date{
    NSDate *dateAtBeginningOfDay = [date dateAtStartOfDay];
    return [self isEarlierThanDate:dateAtBeginningOfDay];
}

- (BOOL)isLaterThanDateIgnoringTime:(NSDate *)date{
    NSDate *dateAtEndOfDay = [date dateAtEndOfDay];
    return [self isLaterThanDate:dateAtEndOfDay];
}

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)date
{
    NSDateComponents *comp1 = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    NSDateComponents *comp2 = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:date];
    
    return (([comp1 year] == [comp2 year])&&([comp1 month] == [comp2 month])&&([comp1 day] == [comp2 day]));
}

- (BOOL)isEqualToTimeIgnoringDate:(NSDate *)date
{
    NSDateComponents *comp1 = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    NSDateComponents *comp2 = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:date];
    
    return (([comp1 hour] == [comp2 hour])&&([comp1 minute] == [comp2 minute])&&([comp1 second] == [comp2 second]));
}

- (BOOL)isToday
{
    return [self isEqualToDateIgnoringTime:kToday];
}

- (BOOL)isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL)isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)isSameWeekAsDate:(NSDate *)date
{
    NSDateComponents *components1 = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    NSDateComponents *components2 = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:date];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if ([components1 weekOfYear] != [components2 weekOfYear])return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:date]) < D_WEEK);
}

- (BOOL)isThisWeek
{
    return [self isSameWeekAsDate:kToday];
}

- (BOOL)isNextWeek
{
    NSTimeInterval aTimeInterval = [kToday timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameYearAsDate:newDate];
}

- (BOOL)isLastWeek
{
    NSTimeInterval aTimeInterval = [kToday timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameYearAsDate:newDate];
}

- (BOOL)isSameMonthAsDate:(NSDate *)date {
    NSDateComponents *components1 = [[NSCalendar UTCCalendar] components:NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSCalendar UTCCalendar] components:NSCalendarUnitMonth fromDate:date];
    return ([components1 month] == [components2 month]);
}

- (BOOL)isThisMonth
{
    return [self isSameMonthAsDate:kToday];
}

- (BOOL)isNextMonth
{
    NSDateComponents *components1 = [[NSCalendar UTCCalendar] components:NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSCalendar UTCCalendar] components:NSCalendarUnitMonth fromDate:kToday];
    
    return ([components1 month] == ([components2 month] + 1));
}

- (BOOL)isLastMonth
{
    NSDateComponents *components1 = [[NSCalendar UTCCalendar] components:NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSCalendar UTCCalendar] components:NSCalendarUnitMonth fromDate:kToday];
    
    return ([components1 month] == ([components2 month] - 1));
}

- (BOOL)isSameYearAsDate:(NSDate *)date
{
    NSDateComponents *components1 = [[NSCalendar UTCCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar UTCCalendar] components:NSCalendarUnitYear fromDate:date];
    return ([components1 year] == [components2 year]);
}

- (BOOL)isThisYear
{
    return [self isSameYearAsDate:kToday];
}

- (BOOL)isNextYear
{
    NSDateComponents *components1 = [[NSCalendar UTCCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar UTCCalendar] components:NSCalendarUnitYear fromDate:kToday];
    
    return ([components1 year] == ([components2 year] + 1));
}

- (BOOL)isLastYear
{
    NSDateComponents *components1 = [[NSCalendar UTCCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar UTCCalendar] components:NSCalendarUnitYear fromDate:kToday];
    
    return ([components1 year] == ([components2 year] - 1));
}

- (BOOL)isEarlierThanDate:(NSDate *)date
{
    return ([self earlierDate:date] == self);
}

- (BOOL)isLaterThanDate:(NSDate *)date
{
    return ([self laterDate:date] == self);
}


#pragma mark Decomposing Dates

- (NSInteger)nearestHour
{
    NSTimeInterval aTimeInterval = [kToday timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return [components hour];
}

- (NSInteger)hour
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    return [components hour];
}

- (NSInteger)minute
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    return [components minute];
}

- (NSInteger)seconds
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    return [components second];
}

- (NSInteger)day
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    return [components day];
}

- (NSInteger)month
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    return [components month];
}

- (NSInteger)week {
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    return [components weekOfYear];
}

- (NSInteger)weekday
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    return [components weekday];
}

- (NSInteger)nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    return [components weekdayOrdinal];
}

- (NSInteger)year
{
    NSDateComponents *components = [[NSCalendar UTCCalendar] components:[NSDate components] fromDate:self];
    return [components year];
}


#pragma mark Generate Formatted Strings

- (NSString *)string {
    return [self stringDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)stringDateWithFormat:(NSString *)format
{
    NSString * deviceLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:deviceLanguage];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:format];
    [formater setLocale:locale];
    return [formater stringFromDate:self];
}

- (NSString *)stringDateWithStyle:(NSDateFormatterStyle)style
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateStyle:style];
    return [formater stringFromDate:self];
}

- (NSString *)stringTimeWithStyle:(NSDateFormatterStyle)style
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setTimeStyle:style];
    return [formater stringFromDate:self];
}

- (NSString *)stringDateTimeWithStyle:(NSDateFormatterStyle)style
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateStyle:style];
    [formater setTimeStyle:style];
    return [formater stringFromDate:self];
}

- (NSString *)stringUTCDateTimeWithStyle:(NSDateFormatterStyle)style
{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setLocale:[NSLocale currentLocale]];
    [formater setDateStyle:style];
    [formater setTimeStyle:style];
    return [formater stringFromDate:self];
}

- (NSString*)formatRelativeTimeForDay:(NSString *)d hour:(NSString *)h minute:(NSString *)m second:(NSString *)s
{
    NSTimeInterval elapsed = fabs([self timeIntervalSinceNow]);
    if (elapsed <= D_MINUTE)
    {
        return [NSString stringWithFormat:@"%f %@", elapsed, s];
    }
    else if (elapsed < D_HOUR)
    {
        int mins = (int)(elapsed / D_MINUTE);
        return [NSString stringWithFormat:@"%d %@", mins, m];
    }
    else if (elapsed < D_DAY)
    {
        int hours = (int)((elapsed + D_HOUR / 2) / D_HOUR);
        return [NSString stringWithFormat:@"%d %@", hours, h];
    }
    else if (elapsed < D_WEEK)
    {
        int day = (int)((elapsed + D_DAY / 2) / D_DAY);
        return [NSString stringWithFormat:@"%d %@", day, d];
    }
    else
    {
        return [self stringDateTimeWithStyle:NSDateFormatterShortStyle];
    }
}

- (NSString *)stringDaysAgo
{
    NSInteger daysAgo = (NSInteger)[self timeIntervalSinceNow] / D_DAY *-1;
    NSString *text = nil;
    switch (daysAgo) {
        case 0:text = @"Today";
            break;
        case 1:text = @"Yesterday";
            break;
        default:text = [NSString stringWithFormat:@"%ld days ago", (long)daysAgo];
            break;
    }
    return text;
}


+ (NSString*)formatedTimeStampFromIntervals:(int)intervals
{
    if (intervals >= 3600)
    {
        long sec = intervals % 3600;
        return [NSString stringWithFormat:@"%d:%02ld:%02ld", intervals / 3600, sec / 60, sec % 60];
    }
    else if (intervals > 0)
    {
        return [NSString stringWithFormat:@"%02d:%02d", intervals / 60, intervals % 60];
    }
    else
    {
        return nil;
    }
}


#pragma mark Generate Dates

+ (NSDate *)dateWithDatePart:(NSDate *)date andTimePart:(NSDate *)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *datePortion = [formatter stringFromDate:date];
    
    [formatter setDateFormat:@"HH:mm"];
    NSString *timePortion = [formatter stringFromDate:time];
    
    [formatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSString *dateTime = [NSString stringWithFormat:@"%@ %@",datePortion,timePortion];
    return [formatter dateFromString:dateTime];
}

+ (NSDate *)dateFromInternetDateTimeString:(NSString *)dateString
{
    // Setup Date & Formatter
    NSLocale *en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:en_US_POSIX];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    // RFC3339
    NSString *RFC3339String = [[NSString stringWithString:dateString] uppercaseString];
    RFC3339String = [RFC3339String stringByReplacingOccurrencesOfString:@"Z" withString:@"-0000"];
    
    // Remove colon in timezone as iOS 4+ NSDateFormatter breaks. See https://devforums.apple.com/thread/45837
    if (RFC3339String.length > 20)
    {
        RFC3339String = [RFC3339String stringByReplacingOccurrencesOfString:@":"
                                                                 withString:@""
                                                                    options:0
                                                                      range:NSMakeRange(20, RFC3339String.length-20)];
    }
    
    NSDate *date = nil;
    if (!date)      // 1996-12-19T16:39:57-0800
    {
        [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"];
        date = [formatter dateFromString:RFC3339String];
    }
    if (!date) { // 1937-01-01T12:00:27.87+0020
        [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZZZ"];
        date = [formatter dateFromString:RFC3339String];
    }
    if (!date) { // 1937-01-01T12:00:27
        [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
        date = [formatter dateFromString:RFC3339String];
    }
    if (!date) { // 2011-12-21T00:00
        [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm"];
        date = [formatter dateFromString:RFC3339String];
    }
    
    /*
     *  RFC822
     */
    
    NSString *RFC822String = [[NSString stringWithString:dateString] uppercaseString];
    if (!date) { // Sun, 19 May 02 15:21:36 GMT
        [formatter setDateFormat:@"EEE, d MMM yy HH:mm:ss zzz"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) { // Sun, 19 May 2002 15:21:36 GMT
        [formatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss zzz"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) {  // Sun, 19 May 2002 15:21 GMT
        [formatter setDateFormat:@"EEE, d MMM yyyy HH:mm zzz"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) {  // 19 May 2002 15:21:36 GMT
        [formatter setDateFormat:@"d MMM yyyy HH:mm:ss zzz"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) {  // 19 May 2002 15:21 GMT
        [formatter setDateFormat:@"d MMM yyyy HH:mm zzz"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) {  // 19 May 2002 15:21:36
        [formatter setDateFormat:@"d MMM yyyy HH:mm:ss"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) {  // 2011-06-13 13:30:00
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) {  // 19 May 2002 15:21
        [formatter setDateFormat:@"d MMM yyyy HH:mm"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) { // 2011-12-21 00:00
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        date = [formatter dateFromString:RFC3339String];
    }
    if (!date) {  // 2011-06-12
        [formatter setDateFormat:@"yyyy-MM-dd"];
        date = [formatter dateFromString:RFC822String];
    }
    if (!date) {  // 23:50:00
        [formatter setDateFormat:@"HH:mm:ss"];
        date = [formatter dateFromString:RFC822String];
    }
    
    if (date) return date;
    
    // Failed
    return nil;
}

- (NSDate *)dateToGMT {
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:-destinationGMTOffset sinceDate:self];
    return destinationDate;
}

@end

@implementation NSCalendar (Extra)

+ (id)UTCCalendar
{
    static NSCalendar *calendar = nil;
    if (calendar == nil)
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return calendar;
}

+ (id)defaultSystemCalendar
{
    static NSCalendar *calendar = nil;
    if (calendar == nil)
    {
        
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return calendar;
}

+ (id)calendarWithTimeZone:(NSString *)timezone
{
    static NSCalendar *calendar = nil;
    if (calendar == nil)
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:timezone]];
    
    return calendar;
}


@end
