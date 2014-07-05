#import "VENSeparatorView.h"

#define DefaultFillColor [UIColor lightGrayColor]
#define DefaultStrokeColor [UIColor grayColor]

static CGFloat DefaultBorderWidth = 0.50f;
static NSInteger DefaultJaggedEdgeHorizontalVertexDistance = 6;
static NSInteger DefaultJaggedEdgeVerticalVertexDistance = 5;

@implementation VENSeparatorView

- (instancetype)initWithFrame:(CGRect)frame
         topLineSeparatorType:(VENSeparatorType)topLineSeparatorType
      bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor    = [UIColor clearColor];
        _topSeparatorType       = topLineSeparatorType;
        _bottomSeparatorType    = bottomLineSeparatorType;
    }
    return self;
}

- (void)setTopLineSeparatorType:(VENSeparatorType)topLineSeparatorType
        bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType
{
    self.topSeparatorType       = topLineSeparatorType;
    self.bottomSeparatorType    = bottomLineSeparatorType;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    UIColor *topStrokeColor  = self.topStrokeColor ?: DefaultStrokeColor;
    UIColor *bottomStrokeColor  = self.bottomStrokeColor ?: DefaultStrokeColor;

    CGFloat topBorderWidth = self.topBorderWidth ?: DefaultBorderWidth;
    CGFloat bottomBorderWidth = self.bottomBorderWidth ?: DefaultBorderWidth;

    switch (self.topSeparatorType) {
        case VENSeparatorTypeStraight:
            [self drawSeparatorAtPosition:VENSeparatorPositionTop
                                     type:VENSeparatorTypeStraight
                              strokeColor:topStrokeColor
                              borderWidth:topBorderWidth];
            break;
        case VENSeparatorTypeJagged:
            [self drawSeparatorAtPosition:VENSeparatorPositionTop
                                     type:VENSeparatorTypeJagged
                              strokeColor:topStrokeColor
                              borderWidth:topBorderWidth];
            break;
        default:
            break;
    }
    switch (self.bottomSeparatorType) {
        case VENSeparatorTypeStraight:
            [self drawSeparatorAtPosition:VENSeparatorPositionBottom
                                     type:VENSeparatorTypeStraight
                              strokeColor:bottomStrokeColor
                              borderWidth:bottomBorderWidth];
            break;
        case VENSeparatorTypeJagged:
            [self drawSeparatorAtPosition:VENSeparatorPositionBottom
                                     type:VENSeparatorTypeJagged
                              strokeColor:bottomStrokeColor
                              borderWidth:bottomBorderWidth];
            break;
        default:
            break;
    }
}

- (void)drawSeparatorAtPosition:(VENSeparatorPosition)position
                           type:(VENSeparatorType)type
                    strokeColor:(UIColor *)strokeColor
                    borderWidth:(CGFloat)borderWidth
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = borderWidth;
    NSInteger x = 0;
    NSInteger y = (position == VENSeparatorPositionTop) ? borderWidth : CGRectGetHeight(self.frame) - borderWidth;
    [path moveToPoint:CGPointMake(x, y)];

    if (type == VENSeparatorTypeJagged) {
        NSUInteger verticalDisplacement = self.jaggedEdgeVerticalVertexDistance ?: DefaultJaggedEdgeVerticalVertexDistance;
        NSUInteger horizontalDisplacement = self.jaggedEdgeHorizontalVertexDistance ?: DefaultJaggedEdgeHorizontalVertexDistance;
        verticalDisplacement *= (position == VENSeparatorPositionTop) ? +1 : -1;
        BOOL shouldMoveUp = YES;
        while (x <= CGRectGetWidth(self.frame)) {
            x += horizontalDisplacement;
            if (shouldMoveUp) {
                y += verticalDisplacement;
            }
            else {
                y -= verticalDisplacement;
            }
            [path addLineToPoint:CGPointMake(x, y)];
            shouldMoveUp = !shouldMoveUp;
        }
    }
    else if (type == VENSeparatorTypeStraight) {
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), y)];
    }

    CGFloat offSet = 2 * borderWidth;

    x = CGRectGetWidth(self.frame) + offSet;
    y = (position == VENSeparatorPositionTop) ? -offSet : CGRectGetHeight(self.frame) + offSet;
    [path addLineToPoint:CGPointMake(x,y)];

    x = -offSet;
    [path addLineToPoint:CGPointMake(x, y)];

    [strokeColor setStroke];
    [self drawBezierPath:path];
}

- (void)drawBezierPath:(UIBezierPath *)path
{
    UIColor *fillColor = self.fillColor ?: DefaultFillColor;
    [fillColor setFill];
    [path closePath];
    [path fill];
    [path stroke];
}

@end
