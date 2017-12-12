
#import "SLLabelAndChevronCell.h"



@implementation SLLabelAndChevronCell

- (void)configureWithModel:(id<SLTitleAndImageProtocol>)model{
    _titleLabel.text = model.title;
    _rightChevron.image = [UIImage imageNamed:model.imageName];
    if (model.isSelected) {
        _labelTrailingConstraint.constant = 44;
        self.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    }else{
        _labelTrailingConstraint.constant = 16;
        self.backgroundColor = [UIColor whiteColor];
    }
    _rightChevron.hidden = !model.isSelected;
    [_topSeparatorView setHidden:!model.isTopSeparatorVisible];
    [_bottomSeparatorView setHidden:!model.isBottomSeparatorVisible];    
}

+ (CGFloat)cellHeight{
    return 44.0;
}

+ (NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

@end
