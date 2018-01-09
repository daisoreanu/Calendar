//
//  SLDoubleDatePickerCell.m
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import "SLDateRangeCell.h"
#import "NSDate+Additions.h"
#define endBlue [UIColor colorWithRed: 0.0/255.0 green: 114.0/255.0 blue: 178.0/255.0 alpha: 1.0]

@implementation SLDateRangeCell
- (void)awakeFromNib{
    [super awakeFromNib];
    _firstContainerView.layer.cornerRadius = 4.0f;
    _firstContainerView.layer.borderWidth = 1.0f;
    _firstContainerView.layer.borderColor = [[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0] CGColor];
    
    _secondContainerView.layer.cornerRadius = 4.0f;
    _secondContainerView.layer.borderWidth = 1.0f;
    _secondContainerView.layer.borderColor = [[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0] CGColor];
}

- (void)configureWithStartDate:(NSDate *)startDate
                    andEndDate:(NSDate *)endDate
                      delegate:(id<SLDateRangeCellDelegate>)delegate{
    self.startDate = startDate;
    self.endDate = endDate;
    self.delegate = delegate;
    [self configureUI];
}

- (void)configureUI{
    self.firstTextField.text = [self getTitleFromDate:self.startDate];
    self.secondTextField.text = [self getTitleFromDate:self.endDate];
    self.firstTextField.delegate = self;
    self.secondTextField.delegate = self;
}

-(UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        
        self.customToolbar = [[SLCustomToolBar alloc] initWithLeftButtonTitle:NSLocalizedString(@"Cancel", nil)
                                                          andLeftButtonAction:@selector(onCancelPressed:)
                                                          andRightButtonTitle:NSLocalizedString(@"Done", nil)
                                                         andRightButtonAction:@selector(onDonePressed:)
                                                                  andDelegate:self];
        [self.customToolbar setBackgroundColor:endBlue];
    }
    return _datePicker;
}

- (NSString *)getTitleFromDate:(NSDate *)date{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = [NSLocale currentLocale];
    formatter.calendar = [NSCalendar currentCalendar];
    [formatter setDateFormat:@"d/MM/yyyy"];
    return [formatter stringFromDate:date];
}



+ (CGFloat)cellHeight{
    return 85.0;
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

#pragma mark - SLCustomToolBar

- (void)onCancelPressed:(id)obj {
    [self endEditing:YES];
}

- (void)onDonePressed:(id)obj {
    
    if ([self.delegate respondsToSelector:@selector(userUpdatedDate:forIndex:andCell:)]) {
        NSDate *date = self.datePicker.date;
        if (self.indexOfCellSelected == TextFieldSelectedRight) {
            [self.delegate userUpdatedDate:date forIndex:TextFieldSelectedRight andCell:self];
        }else{
            [self.delegate userUpdatedDate:date forIndex:TextFieldSelectedLeft andCell:self];
        }
    }
    [self endEditing:YES];
         
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    if (textField == _firstTextField) {
        self.indexOfCellSelected = TextFieldSelectedLeft;
        self.datePicker.date = self.startDate;
        self.datePicker.minimumDate = nil;
        self.datePicker.maximumDate = self.endDate;
    }else{
        self.indexOfCellSelected = TextFieldSelectedRight;
        self.datePicker.date = self.endDate;
        self.datePicker.minimumDate = self.startDate;
        self.datePicker.maximumDate = nil;
    }
    textField.inputView = self.datePicker;
    textField.inputAccessoryView = self.customToolbar;
    [textField reloadInputViews];
    return YES;
}

@end
