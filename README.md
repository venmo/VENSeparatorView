VENSeparatorView
=============

```VENSeparatorView``` makes it easy create custom separators on iOS. It's used in the Venmo app to represent transfer stories.

![alt text](http://i.imgur.com/5pPSKZO.jpg "RecipientView UIView Demo")
![alt text](http://imgur.com/50EQ4S3 "RecipientView UITableViewCell Demo")

Installation
------------
The easiest way to get started is to use [CocoaPods](http://cocoapods.org/). Just add the following line to your Podfile:

```ruby
pod 'VENSeparatorView', '~> 1.0.0'
```

General Usage
-------------

Import ```VENSeparatorView.h```ls

Create an instance of UISeparatorView or a UISeparatorView subclass using its ```initWithFrame:topLineSeparatorType:bottomLineSeparatorType``` instantitator and add it as a subview.

VENSeparatorType options are 
```
VENSeparatorTypeStraight,
VENSeparatorTypeJagged,
VENSeparatorTypeNone
```

UITableViewCell Usage
---------------------

Making jagged cells in a UITableView is simple using the included VENSeparatorTableViewCellProvider

Import ```#import "VENSeparatorTableViewCellProvider.h"``` in your UITableViewDataSource and conform this class to the ```VENSeparatorTableViewCellProviderDelegate``` protocol ```isCellJaggedAtIndexPath:``` method. 

Example
```
// Specifies that all cells with odd row index are jagged.
- (BOOL)isCellJaggedAtIndexPath:(NSIndexPath *)indexPath
{
	return (indexPath.row % 2);
}
```

Set your UITableView's ``separatorStyle``` property to ```UITableViewCellSeparatorStyleNone```

Create a ```VENSeparatorTableViewCellProvider``` property:
```
@property (nonatomic, strong) VENSeparatorTableViewCellProvider *separatorProvider;
```
In this class's ```init``` method or in the ```viewDidLoad``` method if this class is a UIViewController subclass instantiate the ```VENSeparatorTableViewCellProvider``` property using its ```initWithStrokeColor:fillColor:delegate:``` method.
```
    self.separatorProvider = [[VENSeparatorTableViewCellProvider alloc] initWithStrokeColor:[UIColor grayColor]
                                                                                  fillColor:[UIColor lightGrayColor]
                                                                                   delegate:self];
```

At the end of your data source's ```tableView:cellForRowAtIndexPath:``` apply separators to the UITableViewCell with the ```VENSeparatorTableViewCellProvider```'s ```applySeparatorsToCell:atIndexPath:inTableView:height:``` 

```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// ...
	// Instantiate/format a table view cell
    [self.separatorProvider applySeparatorsToCell:cell atIndexPath:indexPath inTableView:tableView height:0];
    return cell;
}
```
