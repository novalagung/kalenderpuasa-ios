//
//  ViewController.h
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 1/9/14.
//  Copyright (c) 2014 Noval Agung Prayogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateHelper.h"

@interface ViewController : UIViewController

- (void)prepareForCurrentDay;
- (void)prepareCalendarView;
- (void)prepareBanner;
- (BOOL)isAdLoaded;

@property (nonatomic, strong) NSMutableArray *fastDateAll;

@end
