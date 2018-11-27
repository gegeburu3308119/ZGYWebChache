//
//  ZCImageDownOperation.m
//  ZCTSJWebImage
//
//  Created by 张葱 on 2018/11/26.
//  Copyright © 2018年 聪哥. All rights reserved.
//

#import "ZCImageDownOperation.h"
#import "UIImage+Decode.h"
@interface  ZCImageDownOperation()
@property (nonatomic,copy) NSURL*url;
@property (nonatomic,copy) void (^downloadCompeleteBlcok)(UIImage*image);
@end
@implementation ZCImageDownOperation
- (instancetype)initWithURL:(NSURL *)url complete:(void (^)(UIImage *))complete
{
    if (self = [super init]) {
        self.url = url;
        self.downloadCompeleteBlcok = complete;
    }
    return self;
}

-(void)main{
    if (self.url == nil) {
        return;
    }
    
    if (self.isCancelled) {
        return;
    }
    //简单的下载
    NSData *data = [NSData dataWithContentsOfURL:self.url];
    UIImage *image = nil;
    if (data.length/1024 > 128) {
        image = [self compressImageWith:image];
    }else{
         image = [UIImage imageWithData:data];
    }
    image = [UIImage decodedImageWithImage:image];
    
    
    if (self.isCancelled) {
        return;
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.downloadCompeleteBlcok(image);
    }];
    
    
}

-(UIImage *)compressImageWith:(UIImage *)image
{
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = 640;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
