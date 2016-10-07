//
//  ELNKeyboardManager.m
//  e-legion
//
//  Created by Dmitry Nesterenko on 12.10.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

#import "ELNKeyboardManager.h"

static UIViewAnimationOptions ELNAnimationOptionsFromAnimationCurve(NSUInteger curve) {
    NSCAssert(UIViewAnimationCurveLinear << 16 == UIViewAnimationOptionCurveLinear, @"Unexpected implementation of UIViewAnimationCurve");
    return curve << 16;
}

@implementation ELNKeyboardManager

#pragma mark - Object Lifecycle

- (void)dealloc {
    self.enabled = NO;
}

#pragma mark - State Management

- (void)setEnabled:(BOOL)enabled {
    if (_enabled == enabled)
        return;
    _enabled = enabled;
    
    if (self.enabled) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)keyboardWillShowNotification:(NSNotification *)notification {
    [self animateWithNotification:notification];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
    [self animateWithNotification:notification];
}

- (void)animateWithNotification:(NSNotification *)notification {
    CGRect frameBegin = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect frameEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSUInteger curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState | ELNAnimationOptionsFromAnimationCurve(curve);
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        if ([self.delegate respondsToSelector:@selector(keyboardManager:willChangeKeyboardFrameWithFrameBegin:frameEnd:)])
            [self.delegate keyboardManager:self willChangeKeyboardFrameWithFrameBegin:frameBegin frameEnd:frameEnd];
    } completion:nil];
}

@end

@implementation ELNKeyboardManager (ConvenientInit)

- (instancetype)initWithDelegate:(id<ELNKeyboardManagerDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

@end
