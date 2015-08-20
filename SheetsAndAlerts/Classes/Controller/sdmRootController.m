//
//  sdmRootController.m
//  SheetsAndAlerts
//
//  Created by Peter JC Spencer on 18/08/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import "sdmRootController.h"

#import "sdmSheetsAndAlerts.h"


@interface sdmRootController () <UIActionSheetDelegate, sdmCustomAlertViewDelegate>

// Utility action.
- (void)touchUpInside:(id)sender;

@end





@implementation sdmRootController


#pragma mark - Managing the View (UIViewController)

- (void)loadView {
    
    CGRect rect = CGRectMake(0.0f,
                             0.0f,
                             [UIScreen mainScreen].bounds.size.width,
                             [UIScreen mainScreen].bounds.size.height);
    
    UIView *root = nil;
    root = [[UIView alloc] initWithFrame:rect];
    root.backgroundColor = [UIColor whiteColor];
    
    self.view = root;
    
    
    
    CGFloat scale = 0.5f;
    CGFloat padding = 12.0f;
    CGFloat margin = 30.0f;
    CGSize size = CGSizeMake(rect.size.width - (padding * 2.0f), 40.0f);
    CGFloat dx = (rect.size.width * scale) - (size.width * scale);
    CGFloat dy = 150.0f;
    
    UIButton *sheetButton = nil;
    sheetButton = [[UIButton alloc] initWithFrame:CGRectMake(dx, dy, size.width, size.height)];
    
    [sheetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sheetButton setTitle:[UIActionSheet description] forState:UIControlStateNormal];
    [sheetButton addTarget:self
                  action:@selector(touchUpInside:)
        forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:sheetButton];
    
    
    dy = sheetButton.frame.origin.y + sheetButton.bounds.size.height + margin;
    
    
    UIButton *alertButton = nil;
    alertButton = [[UIButton alloc] initWithFrame:CGRectMake(dx, dy, size.width, size.height)];
    
    [alertButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertButton setTitle:[sdmCustomAlertView description] forState:UIControlStateNormal];
    [alertButton addTarget:self
                    action:@selector(touchUpInside:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:alertButton];
}


#pragma mark - Utility Action

- (void)touchUpInside:(id)sender
{
    NSString *title = ([sender isKindOfClass:[UIButton class]]
                       ? [((UIButton *)sender) titleForState:UIControlStateNormal]
                       : nil);
    
    if ([title isEqualToString:[UIActionSheet description]]) // Show a sheet.
        [sdmSheetsAndAlerts showSheetNamed:@"default"
                                    inView:self.view
                               forDelegate:self];
    
    else
        [sdmSheetsAndAlerts showCustomAlertNamed:@"default"
                                     forDelegate:self];
}


#pragma mark - UIActionSheetDelegate Protocol

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"%s", __FUNCTION__);
}


#pragma mark - sdmCustomAlertViewDelegate Protocol

- (void)alertView:(sdmCustomAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"%s", __FUNCTION__);
}


@end


