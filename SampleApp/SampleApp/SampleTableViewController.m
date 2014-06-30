#import "SampleTableViewController.h"
#import "VENTableViewCellSeparatorProvider.h"

@interface SampleTableViewController () <VENTableViewSeparatorProviderDelegate>

@property (nonatomic, strong) VENTableViewCellSeparatorProvider *separatorProvider;

@end

@implementation SampleTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.separatorProvider = [[VENTableViewCellSeparatorProvider alloc]
                              initWithStrokeColor:[UIColor grayColor]
                              fillColor:[UIColor lightGrayColor]
                              borderWidth:0.5f
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
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    [self.separatorProvider applySeparatorsToCell:cell atIndexPath:indexPath inTableView:tableView expectedHeight:0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - VENTableViewSeparatorProviderDelegate methods

- (BOOL)isCellJaggedAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 7 == 4 ||indexPath.row % 5 == 2) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
