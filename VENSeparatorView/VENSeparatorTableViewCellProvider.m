#import "VENSeparatorTableViewCellProvider.h"
#import "UITableViewCell+VENSeparatorView.h"

@interface VENSeparatorTableViewCellProvider()

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;

@end

@implementation VENSeparatorTableViewCellProvider

- (instancetype)initWithStrokeColor:(UIColor *)strokeColor
                          fillColor:(UIColor *)fillColor
                           delegate:(id<VENSeparatorTableViewCellProviderDelegate, UITableViewDataSource>)delegate
{
    self = [super init];
    if (self) {
        _strokeColor = strokeColor;
        _fillColor = fillColor;
        _delegate = delegate;
    }
    return self;
}

- (VENSeparatorView *)applySeparatorsToCell:(UITableViewCell *)cell
                                atIndexPath:(NSIndexPath *)indexPath
                                inTableView:(UITableView *)tableView
                                 cellHeight:(CGFloat)height
{
    VENSeparatorType topSeperatorType;
    VENSeparatorType bottomSeperatorType;
    
    BOOL topHasSeperatorType = NO;
    BOOL bottomHasSeperatorType = NO;
    
    NSUInteger row = indexPath.row;
    NSUInteger section = indexPath.section;
    
    if (row != 0) {
        topSeperatorType = [self.delegate seperatorTypeAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:section]];
    }
    if (row < [self.delegate tableView:tableView numberOfRowsInSection:indexPath.section] - 1) {
        bottomSeperatorType = [self.delegate seperatorTypeAtIndexPath:[NSIndexPath indexPathForRow:row+1 inSection:section]];
    }
    BOOL selfHasStyle = ([self.delegate seperatorTypeAtIndexPath:indexPath] != VENSeparatorTypeNone);

    topHasSeperatorType = topSeperatorType != VENSeparatorTypeNone;
    bottomHasSeperatorType = bottomSeperatorType != VENSeparatorTypeNone;

    if (selfHasStyle) {
        if (topHasSeperatorType) {
            topSeperatorType = VENSeparatorTypeStraight;
        }
        else {
            topSeperatorType = VENSeparatorTypeNone;
        }
        bottomSeperatorType = VENSeparatorTypeNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        if (topHasSeperatorType) {
            topSeperatorType = topSeperatorType;
        }
        else {
            topSeperatorType = VENSeparatorTypeStraight;
        }
        if (bottomHasSeperatorType) {
            bottomSeperatorType = bottomSeperatorType;
        }
        else {
            bottomSeperatorType = VENSeparatorTypeNone;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }

    CGFloat estimatedHeight = height ?: CGRectGetHeight(cell.frame);

    VENSeparatorView *separatorView = [cell addTopLineSeparatorType:topSeperatorType bottomLineSeparatorType:bottomSeperatorType
                                                         cellHeight:estimatedHeight];
    separatorView.topStrokeColor = (separatorView.topSeparatorType == VENSeparatorTypeJagged) ? self.fillColor : self.strokeColor;
    separatorView.bottomStrokeColor = (separatorView.bottomSeparatorType == VENSeparatorTypeJagged) ? self.fillColor : self.strokeColor;
    separatorView.fillColor = self.fillColor;
    separatorView.backgroundColor = selfHasStyle ? self.fillColor : [UIColor clearColor];
    return separatorView;
}

@end