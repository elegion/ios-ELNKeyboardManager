//
//  ELNKeyboardManager.h
//  e-legion
//
//  Created by Dmitry Nesterenko on 12.10.15.
//  Copyright © 2015 e-legion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELNKeyboardManager;

@protocol ELNKeyboardManagerDelegate <NSObject>

@optional

/// Invoked in an animation block.
///
/// Before using passed frames, you should convert frames from window coordinate space to view's coordinate space by calling `convertRect:fromView:nil` method and passing `nil` to `fromView` argument.
- (void)keyboardManager:(ELNKeyboardManager *)keyboardManager willChangeKeyboardFrameWithFrameBegin:(CGRect)frameBegin frameEnd:(CGRect)frameEnd;

@end

/// Manager that listens to keyboard notifications and notifies delegate when the keyboard frame has changed.
///
/// Delegate method is invoked in an animation block.
@interface ELNKeyboardManager : NSObject

@property (nonatomic, weak) IBOutlet id<ELNKeyboardManagerDelegate> delegate;

@property (nonatomic, assign) BOOL enabled;

@end

@interface ELNKeyboardManager (ConvenientInit)

- (instancetype)initWithDelegate:(id<ELNKeyboardManagerDelegate>)delegate;

@end
