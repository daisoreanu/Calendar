//
//  TableViewController.m
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import "SLDateRangeTVC.h"

#import "SLLabelAndChevronCell.h"
#import "SLDateRangeCell.h"
#import "SLSliderPickerCell.h"
#import "SLEnumeratorCell.h"
#import "SLCalendarCell.h"

#import "SLTitleAndImageModel.h"
#import "SLMonthGroup.h"

typedef NS_ENUM(NSInteger, TableSection) {
    TableSectionFilterType = 0,
    TableSectionFilterRange,
    TableSectionMonthSelector,
    TableSectionYearSelector,
    TableSectionWeekDays,
    TableSectionCalendar,
    TableSectionTotal
};

typedef NS_ENUM(NSInteger, CalendarFilterType) {
    CalendarFilterTypeToday = 0,
    CalendarFilterTypeAllYear,
    CalendarFilterTypeCustom
};

@interface SLDateRangeTVC ()<SLCalendarDelegate, SLDateRangeUpdateProtocol, SLDateRangeCellDelegate, SLSliderPickerCellDelegate>

@property (strong, nonatomic) SLDateRange *dateRange;
@property (strong, nonatomic) SLMonthGroup *monthGroup;
    
@property (strong, nonatomic) NSArray *weekdaySymbolsArray;
    
@property (strong, nonatomic) SLTitleAndImageModel *allYearFilterCellModel;
@property (strong, nonatomic) SLTitleAndImageModel *todayFilterCellModel;
@property (strong, nonatomic) SLTitleAndImageModel *customFilterCellModel;


@end

@implementation SLDateRangeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self regiesterCells];
    [self setupInitialTableModels];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return TableSectionTotal;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfCellsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifierForIndexPath:indexPath] forIndexPath:indexPath];
    [self configureCell:&cell forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == TableSectionFilterType) {
        [self updateFilterTypeTo:indexPath.row];
        [self reloadTableViewData];
    }
}

#pragma mark - Private Methods
- (NSInteger)numberOfCellsInSection:(NSInteger)section{
    switch (section) {
        case TableSectionFilterType:
            return 3;
            break;
        case TableSectionFilterRange:
            return 1;
            break;
        case TableSectionMonthSelector:
            return 1;
            break;
        case TableSectionYearSelector:
            return 1;
            break;
        case TableSectionWeekDays:
            return 1;
            break;
        case TableSectionCalendar:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"";
    switch (indexPath.section) {
        case TableSectionFilterType:
            cellIdentifier = [SLLabelAndChevronCell cellIdentifier];
            break;
        case TableSectionFilterRange:
            cellIdentifier = [SLDateRangeCell cellIdentifier];
            break;
        case TableSectionMonthSelector:
            cellIdentifier = [SLSliderPickerCell cellIdentifier];
            break;
        case TableSectionYearSelector:
            cellIdentifier = [SLSliderPickerCell cellIdentifier];
            break;
        case TableSectionWeekDays:
            cellIdentifier = [SLEnumeratorCell cellIdentifier];
            break;
        case TableSectionCalendar:
            cellIdentifier = [SLCalendarCell cellIdentifier];
            break;
        default:
            break;
    }
    return cellIdentifier;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0.0;
    switch (indexPath.section) {
        case TableSectionFilterType:
            height = [SLLabelAndChevronCell cellHeight];
            break;
        case TableSectionFilterRange:
            height = [SLDateRangeCell cellHeight];
            break;
        case TableSectionMonthSelector:
            height = [SLSliderPickerCell cellHeight];
            break;
        case TableSectionYearSelector:
            height = [SLSliderPickerCell cellHeight];
            break;
        case TableSectionWeekDays:
            height = [SLEnumeratorCell cellHeight];
            break;
        case TableSectionCalendar:
            height = [SLCalendarCell cellHeight];
            break;
        default:
            break;
    }
    return height;
}

- (void)configureCell:(UITableViewCell **)cell forIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case TableSectionFilterType:
            switch (indexPath.row) {
                case CalendarFilterTypeToday:
                    [((SLLabelAndChevronCell *)*cell) configureWithModel:self.todayFilterCellModel];
                    break;
                case CalendarFilterTypeAllYear:
                    [(SLLabelAndChevronCell *)*cell configureWithModel:self.allYearFilterCellModel];
                    break;
                case CalendarFilterTypeCustom:
                    [(SLLabelAndChevronCell *)*cell configureWithModel:self.customFilterCellModel];
                    break;
                default:
                    break;
            }
            break;
        case TableSectionFilterRange:{
            //We could replace the configure to accept the SLDateRange obj but we will lose the
            [((SLDateRangeCell *)*cell) configureWithStartDate:self.monthGroup.dateRange.startDate
                                                    andEndDate:self.monthGroup.dateRange.endDate
                                                      delegate:self];
            ((SLDateRangeCell *)*cell).topSeparatorView.hidden = YES;
        }
            break;
        case TableSectionMonthSelector:{
            [((SLSliderPickerCell *)*cell) configureWithTitle:[self.monthGroup getMonthStringFromCurrentMonthDisplayed]
                                                     delegate:self];
        }
            break;
        case TableSectionYearSelector:{
            [((SLSliderPickerCell *)*cell) configureWithTitle:[self.monthGroup getYearStringFromCurrentMonthDisplayed]
                                                     delegate:self];
        }
            break;
        case TableSectionWeekDays:
            [((SLEnumeratorCell *)*cell) configureWithArray:self.weekdaySymbolsArray];
            break;
        case TableSectionCalendar:
            [((SLCalendarCell *)*cell) configureWithMonthGroup:self.monthGroup
                                                      delegate:self];
            break;
        default:
            break;
    }
}

