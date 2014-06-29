#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VENSeparatorType) {
    VENSeparatorTypeStraight,
    VENSeparatorTypeJagged,
    VENSeparatorTypeNone
};

typedef NS_ENUM(NSUInteger, VENSeparatorPosition) {
    VENSeparatorPositionTop,
    VENSeparatorPositionBottom
};

@interface VENSeparatorView : UIView

@property (nonatomic, assign) VENSeparatorType topSeparatorType;
@property (nonatomic, assign) VENSeparatorType bottomSeparatorType;

@property (nonatomic, assign) NSUInteger jaggedEdgeVerticalVertexDistance;
@property (nonatomic, assign) NSUInteger jaggedEdgeHorizontalVertexDistance;

@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;

/**
 * Initializes a separator view with the given separator types.
 */
- (instancetype)initWithFrame:(CGRect)frame
         topLineSeparatorType:(VENSeparatorType)topLineSeparatorType
      bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType;

/**
 * Sets separator view with the given separator types.
 */
- (void)setTopLineSeparatorType:(VENSeparatorType)topLineSeparatorType
        bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType;


@end
