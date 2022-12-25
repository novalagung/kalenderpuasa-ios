//
//  AppDelegate.m
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 1/9/14.
//  Copyright (c) 2014 Noval Agung Prayogo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Constant.h"
#import "NVDate.h"

@import FirebaseCore;

@implementation AppDelegate {
    int spaceToNextFasting;
    BOOL wasInactive;
    
    EKEventStore *eventStore;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];

    return YES;
}
                            
- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    wasInactive = YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    wasInactive = NO;
    
    @try {
        [(ViewController *)self.window.rootViewController prepareForCurrentDay];
    } @catch (NSException *exception) {
        NSLog(@"error adding current day sign %@", exception);
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (void)authorizeCalendarEvent:(BOOL(^)(void))callback {
    if (!eventStore) {
        eventStore = [[EKEventStore alloc] init];
    }
    
    EKAuthorizationStatus authorizationStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    switch (authorizationStatus) {
        case EKAuthorizationStatusDenied:
        case EKAuthorizationStatusRestricted:
            break;
            
        case EKAuthorizationStatusAuthorized:
            callback();
            break;
            
        case EKAuthorizationStatusNotDetermined: {
            [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) {
                        callback();
                    }
                });
            }];
            break;
        }
    }
}

- (void)authorizeNotification:(BOOL(^)(void))callback {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center removeAllPendingNotificationRequests];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            switch ([settings authorizationStatus]) {
                case UNAuthorizationStatusAuthorized:{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        callback();
                    });
                } break;
                    
                case UNAuthorizationStatusDenied:
                    break;
                    
                case UNAuthorizationStatusNotDetermined: {
                    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"message"
                                                                                              actions:@[]
                                                                                    intentIdentifiers:@[]
                                                                                              options:UNNotificationCategoryOptionCustomDismissAction];
                    [center setNotificationCategories:[NSSet setWithObject:category]];
                    [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
                        NSLog(@"========== UNNotification allowed");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            callback();
                        });
                    }];
                } break;
                case UNAuthorizationStatusProvisional:
                    break;
                case UNAuthorizationStatusEphemeral:
                    break;
            }
        }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] cancelAllLocalNotifications];
            callback();
        });
    }
}

