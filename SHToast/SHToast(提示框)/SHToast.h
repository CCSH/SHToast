//
//  SHToast.h
//  SHToast
//
//  Created by CSH on 2017/8/16.
//  Copyright © 2017年 CSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//默认显示时间
#define kSHToastTime 1.0f
//背景颜色
#define kSHToastBackGroundColor [[UIColor colorWithWhite:0.4 alpha:1] colorWithAlphaComponent:0.75];
//字体颜色
#define kSHToastTextColor [UIColor whiteColor]
//字体大小
#define kSHToastTextFont [UIFont boldSystemFontOfSize:14]
//间隔
#define kSHToastMargin 15

//上方推拉背景颜色
#define kSHToastTopBackGroundColor [UIColor orangeColor];
//上方推拉字体颜色
#define kSHToastTopTextColor [UIColor whiteColor]
//上方推拉字体大小
#define kSHToastTopTextFont [UIFont boldSystemFontOfSize:14]

@interface SHToast : NSObject

#pragma mark - 吐丝
//中间显示
+ (void)showWithText:(NSString *)text;
+ (void)showWithText:(NSString *)text
            duration:(CGFloat)duration;

//上方显示
+ (void)showWithText:(NSString *)text
           topOffset:(CGFloat)topOffset;
+ (void)showWithText:(NSString *)text
           topOffset:(CGFloat)topOffset
            duration:(CGFloat)duration;

//下方显示
+ (void)showWithText:(NSString *)text
        bottomOffset:(CGFloat)bottomOffset;
+ (void)showWithText:(NSString *)text
        bottomOffset:(CGFloat)bottomOffset
            duration:(CGFloat)duration;

#pragma mark - 上方推拉
//中间显示
+ (void)showTopWithText:(NSString *)text;
+ (void)showTopWithText:(NSString *)text
            duration:(CGFloat)duration;

@end
