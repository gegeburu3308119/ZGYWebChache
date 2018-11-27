//
//  ZCWebImageManager.h
//  ZCTSJWebImage
//
//  Created by 张葱 on 2018/11/26.
//  Copyright © 2018年 聪哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCImageDownOperation.h"
#import <UIKit/UIKit.h>


typedef  void (^ZCImageDownloadCompeleteBlcok)(UIImage*image,NSError*error,NSURL *imageURL);
@protocol ZCWEBImageOperationDelegete <NSObject>

@required
-(void)cancel;

@end
@interface ZCWebImageManager : NSObject

+(instancetype)shared;


/**
 添加操作
 @param url 图片的url
 @param compeleteBlcok 完成后的回调
 */
-(void)addOperationUrl:(NSURL*)url completed:(ZCImageDownloadCompeleteBlcok)compeleteBlcok;


/**
 取消操作
 */
-(void)cancelOperationWithURL:(NSURL*)url;
@end



\
