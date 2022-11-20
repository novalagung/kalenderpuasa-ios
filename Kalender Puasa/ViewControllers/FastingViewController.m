//
//  FastingViewController.m
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 1/14/14.
//  Copyright (c) 2014 Noval Agung Prayogo. All rights reserved.
//

#import "UIColor+Extends.h"
#import "FastingViewController.h"

@interface FastingViewController () {
    NSArray *_colors;
    IBOutlet UIView *_toolbarViewContent;
    IBOutlet UIView *_toolbarView;
    IBOutlet UIView *_toolbarBorder;
    IBOutlet UIView *_toolbarFastingOther;
    IBOutlet UIView *_toolbarNote;
}

@end

@implementation FastingViewController

@synthesize colors = _colors;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _toolbarView.frame = CGRectMake(0, self.view.frame.size.height - 50, 320, 486);
    _toolbarViewContent.backgroundColor = [UIColor withHexString:@"f2f2f2"];
    
    _toolbarBorder.backgroundColor = [UIColor withHexString:@"454744"];
    _toolbarFastingOther.backgroundColor = [UIColor withHexString:@"f2f2f2"];
    _toolbarNote.backgroundColor = [UIColor withHexString:@"454744"];
    
    _toolbarView.layer.cornerRadius = 10.;
    _toolbarView.clipsToBounds = YES;
    
    int i = 0;
    
    for (UIView *view in [_toolbarViewContent subviews]) {
        if (i >= 6) return;
        
        UIView *cover = [view.subviews objectAtIndex:0];
        cover.backgroundColor = [UIColor withHexString:_colors[i]];
        
        UILabel *text = [view.subviews objectAtIndex:1];
        text.textColor = [UIColor withHexString:_colors[i++]];
        
        UIView *eachCover = view.subviews.firstObject;
        eachCover.layer.cornerRadius = 4.;
        eachCover.clipsToBounds = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)doDismissModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
