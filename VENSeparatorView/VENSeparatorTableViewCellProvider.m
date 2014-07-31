#import "VENSeparatorTableViewCellProvider.h"


@interface VENSeparatorTableViewCellProvider()

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;

@end

@implementation VENSeparatorTableViewCellProvider

- (instancetype)initWithStrokeColor:(UIColor *)strokeColor
                          fillColor:(UIColor *)fillColor
                           delegate:(id<VENSeparatorTableViewCellProviderDelegate, UITableViewDataSource>)delegate
{
    return [self initWithSeparatorType:VENSeparatorTypeJagged StrokeColor:strokeColor fillColor:fillColor delegate:delegate];
}

- (instancetype)initWithSeparatorType:(VENSeparatorType)separatorType
                          StrokeColor:(UIColor *)strokeColor
                            fillColor:(UIColor *)fillColor
                             delegate:(id<VENSeparatorTableViewCellProviderDelegate, UITableViewDataSource>)delegate
{
    self = [super init];
    if (self) {
        _separatorType = separatorType;
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
    BOOL topAppliesStyle = NO;
    BOOL bottomAppliesStyle = NO;
    NSUInteger row = indexPath.row;
    NSUInteger section = indexPath.section;
    
    BOOL cellJaggedImplemented = [self.delegate respondsToSelector:@selector(isCellJaggedAtIndexPath:)];
    BOOL shouldApplySeparatorImplemented = [self.delegate respondsToSelector:@selector(cellShouldApplySeparatorStyleAtIndexPath:)];
   
    BOOL selfAppliesStyle = NO;
  
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    if (cellJaggedImplemented && !shouldApplySeparatorImplemented) {
        if (row != 0) {
            topAppliesStyle = [self.delegate isCellJaggedAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:section]];
        }
        if (row < [self.delegate tableView:tableView numberOfRowsInSection:indexPath.section] - 1) {
            bottomAppliesStyle = [self.delegate isCellJaggedAtIndexPath:[NSIndexPath indexPathForRow:row+1 inSection:section]];
        }
        selfAppliesStyle = [self.delegate isCellJaggedAtIndexPath:indexPath];
    }
    
    else  {
        if (row != 0) {
            topAppliesStyle = [self.delegate cellShouldApplySeparatorStyleAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:section]];
        }
        if (row < [self.delegate tableView:tableView numberOfRowsInSection:indexPath.section] - 1) {
            bottomAppliesStyle = [self.delegate cellShouldApplySeparatorStyleAtIndexPath:[NSIndexPath indexPathForRow:row+1 inSection:section]];
        }
        selfAppliesStyle = [self.delegate cellShouldApplySeparatorStyleAtIndexPath:indexPath];
    }
    
#pragma clang diagnostic pop 
    
    VENSeparatorType topType;
    VENSeparatorType bottomType;
    
    if (selfAppliesStyle) {
        if (topAppliesStyle) {
            topType = VENSeparatorTypeStraight;
        }
        else {
            topType = VENSeparatorTypeNone;
        }
        bottomType = VENSeparatorTypeNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        if (topAppliesStyle) {
            topType = self.separatorType;
        }
        else {
            topType = VENSeparatorTypeStraight;
        }
        if (bottomAppliesStyle) {
            bottomType = self.separatorType;
        }
        else {
            bottomType = VENSeparatorTypeNone;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    CGFloat estimatedHeight = height ?: CGRectGetHeight(cell.frame);
    
    VENSeparatorView *separatorView = [cell addTopLineSeparatorType:topType bottomLineSeparatorType:bottomType
                                                         cellHeight:estimatedHeight];
    separatorView.topStrokeColor = (separatorView.topSeparatorType == self.separatorType) ? self.fillColor : self.strokeColor;
    separatorView.bottomStrokeColor = (separatorView.bottomSeparatorType == self.separatorType) ? self.fillColor : self.strokeColor;
    separatorView.fillColor = self.fillColor;
    separatorView.backgroundColor = selfAppliesStyle ? self.fillColor : [UIColor clearColor];
    
    return separatorView;
}



@end