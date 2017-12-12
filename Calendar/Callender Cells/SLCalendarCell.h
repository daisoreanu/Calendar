//
//  SLCalendarCell.h
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLMonthGroup.h"
#import "SLBasicCellProtocol.h"
#import "SLDateRange.h"
#import "UIApplication+AppDimensions.h"
#import "SLMonthCell.h"


@interface SLCalendarCell : UITableViewCell <SLBasicCellProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SLDateRangeUpdateProtocol>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) SLMonthGroup *monthGroup;
@property (weak, nonatomic) id<SLCalendarDelegate, SLDateRangeUpdateProtocol> delegate;
@property (strong, nonatomic) NSIndexPath *futureIndexPath;

- (void)configureWithMonthGroup:(SLMonthGroup *)monthGroup
                       delegate:(id<SLCalendarDelegate, SLDateRangeUpdateProtocol>)delegate;

+ (NSString *)cellIdentifier;
+ (CGFloat)cellHeight;

@end
