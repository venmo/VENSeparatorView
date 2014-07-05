#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "VENSeparatorView.h"

SpecBegin(VENSeparatorView)

__block VENSeparatorView *separatorView;

beforeEach(^{
    separatorView = [[VENSeparatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)
                                       topLineSeparatorType:VENSeparatorTypeStraight
                                    bottomLineSeparatorType:VENSeparatorTypeJagged];
});

describe(@"initWithFrame:topLineSeparatorType:bottomLineSeparatorType:", ^{
    it(@"should create a VENSeparatorView instance with the specified separator types", ^{
        expect(separatorView.topSeparatorType).equal(VENSeparatorTypeStraight);
        expect(separatorView.bottomSeparatorType).equal(VENSeparatorTypeJagged);
    });
});

describe(@"setTopLineSeparatorType:bottomLineSeparatorType:", ^{
    it(@"should set the top and bottom separator types of the VENSeparatorView", ^{
        [separatorView setTopLineSeparatorType:VENSeparatorTypeNone
                       bottomLineSeparatorType:VENSeparatorTypeStraight];
        expect(separatorView.topSeparatorType).equal(VENSeparatorTypeNone);
        expect(separatorView.bottomSeparatorType).equal(VENSeparatorTypeStraight);
    });
});

SpecEnd