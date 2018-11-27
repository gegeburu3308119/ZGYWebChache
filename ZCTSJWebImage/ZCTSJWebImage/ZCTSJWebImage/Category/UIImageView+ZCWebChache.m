//
//  UIImage+ZCWebChache.m
//  ZCTSJWebImage
//
//  Created by 张葱 on 2018/11/26.
//  Copyright © 2018年 聪哥. All rights reserved.
//

#import "UIImageView+ZCWebChache.h"
#import <objc/runtime.h>

static char urlkey;
@implementation UIImageView (ZCWebChache)
-(void)setImageWithURL:(NSURL *)url{
    [self setImageWithURL:url placeholderImage:nil compeletedBlcok:nil];
    
}

-(void)setImageWithURL:(NSURL *)url placeholderimage:(UIImage *)placeholderImage{
    
    [self setImageWithURL:url placeholderImage:placeholderImage compeletedBlcok:nil];
    
}

-(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage compeletedBlcok:(ZCImageDownloadCompeleteBlcok)completedBlock{
    if (placeholderImage) {
        self.image = placeholderImage;
    }else{
        
        self.image = [UIImage imageNamed:@""];
    }
    
    if (url == nil || url.absoluteString.length == 0) {
        completedBlock(nil,[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil],nil);
    }
    if ([url isKindOfClass:NSString.class]) {
        url = [NSURL URLWithString:(NSString*)url];
    }
    NSString *lastKey = [self getURLKey];
    
    [[ZCWebImageManager shared]cancelOperationWithURL:[NSURL URLWithString:lastKey]];
    
    [[ZCWebImageManager shared]addOperationUrl:url completed:^(UIImage * _Nonnull image, NSError * _Nonnull error, NSURL * _Nonnull imageURL) {
        self.image = image;
        if (completedBlock) {
            completedBlock(image,nil,url);
        }
        
        
    }];
    
    [self setURLKey:url.absoluteString];
    
    
}

-(NSString*)getURLKey{
    
    return objc_getAssociatedObject(self, &urlkey);
    
}

-(void)setURLKey:(NSString*)urlStr{
    
    objc_setAssociatedObject(self, &urlkey, urlStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

@end
