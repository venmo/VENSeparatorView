#import "UITableViewCell+VENSeparatorView.h"

@implementation UITableViewCell (VENSeparatorView)

- (void)addTopLineSeparatorType:(VENSeparatorType)topLineSeparatorType bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType withEstimatedCellHeight:(CGFloat)height {
    [self addTopLineSeparatorType:topLineSeparatorType bottomLineSeparatorType:bottomLineSeparatorType withEstimatedCellHeight:height forSeparatorViewSubclass:[VENSeparatorView class]];
}

- (void)addTopLineSeparatorType:(VENSeparatorType)topLineSeparatorType bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType withEstimatedCellHeight:(CGFloat)height forSeparatorViewSubclass:(Class)separatorClass
{
    UIView *firstSubview = [[self.contentView subviews] firstObject];
    if ([firstSubview isMemberOfClass:separatorClass]) {
        VENSeparatorView *separatorView = (VENSeparatorView *)firstSubview;
        BOOL differentTopTypes = separatorView.topSeparatorType != topLineSeparatorType;
        BOOL differentBottomTypes = separatorView.bottomSeparatorType != bottomLineSeparatorType;
        BOOL differentHeights = CGRectGetHeight(separatorView.frame) != height;
        if (differentTopTypes || differentBottomTypes || differentHeights) {
            separatorView.topSeparatorType = topLineSeparatorType;
            separatorView.bottomSeparatorType = bottomLineSeparatorType;
            CGRect newFrame = separatorView.frame;
            newFrame.size.height = height;
            separatorView.frame = newFrame;
            [separatorView setNeedsDisplay];
        }
    } else {
        if ([firstSubview isKindOfClass:[VENSeparatorView class]]) {
            [firstSubview removeFromSuperview];
        }
        CGRect separatorFrame =
        CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), height);
        VENSeparatorView *separatorView =
        [[separatorClass alloc] initWithFrame:separatorFrame
                           topLineSeparatorType:topLineSeparatorType
                        bottomLineSeparatorType:bottomLineSeparatorType];
        [self.contentView insertSubview:separatorView atIndex:0];
    }
}

@end
