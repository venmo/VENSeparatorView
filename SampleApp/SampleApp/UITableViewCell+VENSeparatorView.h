#import <UIKit/UIKit.h>
#import "VENSeparatorView.h"

@interface UITableViewCell (VENSeparatorView)

/**
 *Adds separators to a table view cell with a given height.
 */
- (void)addTopLineSeparatorType:(VENSeparatorType)topLineSeparatorType
        bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType
        withEstimatedCellHeight:(CGFloat)height;

- (void)addTopLineSeparatorType:(VENSeparatorType)topLineSeparatorType bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType withEstimatedCellHeight:(CGFloat)height forSeparatorViewSubclass:(Class)separatorClass;
@end
