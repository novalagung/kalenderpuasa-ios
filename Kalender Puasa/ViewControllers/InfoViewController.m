//
//  InfoViewController.m
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 1/12/14.
//  Copyright (c) 2014 Noval Agung Prayogo. All rights reserved.
//

#import "InfoViewController.h"
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>
#import "Constant.h"
#import "UIColor+Extends.h"

@interface InfoViewController ()<MFMailComposeViewControllerDelegate> {
    IBOutlet UIView *_container;
    IBOutlet UIButton *_btnShare;
    IBOutlet UIButton *_btnFeedback;
    IBOutlet UILabel *_authorLabel;
    IBOutlet UILabel *_author;
    IBOutlet UILabel *_copyright;
    
    UIPopoverController *_popover;
}

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _copyright.text = [NSString stringWithFormat:@"© %d - Kalender Puasa", [Constant getCurrentYear]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _container.backgroundColor = [UIColor withHexString:@"f1f2f4"];
    _btnShare.backgroundColor = [UIColor withHexString:@"1aa8e0"];
    _btnFeedback.backgroundColor = [UIColor withHexString:@"95c73f"];
    
    _container.layer.cornerRadius = 10.;
    
    _author.textColor = [UIColor withHexString:@"454744"];
    _authorLabel.textColor = [UIColor withHexString:@"454744"];
    _copyright.backgroundColor = [UIColor withHexString:@"303030"];
}

- (IBAction)doTouchDown:(UIButton *)sender {
    sender.backgroundColor = [UIColor withHexString:(sender == _btnShare ? @"1f8fce" : @"75b743")];
}

- (IBAction)doTouchUpInside:(UIButton *)sender {
    sender.backgroundColor = [UIColor withHexString:(sender == _btnShare ? @"1aa8e0" : @"95c73f")];
}

- (IBAction)doTouchUpOutside:(UIButton *)sender {
    sender.backgroundColor = [UIColor withHexString:(sender == _btnShare ? @"1aa8e0" : @"95c73f")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)doDismissModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doShare:(id)sender {
    UIImage *image = [UIImage imageNamed:@"logo-front.png"];
    NSString *caption = [NSString stringWithFormat:@"%@ %@", @"Aplikasi iPhone & iPad Kalender Puasa\n", @"https://itunes.apple.com/us/app/kalender-puasa/id796222919?ls=1&mt=8"];
    
    UIActivityViewController *sharer = [[UIActivityViewController alloc] initWithActivityItems:@[image, caption] applicationActivities:nil];
    
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        [self presentViewController:sharer animated:YES completion:nil];
    } else {
        CGRect rect = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.width/2, 100, 100);
         _popover = [[UIPopoverController alloc] initWithContentViewController:sharer];
        [_popover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

- (IBAction)doFeedback:(id)sender {
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
    
    [mail setMailComposeDelegate:self];
    [mail setSubject:@"Feedback Kalender Puasa"];
    [mail setMessageBody:@"" isHTML:NO];
    [mail setToRecipients:[NSArray arrayWithObject:@"caknopal@gmail.com"]];
    
    if (MFMailComposeViewController.canSendMail) {
        [self presentViewController:mail animated:YES completion:NULL];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    NSString *message = nil;
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Email cancel");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Email disimpan");
            break;
        case MFMailComposeResultSent:
            message = @"Email berhasil dikirim !";
            NSLog(@"Email berhasil dikirim");
            break;
        case MFMailComposeResultFailed:
            message = @"Email gagal dikirim !";
            NSLog(@"Email gagal dikirim: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    if (message) [[[UIAlertView alloc] initWithTitle:@"Notifikasi" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
