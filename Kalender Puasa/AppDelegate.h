//
//  AppDelegate.h
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 1/9/14.
//  Copyright (c) 2014 Noval Agung Prayogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)prepareIOSFastingNotification:(NSArray *)fastDateAll;
- (void)prepareIOSCalendarEvent:(NSArray *)fastDateAll;

@end
