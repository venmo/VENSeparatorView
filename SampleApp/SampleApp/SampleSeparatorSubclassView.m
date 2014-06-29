#import "SampleSeparatorSubclassView.h"

@implementation SampleSeparatorSubclassView

- (instancetype)initWithFrame:(CGRect)frame
         topLineSeparatorType:(VENSeparatorType)topLineSeparatorType bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType
{
    self = [super initWithFrame:frame
           topLineSeparatorType:topLineSeparatorType
        bottomLineSeparatorType:bottomLineSeparatorType];
    if (self) {
        self.fillColor = [UIColor lightGrayColor];
        self.strokeColor = [UIColor grayColor];
    }
    return self;
}

@end
