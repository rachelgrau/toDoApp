/**
 * File: Utilities.h
 * ------------------------------
 * Contains some useful functions used throughout the app.
 */

//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utilities : NSObject

/* Returns the height of the given string when contained to the given width. Useful for figuring out how many lines a certain label takes
 Example:
 CGFloat unitHeight = [GraphicUtils heightOfString:@"A" containedToWidth:width withFont:descFont];
 CGFloat descriptionHeight = [GraphicUtils heightOfString:someString containedToWidth:width withFont:someFont];
 NSInteger numberOfLines = ceilf(descriptionHeight / unitHeight);
 */
+ (CGFloat)heightOfString:(NSString *)string containedToWidth:(CGFloat)width withFont:(UIFont *)font;

@end
