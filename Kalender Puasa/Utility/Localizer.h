//
//  Localizer.h
//  Kalender Puasa
//

#import <Foundation/Foundation.h>

@interface Localizer : NSObject

+ (NSString *)currentLanguageCode;
+ (void)setCurrentLanguageCode:(NSString *)languageCode;
+ (NSArray<NSDictionary *> *)availableLanguages;
+ (NSString *)string:(NSString *)key;

@end
