#import "SampleTableViewController.h"
#import "VENTableViewSeparatorProvider.h"

@interface SampleTableViewController () <VENTableViewSeparatorProviderDelegate>

@property (nonatomic, strong) VENTableViewSeparatorProvider *separatorProvider;

@end

@implementation SampleTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.separatorProvider = [[VENTableViewSeparatorProvider alloc] init];
    self.separatorProvider.delegate = self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    [self.separatorProvider applySeparatorsToCell:cell atIndexPath:indexPath inTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - VENTableViewSeparatorProviderDelegate methods

- (BOOL)cellIsJaggedForAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 4 == 0) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
