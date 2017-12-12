
#import <UIKit/UIKit.h>
#import "SLTitleAndImageProtocol.h"
#import "SLBasicCellProtocol.h"

@interface SLLabelAndChevronCell : UITableViewCell <SLBasicCellProtocol>
@property(strong, nonatomic) IBOutlet NSLayoutConstraint *labelTrailingConstraint;
@property(strong, nonatomic) IBOutlet UILabel *titleLabel;
@property(strong, nonatomic) IBOutlet UIImageView *rightChevron;
@property(strong, nonatomic) IBOutlet UIView *topSeparatorView;
@property(strong, nonatomic) IBOutlet UIView *bottomSeparatorView;

- (void)configureWithModel:(id<SLTitleAndImageProtocol>)model;
+ (CGFloat)cellHeight;
+ (NSString *)cellIdentifier;
@end
