//
//  sdmSheetsAndAlerts.m
//  SheetsAndAlerts
//
//  Created by Peter JC Spencer on 18/08/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import "sdmSheetsAndAlerts.h"


@interface NSDictionary (LocalizedKey)

// Reading utility.
- (NSString *)localizedStringForKey:(NSString *)key;

@end


@interface sdmSheetsAndAlerts()

// Json utility.
+ (id)objectForKey:(NSString *)key
           ofClass:(Class)class
     fromJSONNamed:(NSString *)name;

@end





@implementation NSDictionary (LocalizedKey)


#pragma mark - Reading Utility

- (NSString *)localizedStringForKey:(NSString *)key
{
    id object = self[key];
    
    if ([object isKindOfClass:[NSString class]])
        return NSLocalizedString((NSString *)object, @":(");
    
    return nil;
}


@end


@implementation sdmSheetsAndAlerts


#pragma mark - Json Utility

+ (id)objectForKey:(NSString *)key
           ofClass:(Class)class
     fromJSONNamed:(NSString *)name
{
    NSDictionary *result = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:kJSON];
    NSError *error = nil;
    NSString *string = [[NSString alloc] initWithContentsOfFile:path
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
    NSAssert(string, @"Failed to instanciate string: %@.", path);
    
    if (!error)
    {
        NSDictionary *data = nil;
        data = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding]
                                               options:NSJSONReadingMutableContainers
                                                 error:&error];
        NSAssert(data, @"Failed to serialize json: %@.", data);
        
        result = data[key];
        NSAssert([result isKindOfClass:class], @"Failed to associate value: %@.", key);
    }
    
    return result;
}


#pragma mark - ActionSheet Support

+ (void)showSheetNamed:(NSString *)name
                inView:(UIView *)view
           forDelegate:(id<UIActionSheetDelegate>)delegate
{
    NSDictionary *sheet = [sdmSheetsAndAlerts objectForKey:name
                                                   ofClass:[NSDictionary class]
                                             fromJSONNamed:@"ActionSheet"];
    if (sheet)
    {
        NSArray *otherButtonTitles = (sheet[kOtherButtonTitles] != [NSNull null]
                                      ? (NSArray *)sheet[kOtherButtonTitles]
                                      : nil); // TODO: Validate content ...
        
        UIActionSheet *actionSheet = nil;
        actionSheet = [[UIActionSheet alloc] initWithTitle:[sheet localizedStringForKey:kTitle]
                                                  delegate:delegate
                                         cancelButtonTitle:[sheet localizedStringForKey:kCancelButtonTitle]
                                    destructiveButtonTitle:[sheet localizedStringForKey:kDestructiveButtonTitle]
                                         otherButtonTitles:nil];
        
        for (NSString *key in otherButtonTitles)
            [actionSheet addButtonWithTitle:NSLocalizedString(key, @":(")];
        
        [actionSheet showInView:(view ? view : [UIApplication sharedApplication].keyWindow)];
    }
}


#pragma mark - Custom AlertView Support

+ (void)showCustomAlertNamed:(NSString *)name
                 forDelegate:(id<sdmCustomAlertViewDelegate>)delegate
{
    NSDictionary *sheet = [sdmSheetsAndAlerts objectForKey:name
                                                   ofClass:NSClassFromString(@"NSDictionary")
                                             fromJSONNamed:@"AlertView"];
    if (sheet)
    {
        UIImage *image = (sheet[kImage] != [NSNull null]
                          ? [UIImage imageNamed:(NSString *)sheet[kImage]]
                          : nil);
        
        sdmCustomAlertView *customAlert = nil;
        customAlert = [[sdmCustomAlertView alloc] initWithImage:image
                                                        message:[sheet localizedStringForKey:kMessage]
                                                       delegate:delegate
                                              cancelButtonTitle:[sheet localizedStringForKey:kCancelButtonTitle]
                                               otherButtonTitle:[sheet localizedStringForKey:kOtherButtonTitle]];
        
        [customAlert show];
    }
}


@end


