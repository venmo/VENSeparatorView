#import "UITableViewCell+VENSeparatorView.h"

@implementation UITableViewCell (VENSeparatorView)

- (VENSeparatorView *)addTopLineSeparatorType:(VENSeparatorType)topLineSeparatorType
                      bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType
                                   cellHeight:(CGFloat)height
{
    return [self addTopLineSeparatorType:topLineSeparatorType
                 bottomLineSeparatorType:bottomLineSeparatorType
                              cellHeight:height
                forSeparatorViewSubclass:[VENSeparatorView class]];
}

- (VENSeparatorView *)addTopLineSeparatorType:(VENSeparatorType)topLineSeparatorType
                      bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType
                                   cellHeight:(CGFloat)height
                     forSeparatorViewSubclass:(Class)separatorClass
{
    UIView *firstSubview = [[self.contentView subviews] firstObject];
    VENSeparatorView *separatorView;
    if ([firstSubview isMemberOfClass:separatorClass]) {
        separatorView = (VENSeparatorView *)firstSubview;
        BOOL differentTopTypes = separatorView.topSeparatorType != topLineSeparatorType;
        BOOL differentBottomTypes = separatorView.bottomSeparatorType != bottomLineSeparatorType;
        BOOL differentHeights = CGRectGetHeight(separatorView.frame) != height;
        if (differentTopTypes || differentBottomTypes || differentHeights) {
            separatorView.topSeparatorType = topLineSeparatorType;
            separatorView.bottomSeparatorType = bottomLineSeparatorType;

            CGRect separatorFrame = [self adjustedFrameForTopSeparatorType:topLineSeparatorType bottomSeparatorType:bottomLineSeparatorType cellHeight:height];
            separatorView.frame = separatorFrame;
            [separatorView setNeedsDisplay];
        }
    } else {
        if ([firstSubview isKindOfClass:[VENSeparatorView class]]) {
            [firstSubview removeFromSuperview];
        }
        if ([separatorClass isSubclassOfClass:[VENSeparatorView class]]) {
            CGRect separatorFrame = [self adjustedFrameForTopSeparatorType:topLineSeparatorType bottomSeparatorType:bottomLineSeparatorType cellHeight:height];
            separatorView = [[separatorClass alloc] initWithFrame:separatorFrame
                                             topLineSeparatorType:topLineSeparatorType
                                          bottomLineSeparatorType:bottomLineSeparatorType];
            separatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            separatorView.backgroundColor = [UIColor clearColor];
            [self.contentView insertSubview:separatorView atIndex:0];
        }
    }
    return separatorView;
}

- (CGRect)adjustedFrameForTopSeparatorType:(VENSeparatorType)topLineSeparatorType
                       bottomSeparatorType:(VENSeparatorType)bottomLineSeparatorType
                                cellHeight:(CGFloat)height
{
    CGFloat y = 0;
    CGFloat adjustedHeight = height;
    CGFloat safeOffset = 0.5;
    if (topLineSeparatorType == VENSeparatorTypeJagged && bottomLineSeparatorType == VENSeparatorTypeJagged) {
        y -= safeOffset;
        adjustedHeight += 2 * safeOffset;
    }
    else {
        if (topLineSeparatorType == VENSeparatorTypeJagged) {
            y -= safeOffset;
        }
        if (bottomLineSeparatorType == VENSeparatorTypeJagged) {
            adjustedHeight += safeOffset;
        }
    }
    CGRect separatorFrame =
    CGRectMake(0, y, CGRectGetWidth(self.contentView.frame), adjustedHeight);
    return separatorFrame;
}

@end
