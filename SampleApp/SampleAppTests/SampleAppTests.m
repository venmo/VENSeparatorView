#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "SampleSubclassSeparatorView.h"
#import "UITableViewCell+VENSeparatorView.h"

SpecBegin(UITableViewCellVENSeparatorView)

describe(@"addTopLineSeparatorType:bottomLineSeparatorType:CellHeight:", ^{
    it(@"should insert a VENSeparatorView to the UITableViewCell's content view at the first index with the specified line types and height", ^{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [cell.contentView addSubview:label];
        [cell addTopLineSeparatorType:VENSeparatorTypeJagged bottomLineSeparatorType:VENSeparatorTypeStraight cellHeight:30];

        expect([[cell.contentView subviews] count]).to.equal(2);
        expect([cell.contentView.subviews firstObject]).to.beInstanceOf([VENSeparatorView class]);

        VENSeparatorView *separatorView = (VENSeparatorView *)[cell.contentView.subviews firstObject];
        expect([cell.contentView.subviews lastObject]).to.equal(label);
        expect(separatorView.topSeparatorType).to.equal(VENSeparatorTypeJagged);
        expect(separatorView.bottomSeparatorType).to.equal(VENSeparatorTypeStraight);
        expect(CGRectGetHeight(separatorView.frame)).to.equal(30);
    });

});

describe(@"addTopLineSeparatorType:bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorTypeCellHeight:forSeparatorViewSubclass:", ^{
    it(@"should insert the VENSeparatorView subclass to the UITableViewCell's content view at the first index with the specified line types and height", ^{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell addTopLineSeparatorType:VENSeparatorTypeJagged bottomLineSeparatorType:VENSeparatorTypeStraight cellHeight:30 forSeparatorViewSubclass:[SampleSubclassSeparatorView class]];
        expect([cell.contentView.subviews firstObject]).to.beInstanceOf([SampleSubclassSeparatorView class]);
        SampleSubclassSeparatorView *separatorView = (SampleSubclassSeparatorView *)[cell.contentView.subviews firstObject];
        expect(separatorView.topSeparatorType).to.equal(VENSeparatorTypeJagged);
        expect(separatorView.bottomSeparatorType).to.equal(VENSeparatorTypeStraight);
        expect(separatorView.fillColor).to.equal([UIColor yellowColor]);
        expect(separatorView.topStrokeColor).to.equal([UIColor greenColor]);
    });

    it(@"should not add a separator class if the class that is passed is not a subclass of VENSepartorClass", ^{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell addTopLineSeparatorType:VENSeparatorTypeJagged bottomLineSeparatorType:VENSeparatorTypeStraight cellHeight:30 forSeparatorViewSubclass:[UIView class]];
    });
});

SpecEnd