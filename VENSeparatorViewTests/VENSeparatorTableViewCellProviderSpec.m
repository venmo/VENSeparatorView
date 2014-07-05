#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>
#import <OCMock/OCMock.h>

#import "VENSeparatorTableViewCellProvider.h"
#import "SampleTableViewCellProviderDelegate.h"
#import "VENSeparatorView.h"

SpecBegin(VENSeparatorTableViewCellProvider)

__block id mockDelegate;
__block VENSeparatorTableViewCellProvider *provider;

beforeAll(^{
    mockDelegate = [OCMockObject mockForClass:[SampleTableViewCellProviderDelegate class]];
    [[[mockDelegate stub] andReturnValue:@5] tableView:OCMOCK_ANY numberOfRowsInSection:0];
    [[[mockDelegate stub] andReturnValue:@NO] isCellJaggedAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [[[mockDelegate stub] andReturnValue:@YES] isCellJaggedAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [[[mockDelegate stub] andReturnValue:@YES] isCellJaggedAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    [[[mockDelegate stub] andReturnValue:@NO] isCellJaggedAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    [[[mockDelegate stub] andReturnValue:@YES] isCellJaggedAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    provider = [[VENSeparatorTableViewCellProvider alloc]
                initWithStrokeColor:[UIColor grayColor]
                fillColor:[UIColor lightGrayColor]
                delegate:mockDelegate];
});

describe(@"applySeparatorsToCell:atIndexPath:inTableView:cellHeight:", ^{
    __block UITableViewCell *cell;
    beforeEach(^{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    });

    it(@"should create a clear separator view on the first cell with a straight top line and jagged bottom line", ^{
        VENSeparatorView *separatorView = [provider applySeparatorsToCell:cell
                                                              atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                                              inTableView:nil
                                                               cellHeight:0];
        expect([cell.contentView.subviews firstObject]).to.equal(separatorView);
        expect(separatorView.topSeparatorType).to.equal(VENSeparatorTypeStraight);
        expect(separatorView.bottomSeparatorType).to.equal(VENSeparatorTypeJagged);
        expect(separatorView.backgroundColor).equal([UIColor clearColor]);
    });

    it(@"should create a light gray separator view on the second cell with no top line and no bottom line", ^{
        VENSeparatorView *separatorView = [provider applySeparatorsToCell:cell
                                                              atIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]
                                                              inTableView:nil
                                                               cellHeight:0];
        expect([cell.contentView.subviews firstObject]).to.equal(separatorView);
        expect(separatorView.topSeparatorType).to.equal(VENSeparatorTypeNone);
        expect(separatorView.bottomSeparatorType).to.equal(VENSeparatorTypeNone);
        expect(separatorView.backgroundColor).equal([UIColor lightGrayColor]);

    });

    it(@"should create a light gray separator view on the third cell with a straight top line and no bottom line", ^{
        VENSeparatorView *separatorView = [provider applySeparatorsToCell:cell
                                                              atIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]
                                                              inTableView:nil
                                                               cellHeight:0];
        expect([cell.contentView.subviews firstObject]).to.equal(separatorView);
        expect(separatorView.topSeparatorType).to.equal(VENSeparatorTypeStraight);
        expect(separatorView.bottomSeparatorType).to.equal(VENSeparatorTypeNone);
        expect(separatorView.backgroundColor).equal([UIColor lightGrayColor]);
    });

    it(@"should create a clear separator view on the fourth cell with a jagged top line and no bottom line", ^{
        VENSeparatorView *separatorView = [provider applySeparatorsToCell:cell
                                                              atIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]
                                                              inTableView:nil
                                                               cellHeight:0];
        expect([cell.contentView.subviews firstObject]).to.equal(separatorView);
        expect(separatorView.topSeparatorType).to.equal(VENSeparatorTypeJagged);
        expect(separatorView.bottomSeparatorType).to.equal(VENSeparatorTypeJagged);
        expect(separatorView.backgroundColor).equal([UIColor clearColor]);
    });

    it(@"should create a light gray separator view on the fifth cell with no top line and no bottom line", ^{
        VENSeparatorView *separatorView = [provider applySeparatorsToCell:cell
                                                              atIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]
                                                              inTableView:nil
                                                               cellHeight:0];
        expect([cell.contentView.subviews firstObject]).to.equal(separatorView);
        expect(separatorView.topSeparatorType).to.equal(VENSeparatorTypeNone);
        expect(separatorView.bottomSeparatorType).to.equal(VENSeparatorTypeNone);
        expect(separatorView.backgroundColor).equal([UIColor lightGrayColor]);
    });

});

SpecEnd