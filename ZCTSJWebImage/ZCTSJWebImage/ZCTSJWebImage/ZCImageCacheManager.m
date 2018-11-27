//
//  ZCImageCacheManager.m
//  ZCTSJWebImage
//
//  Created by 张葱 on 2018/11/26.
//  Copyright © 2018年 聪哥. All rights reserved.
//

#import "ZCImageCacheManager.h"
#import "UIImage+Decode.h"
@interface ZCImageCacheManager()
@property (nonatomic,strong)NSCache *Caches;
@property (nonatomic,strong) dispatch_queue_t queue;
@end
@implementation ZCImageCacheManager
+(instancetype)shareManager{
    
    static ZCImageCacheManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZCImageCacheManager alloc] init];
    });
    return manager;
    
}

-(instancetype)init{
    
    if (self = [super init]) {
        self.Caches = [[NSCache alloc]init];
        self.Caches.totalCostLimit = 50;
        self.queue = dispatch_queue_create("com.zc.ZCImageCacheManager", DISPATCH_QUEUE_SERIAL);
    }
    
    return self;
}

-(void)storeImage:(UIImage *)image imageData:(NSData *)imageData forkey:(NSString *)key completion:(void (^)(void))compeletedBlcok{
    
    if (!image || !key) {
        if (compeletedBlcok) {
            compeletedBlcok();
        }
        return;
    }
    
    [self.Caches setObject:image forKey:key];
    
    dispatch_async(self.queue, ^{
        
        @autoreleasepool {
            
            if (![self diskImageForkey:key] ) {
                [imageData writeToFile:[self getFilePathWithURLStr:key] atomically:YES];
            }
            
            
            
            if (compeletedBlcok) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    compeletedBlcok();
                });
            }
            
        }
        
    });
    

    
}


-(UIImage*)imageFromMemoryForKey:(NSString *)key{
    
    return [self.Caches objectForKey:key];

}


-(UIImage*)diskImageForkey:(NSString*)key{
    
    NSData *data = [NSData dataWithContentsOfFile:[self getFilePathWithURLStr:key]];
    if (data) {
        UIImage *image = [UIImage imageWithData:data];
        image = [UIImage decodedImageWithImage:image];
        return image;
    }else{
        
        return nil;
    }
    

}

-(NSOperation *)queryCacheoperationForkey:(NSString *)key compelete:(void (^)(UIImage *))completedBlcok{
    
    if (!key) {
        if (completedBlcok) {
            completedBlcok(nil);
        }
        return nil;
    }
    
    UIImage * image = [self imageFromMemoryForKey:key];
    if (image) {
        if (completedBlcok) {
            completedBlcok(image);
        }
        return nil;
    }
    
    NSOperation *operation = [NSOperation new];
    dispatch_sync(self.queue, ^{
        
        if (operation.isCancelled) {
            return;
        }
        
        @autoreleasepool {
            UIImage *diskImage = [self diskImageForkey:key];
            if (diskImage) {
                [self.Caches setObject:diskImage forKey:key];
            }
            
            if (completedBlcok) {
           
                    completedBlcok(diskImage);
         
            }
            
        }
        
    });
    
    
    return operation;
    

}


-(void)deleteAllMemory{
    
    [self.Caches removeAllObjects];
}

-(NSString*)getFilePathWithURLStr:(NSString*)urlStr{
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingString:urlStr];
    return filePath;
    
}

@end
