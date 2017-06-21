//
//  UIImage+Image.h
//  图片生成
//
//  Created by mac on 16/7/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

// 返回一张自定义颜色,尺寸,圆角的颜色图片
+ (UIImage *)imageWithFrame:(CGRect)frame color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;
@end
