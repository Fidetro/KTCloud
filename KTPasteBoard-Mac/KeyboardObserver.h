//
//  KeyboardObserver.h
//  KTPasteBoard-Mac
//
//  Created by Fidetro on 2018/12/12.
//  Copyright © 2018 karim. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KeyboardObserverDelegate <NSObject>

- (void)keyboardChangeWithInputedString:(NSString *)inputedString flag:(CGEventFlags)flag;

@end

@interface KeyboardObserver : NSObject


@property (nonatomic, weak) id<KeyboardObserverDelegate> delegate;

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
