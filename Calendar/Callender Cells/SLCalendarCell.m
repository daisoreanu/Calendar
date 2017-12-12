//
//  SLCalendarCell.m
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import "SLCalendarCell.h"

@implementation SLCalendarCell

int const TOP_INSET = 6;
int const SPACE_BETWEEN_ROWS = 8;
int const BOTTOM_INSET = 16;
int const DEFAULT_NUMBER_OF_ROWS = 6;
int const NUMBER_OF_COLUMNS = 7;
int const TOTAL_NUMBER_OF_CELLS = DEFAULT_NUMBER_OF_ROWS * NUMBER_OF_COLUMNS;

- (void)awakeFromNib {
    [super awakeFromNib];
    NSString *cellID = @"SLMonthCell";
    [self.collectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
}

- (void)configureWithMonthGroup:(SLMonthGroup *)monthGroup
                       delegate:(id<SLCalendarDelegate, SLDateRangeUpdateProtocol>)delegate{
    self.monthGroup = monthGroup;
    self.delegate = delegate;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView reloadData];
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellHeight{
    int cellWidth = [UIApplication currentSize].width / NUMBER_OF_COLUMNS;
    int totalCellHeight = DEFAULT_NUMBER_OF_ROWS * cellWidth;
    return TOP_INSET + totalCellHeight + BOTTOM_INSET;
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.monthGroup.monthsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SLMonthCell *monthCell = (SLMonthCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"SLMonthCell" forIndexPath:indexPath];
    [monthCell configureWithMonth:[self.monthGroup.monthsArray objectAtIndex:indexPath.row] delegate:self];
    return monthCell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == InputSectionTypePlanExpand && [kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        SLInputHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SLInputHeaderView" forIndexPath:indexPath];
//        [self configureHeaderView:header];
//        return header;
//    }
//    return [SLInputHeaderView new];
//}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.monthGroup.shouldAutoScroll == YES) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.monthGroup.middleCellIndex inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                            animated:NO];
        [self.delegate updateAutoScroll:NO];
    }
    self.futureIndexPath = indexPath;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (((indexPath.row == self.monthGroup.lastCellIndex - 1) || (indexPath.row == self.monthGroup.firstCellIndex + 1))) {
        [self.delegate recreateMonthsGroupForIndex:(int)self.futureIndexPath.row];
    }
}
#pragma mark - UICollectionViewDelegateFlowLayout methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
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

#pragma mark - SLDateRangeUpdateProtocol
- (void)updateDateRangeWithDate:(NSDate *)date{
    [self.delegate updateDateRangeWithDate:date];
}

@end
