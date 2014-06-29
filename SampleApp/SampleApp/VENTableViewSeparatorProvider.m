#import "VENTableViewSeparatorProvider.h"
#import "UITableViewCell+VENSeparatorView.h"
#import "SampleSeparatorSubclassView.h"

@implementation VENTableViewSeparatorProvider

- (void)applySeparatorsToCell:(UITableViewCell *)cell
                  atIndexPath:(NSIndexPath *)indexPath
                  inTableView:(UITableView *)tableView
{
    BOOL topIsJagged = NO;
    BOOL bottomIsJagged = NO;
    NSUInteger row = indexPath.row;
    NSUInteger section = indexPath.section;
    if (row != 0) {
        topIsJagged = [self.delegate cellIsJaggedForAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:section]];
    }
    if (row < [self.delegate tableView:tableView numberOfRowsInSection:indexPath.section] - 1) {
        bottomIsJagged = [self.delegate cellIsJaggedForAtIndexPath:[NSIndexPath indexPathForRow:row+1 inSection:section]];
    }
    BOOL selfIsJagged = [self.delegate cellIsJaggedForAtIndexPath:indexPath];

    VENSeparatorType topType;
    VENSeparatorType bottomType;

    if (selfIsJagged) {
        topType = VENSeparatorTypeNone;
        bottomIsJagged = VENSeparatorTypeNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    else {
        if (topIsJagged) {
            topType = VENSeparatorTypeJagged;
        }
        else {
            topType = VENSeparatorTypeStraight;
        }
        if (bottomIsJagged) {
            bottomType = VENSeparatorTypeJagged;
        }
        else {
            bottomType = VENSeparatorTypeNone;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.backgroundColor = [UIColor whiteColor];
    }


    CGFloat estimatedHeight = CGRectGetHeight(cell.frame);

    if ([self.delegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
        estimatedHeight  = [self.delegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath] ?: CGRectGetHeight(cell.frame);
    }


    [cell addTopLineSeparatorType:topType bottomLineSeparatorType:bottomType
          withEstimatedCellHeight:estimatedHeight
         forSeparatorViewSubclass:[SampleSeparatorSubclassView class]];
}

@end
