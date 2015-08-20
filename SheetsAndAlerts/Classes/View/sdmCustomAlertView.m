//
//  sdmCustomAlertView.m
//  SheetsAndAlerts
//
//  Created by Peter JC Spencer on 19/08/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import "sdmCustomAlertView.h"

#define kCustomAlertViewContentWidth 280.0f


@interface sdmCustomAlertView()
{
    UIImageView *_imageView;
    UITextView *_textView;
    UIButton *_cancelButton;
    UIButton *_otherButton;
    
    UIView *_contentView;
}

// Dismissing.
- (void)dismiss;

// Geometry utility.
- (CGFloat)contentWidth;

// Utility action.
- (void)touchUpInside:(id)sender;

@end





@implementation sdmCustomAlertView


#pragma mark - Creating Custom Alert Views

- (instancetype)initWithImage:(UIImage *)image
                      message:(NSString *)message
                     delegate:(id<sdmCustomAlertViewDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitle:(NSString *)otherButtonTitle
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        // Configure.
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
        self.alpha = 0.0f;
        
        self.delegate = delegate;
        
        UIView *anObject = nil;
        anObject = [[UIView alloc] initWithFrame:CGRectZero];
        
        anObject.clipsToBounds = YES;
        anObject.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
        anObject.layer.cornerRadius = 7.0f;
        
        [self addSubview:anObject];
        _contentView = anObject;
        
        
        _imageView = nil;
        if (image)
        {
            UIImageView *anObject = nil;
            anObject = [[UIImageView alloc] initWithImage:image];
            
            anObject.contentMode = UIViewContentModeCenter;
            anObject.backgroundColor = [UIColor clearColor];
            
            [_contentView addSubview:anObject];
            _imageView = anObject;
        }
        
        _textView = nil;
        if (message)
        {
            UITextView *anObject = nil;
            anObject = [[UITextView alloc] initWithFrame:CGRectZero textContainer:nil];
            
            anObject.text = message;
            anObject.font = [UIFont systemFontOfSize:17.0f];
            anObject.textColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
            anObject.textAlignment = NSTextAlignmentCenter;
            anObject.backgroundColor = [UIColor clearColor];
            anObject.selectable = NO;
            anObject.editable = NO;
            anObject.scrollEnabled = NO;
            
            [_contentView addSubview:anObject];
            _textView = anObject;
        }
        
        UIColor *colour = [UIColor colorWithRed:0.0f
                                          green:(122.0f / 255.0f)
                                           blue:1.0f
                                          alpha:1.0f]; // TODO: Support category ...
        _cancelButton = nil;
        if (cancelButtonTitle)
        {
            UIButton *anObject = nil;
            anObject = [[UIButton alloc] initWithFrame:CGRectZero];
            
            anObject.tag = 0;
            anObject.backgroundColor = [UIColor clearColor];
            anObject.titleLabel.font = [UIFont systemFontOfSize:21.0f];
            [anObject setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [anObject setTitleColor:colour forState:UIControlStateNormal];
            [anObject addTarget:self
                         action:@selector(touchUpInside:)
               forControlEvents:UIControlEventTouchUpInside];
            
            [_contentView addSubview:anObject];
            _cancelButton = anObject;
        }
        
        _otherButton = nil;
        if (otherButtonTitle)
        {
            UIButton *anObject = nil;
            anObject = [[UIButton alloc] initWithFrame:CGRectZero];
            
            anObject.tag = 1;
            anObject.backgroundColor = [UIColor clearColor];
            anObject.titleLabel.font = [UIFont boldSystemFontOfSize:21.0f];
            [anObject setTitle:otherButtonTitle forState:UIControlStateNormal];
            [anObject setTitleColor:colour forState:UIControlStateNormal];
            [anObject addTarget:self
                         action:@selector(touchUpInside:)
               forControlEvents:UIControlEventTouchUpInside];
            
            [_contentView addSubview:anObject];
            _otherButton = anObject;
        }
    }
    return self;
}


#pragma mark - Geometry Utility

- (CGFloat)contentWidth
{
    return kCustomAlertViewContentWidth; // TODO: Expand ...
}


#pragma mark - Laying out Subviews (UIView)

- (void)layoutSubviews {
    
    // Super.
    [super layoutSubviews];
    
    // Modify geometry.
    CGFloat padding = 14.0f;
    CGFloat margin = 8.0f;
    CGFloat dx = 0.0f;
    CGFloat dy = padding;
    CGFloat width = [self contentWidth];
    CGFloat height = 0.0f;
    CGFloat scale = (_cancelButton && _otherButton ? 0.5f : 1.0f);
    
    if (_imageView)
    {
        CGSize size = _imageView.image.size;
        _imageView.frame = CGRectMake((width * 0.5f) - (size.width * 0.5f),
                                      dy,
                                      size.width,
                                      size.height);
        
        dy = _imageView.frame.origin.y + _imageView.bounds.size.height;
        height = dy;
    }
    
    if (_textView)
    {
        CGFloat insetX = _textView.textContainerInset.left + _textView.textContainerInset.right;
        CGFloat insetY = _textView.textContainerInset.top + _textView.textContainerInset.bottom;
        CGFloat textHeight = [_textView.text boundingRectWithSize:CGSizeMake(width - insetX, CGFLOAT_MAX)
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{ NSFontAttributeName : _textView.font }
                                                          context:nil].size.height + insetY;
        
        _textView.frame = CGRectMake(0.0f, dy + margin, width, textHeight);
        
        dy = _textView.frame.origin.y + _textView.bounds.size.height;
        height = dy;
    }
    
    if (_cancelButton)
    {
        _cancelButton.frame = CGRectMake(0.0f, dy + margin, width * scale, 35.0f);
        
        if (!_otherButton)
        {
            dy = _cancelButton.frame.origin.y + _cancelButton.bounds.size.height;
            height = dy;
        }
    }
    
    if (_otherButton)
    {
        _otherButton.frame = CGRectMake(width * scale, dy + margin, width * scale, 35.0f);
        
        dy = _otherButton.frame.origin.y + _otherButton.bounds.size.height;
        height = dy;
    }
    
    dx = self.bounds.size.width * 0.5f - (width * 0.5f);
    dy = (self.bounds.size.height * 0.5f) - (height * 0.5f);
    _contentView.frame = CGRectMake(dx, dy, width, height + padding);
}


#pragma mark - Displaying

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    __weak sdmCustomAlertView *weakSelf = self;
    
    [UIView animateWithDuration:0.3f
                     animations:^{ weakSelf.alpha = 1.0f; }];
    
    // Dismiss automatically if there are no button(s).
    if (!_cancelButton && !_otherButton)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0f * NSEC_PER_SEC),
                       dispatch_get_main_queue(),
                       ^{ [weakSelf dismiss]; });
}


#pragma mark - Dismissing

- (void)dismiss
{
    __weak sdmCustomAlertView *weakSelf = self;
    
    [UIView animateWithDuration:0.3f
                     animations:^{ weakSelf.alpha = 0.0f; }
                     completion:^(BOOL finished) { [weakSelf removeFromSuperview]; }];
}


#pragma mark - Utility Action

- (void)touchUpInside:(id)sender
{
    if ([_delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)])
        [_delegate alertView:self didDismissWithButtonIndex:((UIButton *)sender).tag];
    
    [self dismiss];
}


@end


