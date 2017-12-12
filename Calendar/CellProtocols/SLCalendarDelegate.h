//
//  SLCalendarDelegate.h
//  Calendar
//
//  Created by Daisoreanu Laurentiu on 10/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

@protocol SLCalendarDelegate <NSObject>

- (void)recreateMonthsGroupForIndex:(int)index;
- (void)updateAutoScroll:(BOOL)shouldAutoScroll;

@end

