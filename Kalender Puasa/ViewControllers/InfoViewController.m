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
#import "Localizer.h"
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
    
    _authorLabel.text = [Localizer string:@"info_developed_by"];
    [_btnFeedback setTitle:[Localizer string:@"info_feedback_button"] forState:UIControlStateNormal];
    [_btnFeedback setTitle:[Localizer string:@"info_feedback_button"] forState:UIControlStateHighlighted];
    [_btnShare setTitle:[Localizer string:@"info_share_button"] forState:UIControlStateNormal];
    [_btnShare setTitle:[Localizer string:@"info_share_button"] forState:UIControlStateHighlighted];
    _copyright.text = [NSString stringWithFormat:[Localizer string:@"info_copyright_format"], [Constant getCurrentYear]];
    
    _container.backgroundColor = [UIColor withHexString:@"ffffff"];
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
    NSString *caption = [Localizer string:@"share_caption"];
    
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
    [mail setSubject:[Localizer string:@"feedback_email_subject"]];
    [mail setMessageBody:@"" isHTML:NO];
    [mail setToRecipients:[NSArray arrayWithObject:@"hello@novalagung.com"]];
    
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
            message = [Localizer string:@"email_sent_message"];
            NSLog(@"Email berhasil dikirim");
            break;
        case MFMailComposeResultFailed:
            message = [Localizer string:@"email_failed_message"];
            NSLog(@"Email gagal dikirim: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    if (message) [[[UIAlertView alloc] initWithTitle:[Localizer string:@"notification_title"] message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
