#import <Foundation/Foundation.h>

@protocol VENTableViewSeparatorProviderDelegate <NSObject>

@required
- (BOOL)cellIsJaggedForAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface VENTableViewSeparatorProvider : NSObject

@property (nonatomic, weak) id<VENTableViewSeparatorProviderDelegate, UITableViewDataSource, UITableViewDelegate> delegate;

- (void)applySeparatorsToCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView;

@end
