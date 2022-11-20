//
//  MonthPickerViewController.h
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 1/11/14.
//  Copyright (c) 2014 Noval Agung Prayogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MonthPickerDelegate <NSObject>

- (void)doPickMonthAtIndex:(int)index;

@end

@interface MonthPickerViewController : UIViewController

@property (strong, nonatomic) NSArray *monthsBaseColor;
@property (assign, nonatomic) id<MonthPickerDelegate> delegate;

- (void)prepareButtons;

@end
