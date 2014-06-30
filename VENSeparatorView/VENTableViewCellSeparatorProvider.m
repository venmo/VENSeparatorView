#import "VENTableViewCellSeparatorProvider.h"
#import "UITableViewCell+VENSeparatorView.h"

@interface VENTableViewCellSeparatorProvider()

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, assign) CGFloat borderWidth;

@end

@implementation VENTableViewCellSeparatorProvider

- (instancetype)initWithStrokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor borderWidth:(CGFloat)borderWidth delegate:(id<VENTableViewSeparatorProviderDelegate, UITableViewDataSource>)delegate {
    self = [super init];
    if (self) {
        _strokeColor = strokeColor;
        _fillColor = fillColor;
        _borderWidth = borderWidth;
        _delegate = delegate;
    }
    return self;
}

- (void)applySeparatorsToCell:(UITableViewCell *)cell
                  atIndexPath:(NSIndexPath *)indexPath
                  inTableView:(UITableView *)tableView
                       height:(CGFloat)height
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
    separatorView.strokeColor = self.strokeColor;
    separatorView.fillColor = self.fillColor;
    separatorView.borderWidth = self.borderWidth;
    separatorView.backgroundColor = selfIsJagged ? self.fillColor : [UIColor clearColor];
}

@end