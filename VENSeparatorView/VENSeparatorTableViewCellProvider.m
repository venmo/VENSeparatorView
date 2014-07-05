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
    BOOL topIsJagged = NO;
    BOOL bottomIsJagged = NO;
    NSUInteger row = indexPath.row;
    NSUInteger section = indexPath.section;
    if (row != 0) {
        topIsJagged = [self.delegate isCellJaggedAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:section]];
    }
    if (row < [self.delegate tableView:tableView numberOfRowsInSection:indexPath.section] - 1) {
        bottomIsJagged = [self.delegate isCellJaggedAtIndexPath:[NSIndexPath indexPathForRow:row+1 inSection:section]];
    }
    BOOL selfIsJagged = [self.delegate isCellJaggedAtIndexPath:indexPath];

    VENSeparatorType topType;
    VENSeparatorType bottomType;

    if (selfIsJagged) {
        if (topIsJagged) {
            topType = VENSeparatorTypeStraight;
        }
        else {
            topType = VENSeparatorTypeNone;
        }
        bottomType = VENSeparatorTypeNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        if (topIsJagged) {
            topType = VENSeparatorTypeJagged;
        }
        else {
            topType = VENSeparatorTypeStraight;
        }
        if (bottomIsJagged) {
            bottomType = VENSeparatorTypeJagged;
        }
        else {
            bottomType = VENSeparatorTypeNone;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    CGFloat estimatedHeight = height ?: CGRectGetHeight(cell.frame);

    VENSeparatorView *separatorView = [cell addTopLineSeparatorType:topType bottomLineSeparatorType:bottomType
                                                         cellHeight:estimatedHeight];
    separatorView.topStrokeColor = (separatorView.topSeparatorType == VENSeparatorTypeJagged) ? self.fillColor : self.strokeColor;
    separatorView.bottomStrokeColor = (separatorView.bottomSeparatorType == VENSeparatorTypeJagged) ? self.fillColor : self.strokeColor;
    separatorView.fillColor = self.fillColor;
    separatorView.backgroundColor = selfIsJagged ? self.fillColor : [UIColor clearColor];
    return separatorView;
}

@end