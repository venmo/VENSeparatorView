#import <UIKit/UIKit.h>
#import "VENSeparatorView.h"

@interface UITableViewCell (VENSeparatorView)

/**
 *Adds separators to a table view cell with a given height.

 @param topLineSeparatorType The type of separator at the top of the separator view.
 @param bottomLineSeparatorType The type of separator at the bottom of the separator view.
 @param height The expected height of the specified cell. If set to 0, the height of the separator view will be the default height of the cell.
 @return A seperator view with the given separators and height. This method also sets the returned separator view as the first subview of the reciever's content view.
 */
- (VENSeparatorView *)addTopLineSeparatorType:(VENSeparatorType)topLineSeparatorType
                      bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType
                                   cellHeight:(CGFloat)height;


/**
 *Adds separators to a table view cell with a given height.

 @param topLineSeparatorType The type of separator at the top of the separator view.
 @param bottomLineSeparatorType The type of separator at the bottom of the separator view.
 @param height The expected height of the specified cell. If set to 0, the height of the separator view will be the default height of the cell.
 @param separatorClass A subclass of VENSeparatorView
 @return The seperator view of the specified subclass. This method also sets the returned separator view as the first subview of the reciever's content view.
 */
- (VENSeparatorView *)addTopLineSeparatorType:(VENSeparatorType)topLineSeparatorType
                      bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType
                                   cellHeight:(CGFloat)height
                     forSeparatorViewSubclass:(Class)separatorClass;

@end
