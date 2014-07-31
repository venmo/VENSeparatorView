#import "SampleTableViewController.h"
#import "VENSeparatorTableViewCellProvider.h"

@interface SampleTableViewController () <VENSeparatorTableViewCellProviderDelegate>

@property (nonatomic, strong) VENSeparatorTableViewCellProvider *separatorProvider;

@end

@implementation SampleTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.separatorProvider = [[VENSeparatorTableViewCellProvider alloc] initWithSeparatorType:VENSeparatorTypeJagged
                                                                                  StrokeColor:[UIColor greenColor]
                                                                                    fillColor:[UIColor purpleColor]
                                                                                     delegate:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    [self.separatorProvider applySeparatorsToCell:cell atIndexPath:indexPath inTableView:tableView cellHeight:0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - VENTableViewSeparatorProviderDelegate methods

// Note: This method has been deprecated and replaced by cellShouldApplySeperatorStyleAtIndexPath: Backwards compatibility has been built in for the time being.

//- (BOOL)isCellJaggedAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row % 7 == 4 ||indexPath.row % 5 == 2) {
//        return YES;
//    }
//    else {
//        return NO;
//    }
//}

- (BOOL)cellShouldApplySeparatorStyleAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 7 == 4 ||indexPath.row % 5 == 2) {
        return YES;
    }
    else {
        return NO;
    }
}


@end