- (void)regiesterCells{
    [self.tableView registerNib:[UINib nibWithNibName:[SLLabelAndChevronCell cellIdentifier] bundle:nil] forCellReuseIdentifier:[SLLabelAndChevronCell cellIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:[SLDateRangeCell cellIdentifier] bundle:nil] forCellReuseIdentifier:[SLDateRangeCell cellIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:[SLSliderPickerCell cellIdentifier] bundle:nil] forCellReuseIdentifier:[SLSliderPickerCell cellIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:[SLEnumeratorCell cellIdentifier] bundle:nil] forCellReuseIdentifier:[SLEnumeratorCell cellIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:[SLCalendarCell cellIdentifier] bundle:nil] forCellReuseIdentifier:[SLCalendarCell cellIdentifier]];
}

- (void)setupInitialTableModels{
    //Create the models that will be used to setup the cells from section: TableSectionFilterType
    self.allYearFilterCellModel = [[SLTitleAndImageModel alloc] init];
    self.allYearFilterCellModel.title = NSLocalizedString(@"All year", @"All year");
    self.allYearFilterCellModel.imageName = @"ic_select_grey";
    self.allYearFilterCellModel.isTopSeparatorVisible = YES;
    self.allYearFilterCellModel.isBottomSeparatorVisible = NO;
    
    self.todayFilterCellModel = [[SLTitleAndImageModel alloc] init];
    self.todayFilterCellModel.title = NSLocalizedString(@"Today", @"Today");
    self.todayFilterCellModel.imageName = @"ic_select_grey";
    self.todayFilterCellModel.isTopSeparatorVisible = YES;
    self.todayFilterCellModel.isBottomSeparatorVisible = NO;
    
    self.customFilterCellModel = [[SLTitleAndImageModel alloc] init];
    self.customFilterCellModel.title = NSLocalizedString(@"Custom", @"Custom");
    self.customFilterCellModel.imageName = @"ic_select_grey";
    self.customFilterCellModel.isTopSeparatorVisible = YES;
    self.customFilterCellModel.isBottomSeparatorVisible = YES;

    //Setup the date range to be Today
    self.dateRange = [SLDateRange new];
    [self.dateRange updateDateRangeWithDate:[NSDate date]];
    
    //Create the SLMonthGroup model using current date
    //Only preload one cell in each direction
    self.monthGroup = [[SLMonthGroup alloc] initWithCurrentDate:[NSDate date]
                                               andSelectedRange:self.dateRange
                                     andNumberOfMonthsPreloaded:1];
    
    //Create the days of the week symbol array
    self.weekdaySymbolsArray = [[NSArray alloc] initWithArray:[self daysOfTheWeekAsString]];
    
    //Update the selected filter model using calendarFilterType
    [self updateFilterTypeTo:CalendarFilterTypeToday];

     [self reloadTableViewData];
}

