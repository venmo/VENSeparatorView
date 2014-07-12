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
    VENSeparatorType topSeparatorType;
    VENSeparatorType bottomSeparatorType;
    
    BOOL topHasSeparatorType = NO;
    BOOL bottomHasSeparatorType = NO;
    
    NSUInteger row = indexPath.row;
    NSUInteger section = indexPath.section;
    
    if (row != 0) {
        topSeparatorType = [self.delegate separatorTypeAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:section]];
    }
    if (row < [self.delegate tableView:tableView numberOfRowsInSection:indexPath.section] - 1) {
        bottomSeparatorType = [self.delegate separatorTypeAtIndexPath:[NSIndexPath indexPathForRow:row+1 inSection:section]];
    }
    BOOL selfHasStyle = ([self.delegate separatorTypeAtIndexPath:indexPath] != VENSeparatorTypeNone);

    topHasSeparatorType = topSeparatorType != VENSeparatorTypeNone;
    bottomHasSeparatorType = bottomSeparatorType != VENSeparatorTypeNone;

    if (selfHasStyle) {
        if (topHasSeparatorType) {
            topSeparatorType = VENSeparatorTypeStraight;
        }
        else {
            topSeparatorType = VENSeparatorTypeNone;
        }
        bottomSeparatorType = VENSeparatorTypeNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        if (topHasSeparatorType) {
            topSeparatorType = topSeparatorType;
        }
        else {
            topSeparatorType = VENSeparatorTypeStraight;
        }
        if (bottomHasSeparatorType) {
            bottomSeparatorType = bottomSeparatorType;
        }
        else {
            bottomSeparatorType = VENSeparatorTypeNone;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }

    CGFloat estimatedHeight = height ?: CGRectGetHeight(cell.frame);

    VENSeparatorView *separatorView = [cell addTopLineSeparatorType:topSeparatorType bottomLineSeparatorType:bottomSeparatorType
                                                         cellHeight:estimatedHeight];
    separatorView.topStrokeColor = (separatorView.topSeparatorType == VENSeparatorTypeJagged) ? self.fillColor : self.strokeColor;
    separatorView.bottomStrokeColor = (separatorView.bottomSeparatorType == VENSeparatorTypeJagged) ? self.fillColor : self.strokeColor;
    separatorView.fillColor = self.fillColor;
    separatorView.backgroundColor = selfHasStyle ? self.fillColor : [UIColor clearColor];
    return separatorView;
}

@end