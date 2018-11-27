//
//  ZCImageDownOperation.h
//  ZCTSJWebImage
//
//  Created by 张葱 on 2018/11/26.
//  Copyright © 2018年 聪哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZCImageDownOperation : NSOperation


/**
 初始化异步操作

 @param url 图片链接地址
 @param complete 完成回调

 */
- (instancetype)initWithURL:(NSURL *)url complete:(void (^)(UIImage *image))complete;
@end

NS_ASSUME_NONNULL_END
