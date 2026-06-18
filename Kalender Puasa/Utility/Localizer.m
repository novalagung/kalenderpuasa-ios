//
//  Localizer.m
//  Kalender Puasa
//

#import "Localizer.h"

@implementation Localizer

static NSString *appLanguageKey = @"app_language";
static NSString *defaultLanguageCode = @"id";

+ (NSString *)currentLanguageCode {
    NSString *languageCode = [NSUserDefaults.standardUserDefaults stringForKey:appLanguageKey];
    if (languageCode.length > 0) {
        return languageCode;
    }
    
    return defaultLanguageCode;
}

+ (void)setCurrentLanguageCode:(NSString *)languageCode {
    [NSUserDefaults.standardUserDefaults setObject:languageCode forKey:appLanguageKey];
    [NSUserDefaults.standardUserDefaults synchronize];
}

+ (NSArray<NSDictionary *> *)availableLanguages {
    return @[
        @{@"code": @"id", @"titleKey": @"language_name_indonesian"},
        @{@"code": @"en", @"titleKey": @"language_name_english"}
    ];
}

+ (NSBundle *)bundleForLanguageCode:(NSString *)languageCode {
    NSString *path = [NSBundle.mainBundle pathForResource:languageCode ofType:@"lproj"];
    if (path.length == 0) {
        path = [NSBundle.mainBundle pathForResource:defaultLanguageCode ofType:@"lproj"];
    }
    
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    return bundle ?: NSBundle.mainBundle;
}

+ (NSString *)string:(NSString *)key {
    if (key.length == 0) {
        return @"";
    }
    
    NSBundle *bundle = [self bundleForLanguageCode:[self currentLanguageCode]];
    NSString *value = [bundle localizedStringForKey:key value:nil table:nil];
    if (value.length > 0 && ![value isEqualToString:key]) {
        return value;
    }
    
    NSBundle *fallbackBundle = [self bundleForLanguageCode:defaultLanguageCode];
    value = [fallbackBundle localizedStringForKey:key value:key table:nil];
    return value ?: key;
}

@end
