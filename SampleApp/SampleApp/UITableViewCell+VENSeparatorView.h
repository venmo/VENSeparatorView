#import <UIKit/UIKit.h>
#import "VENSeparatorView.h"

@interface UITableViewCell (VENSeparatorView)

/**
 *Adds separators to a table view cell with a given height.
 */
- (VENSeparatorView *)addTopLineSeparatorType:(VENSeparatorType)topLineSeparatorType
                      bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType
                      withEstimatedCellHeight:(CGFloat)height;

@end
