//
//  SHToast.h
//  SHToast
//
//  Created by CSH on 2017/8/16.
//  Copyright © 2017年 CSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//弹框文字内部间隔
#define kSHToastTextMargin 10

//默认显示时间
#define kSHToastTime 1.0f
//弹框整体左右间隔
#define kSHToastMargin 15
//背景颜色
#define kSHToastRGB [[UIColor blackColor] colorWithAlphaComponent:0.5];

//字体颜色
#define kSHToastTextRGB [UIColor whiteColor]
//字体大小
#define kSHToastTextFont [UIFont systemFontOfSize:14]

//推送时间
#define kSHPushTime 3.0f
//推送背景颜色
#define kSHPushRGB [[UIColor blackColor] colorWithAlphaComponent:0.86];

//推送标题颜色
#define kSHPushTitleRGB [UIColor lightGrayColor]
//标题字体大小
#define kSHPushTitleFont [UIFont systemFontOfSize:14]

//推送内容颜色
#define kSHPushContentRGB [UIColor whiteColor]
//内容字体大小
#define kSHPushContentFont [UIFont systemFontOfSize:14]

@interface SHToast : NSObject

#pragma mark - 吐丝 (text 可以是 NSString、NSAttributedString)
//中间位置显示
+ (void)showWithText:(id)text;
+ (void)showWithText:(id)text duration:(CGFloat)duration;

//自定义位置显示
+ (void)showWithText:(id)text offset:(CGFloat)offset;
+ (void)showWithText:(id)text offset:(CGFloat)offset duration:(CGFloat)duration;

#pragma mark - 推送 (title、content 可以是 NSString、NSAttributedString  content必须存在)
+ (void)showPushWithTitle:(id)title content:(id)content image:(UIImage *)image block:(void(^)(void))block;
+ (void)showPushWithTitle:(id)title content:(id)content image:(UIImage *)image duration:(CGFloat)duration block:(void(^) (void))block;

@end
