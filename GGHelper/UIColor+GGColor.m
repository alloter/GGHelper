//
//  UIColor+GGColor.m
//  GGHelper
//
//  Created by alloter on 16/3/19.
//  Copyright © 2016年 alloter. All rights reserved.
//

#import "UIColor+GGColor.h"

@implementation UIColor (GGColor)

#pragma mark - Hex

+ (UIColor *)colorWithHex:(int)hexValue andAlpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(int)hexValue
{
    return [UIColor colorWithHex:hexValue andAlpha:1.0];
}

+ (UIColor *)colorWithRed:(int)red andGreen:(int)green andBlue:(int)blue andAlpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(red)/255.0 green:(green)/255.0 blue:(blue)/255.0 alpha:(alpha)];
}

+ (UIColor *)colorWithRed:(int)red andGreen:(int)green andBlue:(int)blue
{
    return [UIColor colorWithRed:red andGreen:green andBlue:blue andAlpha:1.0];
}

@end