- (void)prepareIOSCalendarEvent:(NSArray *)fastDateAll {
    if (eventStore == nil) {
        eventStore = [[EKEventStore alloc] init];
    }
    
    [self authorizeCalendarEvent:^BOOL{
        
        EKSource *localSource = nil;
        for (EKSource *source in self->eventStore.sources) {
            NSLog(@"========= found source %@", source.title);
            
            if (source.sourceType == EKSourceTypeCalDAV && [source.title isEqualToString:@"iCloud"]) {
                localSource = source;
                break;
            }
            if (source.sourceType == EKSourceTypeLocal) {
                localSource = source;
                break;
            }
        }
        
        if (!localSource) {
            return false;
        }
        
        NSString *calendarPrefix = @"Kalender Puasa";
        NSString *calendarTitle = [NSString stringWithFormat:@"%@ %d", calendarPrefix, [Constant getCurrentYear]];
        EKCalendar *calendarForEvent = nil;
        
        BOOL shouldInitiateNewCalendar = false;
        NSString *calendarIdentifier = [[NSUserDefaults standardUserDefaults] stringForKey:calendarTitle];
        if (calendarIdentifier == NULL) {
            shouldInitiateNewCalendar = true;
        } else {
            calendarForEvent = [self->eventStore calendarWithIdentifier:calendarIdentifier];
            if (calendarForEvent == NULL) {
                shouldInitiateNewCalendar = true;
            }
        }
        
        if (shouldInitiateNewCalendar) {
            for (EKCalendar *each in [self->eventStore calendarsForEntityType:EKEntityTypeEvent]) {
                if ([each.title containsString:calendarPrefix]) {
                    NSLog(@"========= deleting old calendar with identifier %@, name %@", each.calendarIdentifier, each.title);
                    NSError *err = nil;
                    [self->eventStore removeCalendar:each commit:true error:&err];
                    
                    if (err != nil) {
                        NSLog(@"========= delete calendar error: %@", err.localizedDescription);
                    }
                }
            }
            
            calendarForEvent = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:self->eventStore];
            calendarForEvent.title = calendarTitle;
            calendarForEvent.source = localSource;
            
            NSLog(@"========= insert new calendar with identifier %@", calendarForEvent.calendarIdentifier);
            NSError *err = nil;
            [self->eventStore saveCalendar:calendarForEvent commit:true error:&err];
            
            if (err != nil) {
                NSLog(@"========= save calendar error: %@", err.localizedDescription);
            } else {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setValue:calendarForEvent.calendarIdentifier forKey:calendarForEvent.title];
                [userDefaults synchronize];
            }
        } else {
            calendarForEvent = [self->eventStore calendarWithIdentifier:calendarIdentifier];
            NSLog(@"========= reuse old calendar with identifier %@", calendarForEvent.calendarIdentifier);
            
            // only set once
            return false;
        }
        
//        NSDate *startDate = [[NVDate alloc] initUsingYear:[NVDate new].year month:1 day:1].date;
//        NSDate *endDate = [[NVDate alloc] initUsingYear:[NVDate new].year + 1 month:1 day:1].previousDay.date;
//        NSPredicate *predicateEvents = [eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:[NSArray arrayWithObjects:calendarForEvent, nil]];
//        for (EKEvent *event in [eventStore eventsMatchingPredicate:predicateEvents]) {
//            NSLog(@"========= found event: %@", event.title);
//
//            NSError *err = nil;
//            [eventStore removeEvent:event span:EKSpanThisEvent error:&err];
////            [eventStore removeEvent:event span:EKSpanFutureEvents commit:true error:&err];
//            if (err != nil) {
//                NSLog(@"========= remove event error: %@", err.localizedDescription);
//            }
//        }
        
        NVDate *currentDate = [[NVDate alloc] initUsingToday];
        
        for (NSDictionary *fastDate in fastDateAll) {
            NSString *monthName = [fastDate valueForKey:@"monthName"];
            NSString *dayName = [fastDate valueForKey:@"dayName"];
            int month = [[fastDate valueForKey:@"month"] intValue];
            int day = [[fastDate valueForKey:@"day"] intValue];
            NVDate *dueDate = [[NVDate alloc] initUsingYear:[Constant getCurrentYear] month:month day:day hour:0 minute:0 second:0];
            
            NSComparisonResult dateComparison = [dueDate.date compare:currentDate.date];
            if (dateComparison == NSOrderedAscending || dateComparison == NSOrderedSame) continue;
            
            NSString *whatFast;
            if ([[fastDate valueForKey:@"fastingName"] isEqualToString:@"Haram Berpuasa"]) {
                whatFast = @"Diharamkan Berpuasa";
            } else if ([[fastDate valueForKey:@"fastingName"] isEqualToString:@"Puasa Ramadhan"]) {
                whatFast = @"Diwajibkan Berpuasa Ramadhan";
            } else {
                whatFast = [NSString stringWithFormat:@"Disunnahkan %@", [[fastDate valueForKey:@"fastingName"] stringByReplacingOccurrencesOfString:@"Puasa" withString:@"Berpuasa"]];
            }
            NSString *message = [NSString stringWithFormat:@"%@, pada %@ tanggal %d %@ %d.\n\nSilakan ikuti waktu lokal subuh dan maghrib masing-masing, untuk mengetahui detail kapan puasa dimulai dan berakhir", whatFast, dayName, day, monthName, [Constant getCurrentYear]];
            
            NVDate *dueDateStart = [[NVDate alloc] initUsingDate:dueDate.date];
            [dueDateStart setHour:3];
            
            NVDate *dueDateLast = [[NVDate alloc] initUsingDate:dueDate.date];
            [dueDateLast setHour:18];
            
            EKEvent *event = [EKEvent eventWithEventStore:self->eventStore];
            event.calendar = calendarForEvent;
            event.title = message;
            event.startDate = dueDateStart.date;
            event.endDate = dueDateLast.date;
            event.allDay = false;
//
//            NVDate *alarmDateLast2DaysMorning = [[[NVDate alloc] initUsingDate:dueDate.date] previousDays:2];
//            [alarmDateLast2DaysMorning setHour:9];
//            [event addAlarm:[EKAlarm alarmWithAbsoluteDate:alarmDateLast2DaysMorning.date]];
//
//            NVDate *alarmDateLast2DaysAfternoon = [[[NVDate alloc] initUsingDate:dueDate.date] previousDays:2];
//            [alarmDateLast2DaysAfternoon setHour:15];
//            [event addAlarm:[EKAlarm alarmWithAbsoluteDate:alarmDateLast2DaysAfternoon.date]];
//
//            NVDate *alarmDateLast2DaysEvening = [[[NVDate alloc] initUsingDate:dueDate.date] previousDays:2];
//            [alarmDateLast2DaysEvening setHour:20];
//            [event addAlarm:[EKAlarm alarmWithAbsoluteDate:alarmDateLast2DaysEvening.date]];

            NVDate *alarmDateLast1DaysMorning = [[[NVDate alloc] initUsingDate:dueDate.date] previousDays:1];
            [alarmDateLast1DaysMorning setHour:9];
            [event addAlarm:[EKAlarm alarmWithAbsoluteDate:alarmDateLast1DaysMorning.date]];
//
//            NVDate *alarmDateLast1DaysAfternoon = [[[NVDate alloc] initUsingDate:dueDate.date] previousDays:1];
//            [alarmDateLast1DaysAfternoon setHour:15];
//            [event addAlarm:[EKAlarm alarmWithAbsoluteDate:alarmDateLast1DaysAfternoon.date]];

            NVDate *alarmDateLast1DaysEvening = [[[NVDate alloc] initUsingDate:dueDate.date] previousDays:1];
            [alarmDateLast1DaysEvening setHour:20];
            [event addAlarm:[EKAlarm alarmWithAbsoluteDate:alarmDateLast1DaysEvening.date]];
            
            NSError *err = nil;
            [self->eventStore saveEvent:event span:EKSpanThisEvent error:&err];
//            NSLog(@"========= save event: %@", event.title);
//            if (err != nil) {
//                NSLog(@"========= save event error: %@", err.localizedDescription);
//            }
        }
        
        NSError *err = nil;
        [self->eventStore commit:&err];
//        NSLog(@"========= commit store");
//        if (err != nil) {
//            NSLog(@"========= commit store error: %@", err.localizedDescription);
//        }
        
        return false;
    }];
}

