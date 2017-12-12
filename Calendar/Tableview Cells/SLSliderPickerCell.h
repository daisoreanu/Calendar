//
//  SLSliderPickerCell.h
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLBasicCellProtocol.h"

@class SLSliderPickerCell;
@protocol SLSliderPickerCellDelegate <NSObject>
- (void)userTppedForwordButtonOnCell:(SLSliderPickerCell *)cell;
- (void)userTppedBackButtonOnCell:(SLSliderPickerCell *)cell;
@end

@interface SLSliderPickerCell : UITableViewCell <SLBasicCellProtocol>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) id<SLSliderPickerCellDelegate> delegate;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeRight;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeLeft;

- (void)configureWithTitle:(NSString *)title
                  delegate:(id<SLSliderPickerCellDelegate>)delegate;
+ (CGFloat)cellHeight;
+ (NSString *)cellIdentifier;

@end
