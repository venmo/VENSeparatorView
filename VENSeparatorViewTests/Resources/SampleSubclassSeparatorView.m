#import "SampleSubclassSeparatorView.h"

@implementation SampleSubclassSeparatorView

- (instancetype)initWithFrame:(CGRect)frame
         topLineSeparatorType:(VENSeparatorType)topLineSeparatorType
      bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType {
    self = [super initWithFrame:frame topLineSeparatorType:topLineSeparatorType bottomLineSeparatorType:bottomLineSeparatorType];
    if (self) {
        self.fillColor = [UIColor yellowColor];
        self.topStrokeColor = [UIColor greenColor];
    }
    return self;
}

@end
