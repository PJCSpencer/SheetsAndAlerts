//
//  sdmSheetsAndAlerts.h
//  SheetsAndAlerts
//
//  Created by Peter JC Spencer on 18/08/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "sdmCustomAlertView.h"


@interface sdmSheetsAndAlerts : NSObject

// ActionSheet support.
+ (void)showSheetNamed:(NSString *)name
                inView:(UIView *)view
           forDelegate:(id<UIActionSheetDelegate>)delegate;

// Custom alertView support.
+ (void)showCustomAlertNamed:(NSString *)name
                 forDelegate:(id<sdmCustomAlertViewDelegate>)delegate;

@end


