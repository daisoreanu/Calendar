//
//  SLSliderPickerCell.m
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import "SLSliderPickerCell.h"

@implementation SLSliderPickerCell

- (void)awakeFromNib{
    [super awakeFromNib];
    if (!_swipeRight) {
        _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedBackButton:)];
        _swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    }
    [_titleLabel addGestureRecognizer:_swipeRight];
    if (!_swipeLeft) {
        _swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedForwordButton:)];
        _swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    [_titleLabel addGestureRecognizer:_swipeLeft];
    
    [_titleLabel setUserInteractionEnabled:YES];
}

- (void)configureWithTitle:(NSString *)title
                  delegate:(id<SLSliderPickerCellDelegate>)delegate{
    _delegate = delegate;
    _titleLabel.text = title;
}

+ (CGFloat)cellHeight{
    return 48.0;
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

- (IBAction)userTappedBackButton:(id)sender {
    if ([_delegate respondsToSelector:@selector(userTppedBackButtonOnCell:)]) {
        [_delegate userTppedBackButtonOnCell:self];
    }
}

- (IBAction)userTappedForwordButton:(id)sender {
    if ([_delegate respondsToSelector:@selector(userTppedForwordButtonOnCell:)]) {
        [_delegate userTppedForwordButtonOnCell:self];
    }
}

@end
