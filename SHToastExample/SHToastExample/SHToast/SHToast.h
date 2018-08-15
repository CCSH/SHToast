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
//弹框整体左右间隔
#define kSHToastMargin 15
//弹框文字内部间隔
#define kSHToastTextMargin 10

//背景颜色
#define kSHToastRGB [[UIColor colorWithWhite:0.4 alpha:1] colorWithAlphaComponent:0.75];
//字体颜色
#define kSHToastTextRGB [UIColor whiteColor]
//字体大小
#define kSHToastTextFont [UIFont boldSystemFontOfSize:14]

//上方推拉背景颜色
#define kSHToastTopRGB [UIColor orangeColor];
//上方推拉字体颜色
#define kSHToastTopTextRGB [UIColor whiteColor]
//上方推拉字体大小
#define kSHToastTopTextFont [UIFont boldSystemFontOfSize:14]

@interface SHToast : NSObject

//text 可以是 NSString、NSAttributedString

#pragma mark - 吐丝
//中间位置显示
+ (void)showWithText:(id)text;
+ (void)showWithText:(id)text duration:(CGFloat)duration;

//自定义位置显示
+ (void)showWithText:(id)text offset:(CGFloat)offset;
+ (void)showWithText:(id)text offset:(CGFloat)offset duration:(CGFloat)duration;

#pragma mark - 上方推拉
+ (void)showTopWithText:(id)text;
+ (void)showTopWithText:(id)text duration:(CGFloat)duration;

@end
