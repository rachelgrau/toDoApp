//
//  Utilities.m
//  ToDoApp
//
//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (CGFloat)heightOfString:(NSString *)string containedToWidth:(CGFloat)width withFont:(UIFont *)font {
    if (string) {
        NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
        CGSize labelSize = (CGSize){width, FLT_MAX};
        CGRect r = [string boundingRectWithSize:labelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:context];
        return r.size.height;
    } else {
        return 0;
    }
}

@end
