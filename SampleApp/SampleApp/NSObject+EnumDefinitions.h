//
//  NSObject+EnumDefinitions.h
//  SampleApp
//
//  Created by Al Tyus on 7/11/14.
//  Copyright (c) 2014 Venmo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, VENSeparatorPosition) {
    VENSeparatorPositionTop,
    VENSeparatorPositionBottom
};

typedef NS_ENUM(NSInteger, VENSeparatorType) {
    VENSeparatorTypeStraight,
    VENSeparatorTypeJagged,
    VENSeperatorTypeInset,
    VENSeparatorTypeNone
};

@interface NSObject (EnumDefinitions)

@end
