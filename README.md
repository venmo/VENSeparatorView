VENSeparatorView
=============
[![Build Status](https://travis-ci.org/venmo/VENSeparatorView.svg?branch=master)](https://travis-ci.org/venmo/VENSeparatorView)


VENSeparatorView makes it easy create custom separators on iOS. It's used in the Venmo app to represent transfer stories.

![alt text](http://i.imgur.com/50EQ4S3.jpg "SeparatorView UITableViewCell Demo") -
![alt text](http://i.imgur.com/bdSTrWd.jpg "SeparatorView UIView Demo")

Installation
------------
The easiest way to get started is to use [CocoaPods](http://cocoapods.org/). Just add the following line to your Podfile:

```ruby
pod 'VENSeparatorView', '~> 1.0.0'
```

General Usage
-------------

Import ```VENSeparatorView.h```

Create an instance of UISeparatorView or a UISeparatorView subclass using its ```initWithFrame:topLineSeparatorType:bottomLineSeparatorType``` initializer and add it as a subview.

VENSeparatorType options are:
```
VENSeparatorTypeStraight,
VENSeparatorTypeJagged,
VENSeparatorTypeNone
```

UITableViewCell Provider
-----------------------

Making styled cells in a UITableView is simple using the included VENSeparatorTableViewCellProvider

Import ```#import "VENSeparatorTableViewCellProvider.h"``` in your UITableViewDataSource and conform this class to the ```VENSeparatorTableViewCellProviderDelegate``` protocol ```cellShouldApplySeparatorStyleAtIndexPath:``` method. 

Example:

```obj-c
// Specifies that cells at indexPath should apply separator style set in initializer. 
- (BOOL) cellShouldApplySeparatorStyleAtIndexPath:(NSIndexPath)indexPath
{
        if (indexPath.row % 7 == 4 ||indexPath.row % 5 == 2) {
            return YES;
        }
        else {
            return NO;
        }
}
```

Set your UITableView's ```separatorStyle``` property to ```UITableViewCellSeparatorStyleNone```

Create a VENSeparatorTableViewCellProvider property:

```obj-c
@property (nonatomic, strong) VENSeparatorTableViewCellProvider *separatorProvider;
```

In this class's ```init``` method, or in the ```viewDidLoad``` method, if this class is a UIViewController subclass, instantiate the VENSeparatorTableViewCellProvider property using its ```initWithSeparatorType:StrokeColor:fillColor:delegate:``` method.

```obj-c
self.separatorProvider = [[VENSeparatorTableViewCellProvider alloc] initWithSeparatorType:VENSeparatorTypeJagged                                                                                          StrokeColor:[UIColor grayColor]
                                                                                fillColor:[UIColor lightGrayColor]
                                                                                 delegate:self];
```

At the end of your data source's ```tableView:cellForRowAtIndexPath:``` method apply separators to the UITableViewCell with the VENSeparatorTableViewCellProvider's ```applySeparatorsToCell:atIndexPath:inTableView:cellHeight:``` 

```obj-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    // ...

    [self.separatorProvider applySeparatorsToCell:cell atIndexPath:indexPath inTableView:tableView cellHeight:0];
    return cell;
}
```

Sample Project
--------------
Check out the [sample project](https://github.com/venmo/VENSeparatorView/tree/master/SampleApp) in this repo for sample usage.

Contributing
------------

We'd love to see your ideas for improving this library! The best way to contribute is by submitting a pull request. We'll do our best to respond to your patch as soon as possible. You can also submit a [new Github issue](https://github.com/venmo/VENSeparatorView/issues/new) if you find bugs or have questions. :octocat:
