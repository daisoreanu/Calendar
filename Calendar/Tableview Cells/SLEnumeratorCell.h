//
//  SLEnumeratorCell.h
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLBasicCellProtocol.h"

@interface SLEnumeratorCell : UITableViewCell<SLBasicCellProtocol>

- (void)configureWithArray:(NSArray <NSString *>*)array;
+ (CGFloat)cellHeight;
+ (NSString *)cellIdentifier;

@end
