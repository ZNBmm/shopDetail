//
//  UIImage+Image.m
//  图片生成
//
//  Created by mac on 16/7/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (UIImage *)imageWithFrame:(CGRect)frame color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.backgroundColor = color;
    imageView.layer.cornerRadius = cornerRadius;
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [imageView.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    NSData *data = UIImagePNGRepresentation(newImage);
    [data writeToFile:@"/Users/mac/Desktop/图片生成.image.png" atomically:YES];
    return newImage;
}
@end
