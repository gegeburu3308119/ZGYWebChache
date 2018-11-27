//
//  ZCImageCacheManager.h
//  ZCTSJWebImage
//
//  Created by 张葱 on 2018/11/26.
//  Copyright © 2018年 聪哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZCImageCacheManager : NSObject

+(instancetype)shareManager;


/**
 保存图片

 @param image 图片
 @param imageData 图片的数据
 @param key 图片的标识符
 @param compeletedBlcok 下载完成的回调
 */
-(void)storeImage:(UIImage*)image  imageData:(NSData*)imageData  forkey:(NSString*)key completion:(void(^)(void))compeletedBlcok;


/**
 查询缓存和本地是否有图片  异步执行

 @param key 图片标识
 @param completedBlcok 完成的回调
 */
-(NSOperation*)queryCacheoperationForkey:(NSString*)key compelete:(void(^)(UIImage*image))completedBlcok;


-(void)deleteAllMemory;
@end

NS_ASSUME_NONNULL_END
