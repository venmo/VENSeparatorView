#import "SampleTableViewCellProviderDelegate.h"

@implementation SampleTableViewCellProviderDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (BOOL)isCellJaggedAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
