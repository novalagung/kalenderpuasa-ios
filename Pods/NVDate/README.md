Introduction
======

[![Version](http://img.shields.io/cocoapods/v/NVDate.svg)](http://cocoadocs.org/docsets/NVDate)

__NVDate__ is an extension of `NSDate` class, created to make date and time manipulation easier.

Features
======

* Has lot of API function to make date and time manipulation easier and fun
* Has user friendly naming convention
* NVDate functions are _chainable_
* Very easy to use
* Open Source!

Installation
======

### Using Cocoa Pods

Add these into your `Podfile` :

```ruby
pod 'NVDate', '1.0.0'
```

### Manual Installation

[Download](https://github.com/novalagung/NVDate/archive/master.zip) NVDate source code, then add into your project.

Copy both `NVDate.h` and `NVDate.m` files into your project. Then import `NVDate.h`.
   
```objectivec
#import "NVDate.h"
```

For swift user, import `NVDate.h` into your bridging header file.

Simple Example
======
    
### Full date of today

##### Objective-C

```objectivec
NVDate *date = [[NVDate alloc] initUsingToday];
 
NSLog(@"today is : %@", [date stringValue]);
// today is : Wednesday, February 5, 2014, 4:56:35 PM Western Indonesia Time
```

##### Swift

```swift
let date = NVDate(isUsingToday: true)

NSLog("today is : %@", date.stringValue());
// today is : Wednesday, February 5, 2014, 4:56:35 PM Western Indonesia Time
```

### Last day of next 2 months

##### Objective-C

```objectivec
NVDate *date = [[NVDate alloc] initUsingToday];
[date nextMonths:2];
[date lastDayOfMonth];

NSLog(@"next 2 months from today is : %@", [date stringValueWithFormat:@"dd-MM-yyyy"]);
// next 2 months from today is : 30-04-2014
```

##### Swift

```swift
var date = NVDate(isUsingToday: true)
date.nextMonths(2);
date.lastDayOfMonth(2);

NSLog("next 2 months from today is : %@", date.stringValue(dateFormat: "dd-MM-yyyy"));
// next 2 months from today is : 30-04-2014
```

### Second week of 2 months ago

##### Objective-C

```objectivec
NVDate *date = [[[[[NVDate alloc] initUsingToday] previousMonths:2] firstDayOfMonth] nextWeek];
date.dateFormatUsingString = @"yyyy-MM-dd HH:mm:ss";

NSLog(@"second week of 2 months ago is : %@", [date stringValue]);
// second week of 2 months ago is : 2013-12-08 17:03:36
```

##### Swift

```swift
var date = NVDate(isUsingToday: true).previousMonths(2).firstDayOfMonth().nextWeek()
date.dateFormatUsingString = "yyyy-MM-dd HH:mm:ss";

NSLog("second week of 2 months ago is : %@", date.stringValue());
// second week of 2 months ago is : 2013-12-08 17:03:36
```

### Detect if yesterday is friday

##### Objective-C

```objectivec
BOOL isFriday = [[[[NVDate alloc] initUsingToday] previousDay] isCurrentDayName:NVDayUnitFriday];

NSLog(@"is yesterday was friday ? %@", isFriday ? @"yes" : @"no");
// is yesterday was friday ? no
```

##### Swift

```swift
Bool isFriday = NVDate(isUsingToday: true).previousDay().isCurrentDayName(.Friday)

NSLog("is yesterday was friday ? %@", isFriday ? "yes" : "no");
// is yesterday was friday ? no
```

### Dot syntax

##### Objective-C

```objectivec
NVDate *nvDate = [[NVDate alloc] initUsingToday];
NSString someday = nvDate.previousDay.previousWeek.nextDay.stringValue;

NSLog(@"someday %@", someday);
// someday 2013-12-08 17:03:36
```

##### Swift

```swift
var nvDate = NVDate(isUsingToday: true);
String someday = nvDate.previousDay().previousWeek().nextDay().stringValue();

NSLog(@"someday %@", someday);
// someday 2013-12-08 17:03:36
```

Documentation
======

[https://github.com/novalagung/NVDate/wiki/API-Reference](https://github.com/novalagung/NVDate/wiki/API-Reference)


Contribution
======

Feel free to add contribution to this project by `fork` -> `pull request`


License
======

http://novalagung.mit-license.org/
