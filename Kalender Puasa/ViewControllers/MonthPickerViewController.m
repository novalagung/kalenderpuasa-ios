//
//  MonthPickerViewController.m
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 1/11/14.
//  Copyright (c) 2014 Noval Agung Prayogo. All rights reserved.
//

#import "UIColor+Extends.h"
#import "UIDevice+Extends.h"
#import "MonthPickerViewController.h"

@interface MonthPickerViewController () {
    NSArray *_monthsBaseColor;
    IBOutlet UIView *_monthsContainer;
}

@end

@implementation MonthPickerViewController

@synthesize monthsBaseColor = _monthsBaseColor;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareButtons];
    
    if ([UIDevice isIPad]) {
        _monthsContainer.layer.cornerRadius = 10.;
        _monthsContainer.clipsToBounds = YES;
    }
}

- (void)prepareButtons {
    for (int i = 0; i < 12; i++) {
        UIButton *button = _monthsContainer.subviews[i];
        button.backgroundColor = [UIColor withHexString:_monthsBaseColor[i]];
        button.tag = i;
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
