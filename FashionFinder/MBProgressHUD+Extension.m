//
//  MBProgressHUD+Extension.m
//  ProjectFrameDemo
//
//  Created by wdwk on 2017/6/13.
//  Copyright © 2017年 eastedu. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)

+ (instancetype)keyWindowHUD{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [[self alloc] initWithView:window];
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    [window addSubview:hud];
    [hud showAnimated:YES];
    return hud;
}

+ (instancetype)show {
    [self hide];
    MBProgressHUD *hud = [self keyWindowHUD];
    return hud;
}

+ (void)showToast:(NSString *)toast {
    [self showToast:toast autoHidden:YES];
}

+ (void)showToast:(NSString *)toast autoHidden:(BOOL)hidden{
    [self hide];
    if (!toast) {
        toast = @"Error";
    }
    MBProgressHUD *hud = [self keyWindowHUD];
    hud.label.numberOfLines = 2;
    hud.label.text = toast;
    hud.mode = MBProgressHUDModeText;
    if (hidden) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            sleep(3.0);
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
        });
    }
}

+ (void)hide {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [self HUDForView:window];
    if (hud != nil) {
        [hud hideAnimated:YES];
    }
}

@end
