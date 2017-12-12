//
//  SLEnumeratorCell.m
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import "SLEnumeratorCell.h"

@implementation SLEnumeratorCell

- (void)configureWithArray:(NSArray <NSString *>*)array{
    if (array.count == 7) {
        for (int count = 0; count < array.count; count++) {
            NSString *str = array[count];
            UILabel *label = [self.contentView viewWithTag:10 + count];
            label.text = str;
        }
    }else{
        NSAssert(YES, @"The SLEnummeratorCell mult be configured with exact 7 elements");
    }
}

+ (CGFloat)cellHeight{
    return 48.0;
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

@end
