//
//  SLMonthCell.h
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 08/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLMonth.h"
#import "SLDateRangeUpdateProtocol.h"


@interface SLMonthCell : UICollectionViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) SLMonth *month;
@property (weak, nonatomic) id<SLDateRangeUpdateProtocol, SLDateRangeUpdateProtocol> delegate;

- (void)configureWithMonth:(SLMonth *)month
                  delegate:(id <SLDateRangeUpdateProtocol>)delegate;

@end
