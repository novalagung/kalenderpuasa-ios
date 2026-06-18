//
//  MonthPickerViewController.m
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 1/11/14.
//  Copyright (c) 2014 Noval Agung Prayogo. All rights reserved.
//

#import "UIColor+Extends.h"
#import "UIDevice+Extends.h"
#import "Localizer.h"
#import "MonthPickerViewController.h"

@interface MonthPickerViewController () {
    NSArray *_monthsBaseColor;
    IBOutlet UIView *_monthsContainer;
}

@end

@implementation MonthPickerViewController

@synthesize monthsBaseColor = _monthsBaseColor;
@synthesize delegate = _delegate;

- (NSArray *)localizedMonthShortNames {
    NSArray *monthKeys = @[
        @"month_january",
        @"month_february",
        @"month_march",
        @"month_april",
        @"month_may",
        @"month_june",
        @"month_july",
        @"month_august",
        @"month_september",
        @"month_october",
        @"month_november",
        @"month_december"
    ];
    
    NSMutableArray *shortNames = [NSMutableArray arrayWithCapacity:monthKeys.count];
    for (NSString *key in monthKeys) {
        NSString *monthName = [Localizer string:key];
        NSUInteger length = MIN((NSUInteger)3, monthName.length);
        [shortNames addObject:[monthName substringToIndex:length]];
    }
    
    return shortNames;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([UIDevice isIPad]) {
        _monthsContainer.layer.cornerRadius = 10.;
        _monthsContainer.clipsToBounds = YES;
    }
    
    NSArray *monthShortNames = [self localizedMonthShortNames];
    for (int i = 0; i < 12; i++) {
        UIButton *button = _monthsContainer.subviews[i];
        button.backgroundColor = [UIColor withHexString:_monthsBaseColor[i]];
        button.tag = i;
        [button setTitle:monthShortNames[i] forState:UIControlStateNormal];
        [button setTitle:monthShortNames[i] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(doTouchDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(doTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(doTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)doDismissModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doTouchDown:(UIButton *)sender {
    sender.backgroundColor = [UIColor withHexString:_monthsBaseColor[sender.tag] andAlpha:.8];
}

- (void)doTouchUpInside:(UIButton *)sender {
    sender.backgroundColor = [UIColor withHexString:_monthsBaseColor[sender.tag] andAlpha:1.];
    [_delegate doPickMonthAtIndex:sender.tag];
}

- (void)doTouchUpOutside:(UIButton *)sender {
    sender.backgroundColor = [UIColor withHexString:_monthsBaseColor[sender.tag] andAlpha:1.];
}

@end
