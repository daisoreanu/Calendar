//
//  SLDayCell.h
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 07/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SLDay.h"

@interface SLDayCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIView *firstHalfBackgroundView;
@property (strong, nonatomic) IBOutlet UIView *secondHalfBackgroundView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

- (void)configureWithTitle:(NSString *)title andType:(SLDayType)cellType;

@end
