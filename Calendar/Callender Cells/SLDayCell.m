//
//  SLDayCell.m
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 07/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import "SLDayCell.h"
#import "UIApplication+AppDimensions.h"

#define endBlue [UIColor colorWithRed: 0.0/255.0 green: 114.0/255.0 blue: 178.0/255.0 alpha: 1.0]
#define midBlue [UIColor colorWithRed: 0.0/255.0 green: 114.0/255.0 blue: 178.0/255.0 alpha: 0.7]
#define midBlueOtherMonth [UIColor colorWithRed: 229.0/255.0 green: 236.0/255.0 blue: 241.0/255.0 alpha: 0.7]
#define lightGrey [UIColor colorWithRed: 204.0/255.0 green: 204.0/255.0 blue: 204.0/255.0 alpha: 0.7]

int const horizontalInset = 8;

@implementation SLDayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.layer.cornerRadius = ([UIApplication currentSize].width / 7 - horizontalInset) / 2;
    self.titleLabel.layer.masksToBounds = YES;
}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.titleLabel.layer.cornerRadius = ([UIApplication currentSize].width / 7 - horizontalInset) / 2;
    self.titleLabel.layer.masksToBounds = YES;
}

- (void)configureWithTitle:(NSString *)title andType:(SLDayType)cellType{
    self.titleLabel.text = title;    
    switch (cellType) {
        case SLDayTypeCurrentMonthNormal:
            self.firstHalfBackgroundView.backgroundColor = [UIColor whiteColor];
            self.secondHalfBackgroundView.backgroundColor = [UIColor whiteColor];
            self.titleLabel.backgroundColor = [UIColor clearColor];
            self.titleLabel.textColor = [UIColor blackColor];
            break;
        case SLDayTypeCurrentMonthSelectedMid:
            self.firstHalfBackgroundView.backgroundColor = midBlue;
            self.secondHalfBackgroundView.backgroundColor = midBlue;
            self.titleLabel.backgroundColor = [UIColor clearColor];
            self.titleLabel.textColor = [UIColor whiteColor];
            break;
        case SLDayTypeCurrentMonthSelectedBeginning:
            self.firstHalfBackgroundView.backgroundColor = [UIColor whiteColor];
            self.secondHalfBackgroundView.backgroundColor = midBlue;
            self.titleLabel.backgroundColor = endBlue;
            self.titleLabel.textColor = [UIColor whiteColor];
            break;
        case SLDayTypeCurrentMonthSelectedEnd:
            self.firstHalfBackgroundView.backgroundColor = midBlue;
            self.secondHalfBackgroundView.backgroundColor = [UIColor whiteColor];
            self.titleLabel.backgroundColor = endBlue;
            self.titleLabel.textColor = [UIColor whiteColor];
            break;
        case SLDayTypeCurrentMonthSingleSelection:
            self.firstHalfBackgroundView.backgroundColor = [UIColor whiteColor];
            self.secondHalfBackgroundView.backgroundColor = [UIColor whiteColor];
            self.titleLabel.backgroundColor = endBlue;
            self.titleLabel.textColor = [UIColor whiteColor];
            break;
            
            
        case SLDayTypeOtherMonthNormal:
            self.firstHalfBackgroundView.backgroundColor = [UIColor whiteColor];
            self.secondHalfBackgroundView.backgroundColor = [UIColor whiteColor];
            self.titleLabel.backgroundColor = [UIColor clearColor];
            self.titleLabel.textColor = lightGrey;
            break;
        case SLDayTypeOtherMonthSelectedMid:
            self.firstHalfBackgroundView.backgroundColor = midBlueOtherMonth;
            self.secondHalfBackgroundView.backgroundColor = midBlueOtherMonth;
            self.titleLabel.backgroundColor = [UIColor clearColor];
            self.titleLabel.textColor = lightGrey;
            break;
        case SLDayTypeOtherMonthSelectedBeginning:
            self.firstHalfBackgroundView.backgroundColor = [UIColor whiteColor];
            self.secondHalfBackgroundView.backgroundColor = midBlueOtherMonth;
            self.titleLabel.backgroundColor = [UIColor darkGrayColor];//TODO: Should be change with other month dark blue, ask K
            self.titleLabel.textColor = lightGrey;
            break;
        case SLDayTypeOtherMonthSelectedEnd:
            self.firstHalfBackgroundView.backgroundColor = midBlueOtherMonth;
            self.secondHalfBackgroundView.backgroundColor = [UIColor whiteColor];
            self.titleLabel.backgroundColor = [UIColor darkGrayColor];//TODO: Should be change with other month dark blue, ask K
            self.titleLabel.textColor = lightGrey;
            break;
        case SLDayTypeOtherMonthSingleSelection:
            self.firstHalfBackgroundView.backgroundColor = [UIColor whiteColor];
            self.secondHalfBackgroundView.backgroundColor = [UIColor whiteColor];
            self.titleLabel.backgroundColor = [UIColor darkGrayColor];//TODO: Should be change with other month dark blue, ask K
            self.titleLabel.textColor = lightGrey;
            break;
        default:
            break;
    }
}

@end