- (NSArray <NSString *>*) daysOfTheWeekAsString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    return [dateFormatter veryShortWeekdaySymbols];
}

- (void)updateFilterTypeTo:(CalendarFilterType)newFilterType{
    self.todayFilterCellModel.isSelected = NO;
    self.allYearFilterCellModel.isSelected = NO;
    self.customFilterCellModel.isSelected = NO;
    switch (newFilterType) {
        case CalendarFilterTypeToday:
            self.todayFilterCellModel.isSelected = YES;
            [self.monthGroup updateDateRangeWithStartDate:[NSDate date] andEndDate:[NSDate date]];
            break;
        case CalendarFilterTypeAllYear:
            self.allYearFilterCellModel.isSelected = YES;
            [self.monthGroup updateDateRangeWithStartDate:[[[NSDate date] updateMonth:1] updateDay:1] andEndDate:[[[NSDate date] updateMonth:12] updateDay:31]];
            break;
        case CalendarFilterTypeCustom:
            self.customFilterCellModel.isSelected = YES;
            break;
        default:
            break;
    }
}

- (void)reloadTableViewData{
    for (int count = 0; count < TableSectionTotal; count++) {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:count] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - SLCalendarDelegate
- (void)recreateMonthsGroupForIndex:(int)index{
    self.monthGroup.shouldAutoScroll = YES;
    [self.monthGroup recreateMonthsGroupForIndex:index];
    [self reloadTableViewData];
}

- (void)updateAutoScroll:(BOOL)shouldAutoScroll{
    self.monthGroup.shouldAutoScroll = shouldAutoScroll;
}

#pragma mark - SLDateRangeUpdateProtocol
- (void)updateDateRangeWithDate:(NSDate *)date{
    [self.monthGroup updateDateRangeWithDate:date];
    [self updateFilterTypeTo:CalendarFilterTypeCustom];
    [self reloadTableViewData];
}

#pragma mark - SLDateRangeCellDelegate
- (void)userUpdatedDate:(NSDate *)newDate forIndex:(TextFieldSelected)index andCell:(SLDateRangeCell *)cell{
    if (index == TextFieldSelectedLeft) {
        [self.monthGroup updateDateRangeWithStartDate:newDate andEndDate:self.monthGroup.dateRange.endDate];
    }else{
        [self.monthGroup updateDateRangeWithStartDate:self.monthGroup.dateRange.startDate andEndDate:newDate];
    }
    self.monthGroup.shouldAutoScroll = YES;
    [self updateFilterTypeTo:CalendarFilterTypeCustom];
    [self reloadTableViewData];
}

#pragma mark - SLSliderPickerCellDelegate
- (void)userTppedForwordButtonOnCell:(SLSliderPickerCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section == TableSectionMonthSelector) {
        self.monthGroup.shouldAutoScroll = YES;
        [self.monthGroup recreateMonthsGroupForIndex:self.monthGroup.currentMonthDisplayedIndex + 1];
        [self reloadTableViewData];
    }else if (indexPath.section == TableSectionYearSelector){
        NSDate *newDate = [[self.monthGroup currentMonthDisplayed].currentMonth dateByAddingYear:1];
        self.monthGroup = [[SLMonthGroup alloc] initWithCurrentDate:newDate
                                                   andSelectedRange:self.dateRange
                                         andNumberOfMonthsPreloaded:1];
        [self reloadTableViewData];
    }
}

- (void)userTppedBackButtonOnCell:(SLSliderPickerCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section == TableSectionMonthSelector) {
        self.monthGroup.shouldAutoScroll = YES;
        [self.monthGroup recreateMonthsGroupForIndex:self.monthGroup.currentMonthDisplayedIndex - 1];
        [self reloadTableViewData];
    }else if(indexPath.section == TableSectionYearSelector){
        NSDate *newDate = [[self.monthGroup currentMonthDisplayed].currentMonth dateBySubtractingYear:1];
        self.monthGroup = [[SLMonthGroup alloc] initWithCurrentDate:newDate
                                                   andSelectedRange:self.dateRange
                                         andNumberOfMonthsPreloaded:1];
        [self reloadTableViewData];
    }
}

@end
