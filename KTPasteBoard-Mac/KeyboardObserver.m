//
//  KeyboardObserver.m
//  KTPasteBoard-Mac
//
//  Created by Fidetro on 2018/12/12.
//  Copyright © 2018 karim. All rights reserved.
//

#import "KeyboardObserver.h"

@implementation KeyboardObserver


CGEventRef eventCallback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon) {
    UniCharCount actualStringLength = 0;
    UniChar inputString[128];
    CGEventKeyboardGetUnicodeString(event, 128, &actualStringLength, inputString);
    NSString *inputedString = [[NSString alloc] initWithBytes:(const void*)inputString length:actualStringLength encoding:NSUTF8StringEncoding];
    CGEventFlags flag = CGEventGetFlags(event);
    [[KeyboardObserver shareInstance].delegate keyboardChangeWithInputedString:inputedString flag:flag];
    return event;
}

static KeyboardObserver *_obsever;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _obsever =  [[super alloc]init];
    });
    return _obsever;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _obsever = [super allocWithZone:zone];
    });
    return _obsever;
}

- (id)copyWithZone:(NSZone *)zone{
    return _obsever;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        CFRunLoopRef runloop = CFRunLoopGetCurrent();
        CFMachPortRef keyUpEventTap = CGEventTapCreate(kCGSessionEventTap, kCGHeadInsertEventTap ,kCGEventTapOptionListenOnly,CGEventMaskBit(kCGEventKeyUp) | CGEventMaskBit(kCGEventFlagsChanged),&eventCallback,NULL);
        CFRunLoopSourceRef keyUpRunLoopSourceRef = CFMachPortCreateRunLoopSource(NULL, keyUpEventTap, 0);
        CFRunLoopAddSource(runloop, keyUpRunLoopSourceRef, kCFRunLoopDefaultMode);
        CFRelease(keyUpEventTap);
        CFRelease(keyUpRunLoopSourceRef);
    }
    return self;
}


@end
