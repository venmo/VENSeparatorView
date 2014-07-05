#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class VENSeparatorView;

@protocol VENSeparatorTableViewCellProviderDelegate <NSObject>

@required
/**
 YES if the cell at the given indexPath is a jagged cell. NO otherwise.
 */
- (BOOL)isCellJaggedAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface VENSeparatorTableViewCellProvider : NSObject

@property (nonatomic, weak) id<VENSeparatorTableViewCellProviderDelegate, UITableViewDataSource> delegate;

/**
 Creates a separator provider that can apply seperators with the given stroke color, fill color, border width and delegate.

 @param strokeColor The color of the separator lines.
 @param fillColor The color of the jagged cells.
 @param delegate The provider's delegate that conforms to the VENTableViewSeparatorProviderDelegate and UITableViewDataSource protocols.

 @return An initialized seperator provider.
 */
- (instancetype)initWithStrokeColor:(UIColor *)strokeColor
                          fillColor:(UIColor *)fillColor
                           delegate:(id<VENSeparatorTableViewCellProviderDelegate, UITableViewDataSource>)delegate;


/**
 Applies the separators to the specified cell. This function should be called in the table view tableView:cellForRowAtIndexPath method.

 @param cell The cell on which the separator view is added. The separator view will be added to the first subview of this cell's content view.
 @param indexPath The indexPath of the specified cell.
 @param tableview The table view that contains the specified cell.
 @param height The expected height of the specified cell. If set to 0, the height of the separator view will be the default height of the cell.

 @return The separator view applied to the specified cell
 */
- (VENSeparatorView *)applySeparatorsToCell:(UITableViewCell *)cell
                                atIndexPath:(NSIndexPath *)indexPath
                                inTableView:(UITableView *)tableView
                                 cellHeight:(CGFloat)height;

@end
