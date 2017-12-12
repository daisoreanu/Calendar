//
//  SLMonthCell.m
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 08/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import "SLMonthCell.h"
#import "SLDayCell.h"
#import "UIApplication+AppDimensions.h"

@implementation SLMonthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSString *cellID = @"SLDayCell";
    [self.collectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
}

- (void)configureWithMonth:(SLMonth *)month
                  delegate:(id <SLDateRangeUpdateProtocol>)delegate{
    self.month = month;
    self.delegate = delegate;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.month.daysArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SLDayCell *dayCell = (SLDayCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"SLDayCell" forIndexPath:indexPath];
    SLDay *day = [self.month.daysArray objectAtIndex:indexPath.row];
    
    NSString *title = [NSString stringWithFormat:@"%i", (int)day.date.day];
    
    [dayCell configureWithTitle:title andType:day.dateType];
    return dayCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {    
    NSDate *selectedDate = [[self.month.daysArray objectAtIndex:indexPath.row] date];
    [self.delegate updateDateRangeWithDate:selectedDate];
}

#pragma mark - UICollectionViewDelegateFlowLayout methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int cellHeight = [UIApplication currentSize].width / 7;
    CGSize size = CGSizeZero;
    size.width = cellHeight;
    size.height = cellHeight;
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    int sideInset = (int)[UIApplication currentSize].width % 7;
    int leftInset = sideInset / 2;
    int rightInset = leftInset + sideInset % 2;
    return UIEdgeInsetsMake(6, leftInset, 16, rightInset);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}


@end
