//
//  CalendarDataLoader.m
//  Kalender Puasa
//

#import "CalendarDataLoader.h"

@implementation CalendarDataLoader

static NSString *hijriMethodKey = @"hijri_method";

+ (NSDictionary *)calendarDataForYear:(int)year {
    static NSMutableDictionary *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [NSMutableDictionary dictionary];
    });
    
    NSString *yearKey = [@(year) stringValue];
    NSDictionary *cachedData = cache[yearKey];
    if (cachedData) {
        return cachedData;
    }
    
    NSString *path = [NSBundle.mainBundle pathForResource:yearKey ofType:@"json" inDirectory:@"Data/calendar"];
    if (path.length == 0) {
        path = [NSBundle.mainBundle pathForResource:yearKey ofType:@"json"];
    }
    if (path.length == 0) {
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data) {
        return nil;
    }
    
    NSError *error = nil;
    NSDictionary *calendarData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error || ![calendarData isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    cache[yearKey] = calendarData;
    return calendarData;
}

+ (NSArray *)availableMethodIdsForYear:(int)year {
    NSArray *availableMethods = [[self calendarDataForYear:year] valueForKey:@"availableMethods"];
    return [availableMethods isKindOfClass:[NSArray class]] ? availableMethods : @[];
}

+ (NSString *)selectedMethodIdForYear:(int)year {
    NSDictionary *calendarData = [self calendarDataForYear:year];
    NSString *selectedMethodId = [NSUserDefaults.standardUserDefaults stringForKey:hijriMethodKey];
    NSArray *availableMethods = [self availableMethodIdsForYear:year];
    
    if (selectedMethodId.length > 0 && [availableMethods containsObject:selectedMethodId]) {
        return selectedMethodId;
    }
    
    NSString *defaultMethod = [calendarData valueForKey:@"defaultMethod"];
    if (defaultMethod.length > 0) {
        return defaultMethod;
    }
    
    return availableMethods.firstObject ?: @"kemenag";
}

+ (NSDictionary *)methodDataForYear:(int)year methodId:(NSString *)methodId {
    NSDictionary *calendarData = [self calendarDataForYear:year];
    NSDictionary *methods = [calendarData valueForKey:@"methods"];
    if (![methods isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSString *resolvedMethodId = methodId.length > 0 ? methodId : [self selectedMethodIdForYear:year];
    NSDictionary *methodData = [methods valueForKey:resolvedMethodId];
    return [methodData isKindOfClass:[NSDictionary class]] ? methodData : nil;
}

@end
