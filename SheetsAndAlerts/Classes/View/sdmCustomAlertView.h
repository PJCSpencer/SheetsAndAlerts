//
//  sdmCustomAlertView.h
//  SheetsAndAlerts
//
//  Created by Peter JC Spencer on 19/08/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sdmCustomAlertViewDelegate;


@interface sdmCustomAlertView : UIView

// Property(s).
@property(nonatomic, weak) id<sdmCustomAlertViewDelegate> delegate;

// Creating custom alert views.
- (instancetype)initWithImage:(UIImage *)image
                      message:(NSString *)message
                     delegate:(id<sdmCustomAlertViewDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitle:(NSString *)otherButtonTitle;

// Displaying.
- (void)show;

@end





@protocol sdmCustomAlertViewDelegate <NSObject>

@optional
- (void)alertView:(sdmCustomAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end


