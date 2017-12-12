//
//  SLDoubleDatePickerCell.h
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLBasicCellProtocol.h"
#import "SLCustomToolBar.h"

typedef NS_ENUM(NSInteger, TextFieldSelected) {
    TextFieldSelectedLeft = 0,
    TextFieldSelectedRight
};

@class SLDateRangeCell;
@protocol SLDateRangeCellDelegate <NSObject>
- (void)userUpdatedDate:(NSDate *)newDate forIndex:(TextFieldSelected)index andCell:(SLDateRangeCell *)cell;
@end

@interface SLDateRangeCell : UITableViewCell <SLBasicCellProtocol, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *topSeparatorView;
@property (strong, nonatomic) IBOutlet UIView *bottomSeparatorView;
@property (strong, nonatomic) IBOutlet UITextField *firstTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondTextField;
@property (strong, nonatomic) IBOutlet UIView *firstContainerView;
@property (strong, nonatomic) IBOutlet UIView *secondContainerView;

@property (weak, nonatomic) id<SLDateRangeCellDelegate> delegate;

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) SLCustomToolBar *customToolbar;
@property (assign, nonatomic) TextFieldSelected indexOfCellSelected;

- (void)configureWithStartDate:(NSDate *)startDate
                    andEndDate:(NSDate *)endDate
                      delegate:(id<SLDateRangeCellDelegate>)delegate;
+ (CGFloat)cellHeight;
+ (NSString *)cellIdentifier;
                                                                         
@end

