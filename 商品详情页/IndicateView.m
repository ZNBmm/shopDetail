//
//  IndicateView.m
//  商品详情页
//
//  Created by mac on 2017/5/23.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "IndicateView.h"

@implementation IndicateView

+ (instancetype)shareIndicateView {

    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}
@end
