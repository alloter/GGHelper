//
//  UIColor+GGColor.h
//  GGHelper
//
//  Created by alloter on 16/3/19.
//  Copyright © 2016年 alloter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (GGColor)

#pragma mark - Hex
+ (UIColor *)colorWithHex:(int)hexValue andAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hexValue;

+ (UIColor *)colorWithRed:(int)red andGreen:(int)green andBlue:(int)blue andAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithRed:(int)red andGreen:(int)green andBlue:(int)blue;

@end
