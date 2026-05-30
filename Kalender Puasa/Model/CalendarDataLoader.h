//
//  CalendarDataLoader.h
//  Kalender Puasa
//

#import <Foundation/Foundation.h>

@interface CalendarDataLoader : NSObject

+ (NSDictionary *)calendarDataForYear:(int)year;
+ (NSDictionary *)methodDataForYear:(int)year methodId:(NSString *)methodId;
+ (NSString *)selectedMethodIdForYear:(int)year;
+ (NSArray *)availableMethodIdsForYear:(int)year;

@end
