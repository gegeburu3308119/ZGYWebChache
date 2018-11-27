//
//  UIImage+Decode.h
//  ZCTSJWebImage
//
//  Created by 张葱 on 2018/11/26.
//  Copyright © 2018年 聪哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Decode)

/**
 需要编码的图片
 */
+ (UIImage *)decodedImageWithImage:(UIImage *)image;



@end

NS_ASSUME_NONNULL_END