- (void)prepareIOSFastingNotification:(NSArray *)fastDateAll {
    
    [self authorizeNotification:^BOOL{
        
        NVDate *currentDate = [[NVDate alloc] initUsingToday];
        
        for (NSDictionary *fastDate in fastDateAll) {
            int month = [[fastDate valueForKey:@"month"] intValue];
            int day = [[fastDate valueForKey:@"day"] intValue];
            NVDate *nvDate = [[NVDate alloc] initUsingYear:[Constant getCurrentYear] month:month day:day hour:23 minute:59 second:59];
            [nvDate previousDay];
            
            NSComparisonResult dateComparison = [nvDate.date compare:currentDate.date];
            if (dateComparison == NSOrderedAscending || dateComparison == NSOrderedSame) continue;
            
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *componentsForFireDate = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:nvDate.date];
            
            [componentsForFireDate setHour:10];
            [self scheduledNotificationAt:[calendar dateFromComponents:componentsForFireDate] withData:fastDate];
            
//            [componentsForFireDate setHour:19];
//            [self scheduledNotificationAt:[calendar dateFromComponents:componentsForFireDate] withData:fastDate];
            
            break;
        }
        
        for (UILocalNotification *each in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
            NSLog(@"--------> scheduled notifications : %@ | %@", each, each.alertBody);
        }
        
        return true;
    }];
}

- (void)scheduledNotificationAt:(NSDate *)date withData:(NSDictionary *)nextFasting {
    NSString *whatFast;
    
    if ([[nextFasting valueForKey:@"fastingName"] isEqualToString:@"Haram Berpuasa"]) {
        whatFast = @"diharamkan untuk Berpuasa";
    } else if ([[nextFasting valueForKey:@"fastingName"] isEqualToString:@"Puasa Ramadhan"]) {
        whatFast = @"diwajibkan untuk berpuasa Ramadhan";
    } else {
        whatFast = [NSString stringWithFormat:@"disunnahkan untuk %@", [[nextFasting valueForKey:@"fastingName"] stringByReplacingOccurrencesOfString:@"Puasa" withString:@"berpuasa"]];
    }
    
    NSString *message = [NSString stringWithFormat:@"Reminder: Besuk hari %@ tanggal %d %@ %d %@", [nextFasting valueForKey:@"dayName"], [[nextFasting valueForKey:@"day"] intValue], [nextFasting valueForKey:@"monthName"], [Constant getCurrentYear], whatFast];
    
    // hack, test notification now
    date = [[[NSDate alloc] init] dateByAddingTimeInterval:5];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.body = message;
        content.categoryIdentifier = @"message";
        content.sound = [UNNotificationSound defaultSound];
        
        NSDateComponents *dateMatching = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateMatching repeats:false];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:[[NSUUID UUID] UUIDString] content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"--------- %@ %@", message, date);
        }];
    } else {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = date;
        notification.timeZone = [NSTimeZone localTimeZone];
        notification.repeatInterval = NSCalendarUnitEra;
        notification.soundName = UILocalNotificationDefaultSoundName;
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.2")) {
            notification.alertTitle = @"Reminder Puasa";
            notification.alertBody = message;
        } else {
            notification.alertBody = message;
        }
        
        NSLog(@"--------- %@ %@", message, date);
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    
}

@end
