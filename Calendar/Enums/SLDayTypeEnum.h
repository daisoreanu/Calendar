//
//  SLDayTypeEnum.h
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 08/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#ifndef SLDayTypeEnum_h
#define SLDayTypeEnum_h

typedef NS_ENUM(NSInteger, SLDayType) {
    SLDayTypeCurrentMonthNormal = 0,
    SLDayTypeCurrentMonthSelectedMid,
    SLDayTypeCurrentMonthSelectedBeginning,
    SLDayTypeCurrentMonthSelectedEnd,
    SLDayTypeCurrentMonthSingleSelection,
    SLDayTypeOtherMonthNormal,
    SLDayTypeOtherMonthSelectedMid,
    SLDayTypeOtherMonthSelectedBeginning,
    SLDayTypeOtherMonthSelectedEnd,
    SLDayTypeOtherMonthSingleSelection
};

#endif /* SLDayTypeEnum_h */
