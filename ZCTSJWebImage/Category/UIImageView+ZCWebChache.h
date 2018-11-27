//
//  UIImage+ZCWebChache.h
//  ZCTSJWebImage
//
//  Created by 张葱 on 2018/11/26.
//  Copyright © 2018年 聪哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCWebImageManager.h"


@interface UIImageView (ZCWebChache)

/**
 
 @param url 图片的url
 */
-(void)setImageWithURL:(NSURL*)url;


/**
 通过url设置图片

 @param url url
 @param placeholderImage 占位图
 */
-(void)setImageWithURL:(NSURL*)url placeholderimage:(UIImage *)placeholderImage;


/**
 通过url设置图片

 @param url 图片的url
 @param placeholderImage 占位图
 @param completedBlock 完成回调
 */
-(void)setImageWithURL:(NSURL*)url placeholderImage:(UIImage*)placeholderImage compeletedBlcok:(ZCImageDownloadCompeleteBlcok)completedBlock;
@end


