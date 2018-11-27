//
//  ZCWebImageManager.m
//  ZCTSJWebImage
//
//  Created by 张葱 on 2018/11/26.
//  Copyright © 2018年 聪哥. All rights reserved.
//

#import "ZCWebImageManager.h"
#import "ZCImageCacheManager.h"
#import "ZCImageDownOperation.h"

@interface ZCICombineOperation: NSObject<ZCWEBImageOperationDelegete>
@property (nonatomic,assign,getter= isCancelled)BOOL cancelled;
@property (nonatomic,strong)NSOperation*cacheOperation;
@property (nonatomic,strong)ZCImageDownOperation*downoperation;
@end

@implementation ZCICombineOperation
-(void)cancel{
    
    self.cancelled = YES;
    if (self.cacheOperation) {
        [self.cacheOperation cancel];
        self.cacheOperation = nil;
    }
    
    if (self.downoperation) {
        [self.downoperation cancel];
        self.downoperation = nil;
    }
    
}

@end

@interface ZCWebImageManager()
@property (nonatomic,strong) NSOperationQueue *queue;
@property (nonatomic,strong) NSMutableDictionary *operations;

@end

@implementation ZCWebImageManager
+(instancetype)shared{
    static ZCWebImageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZCWebImageManager alloc]init];
    });
    return manager;
    
}

-(void)addOperationUrl:(NSURL *)url completed:(ZCImageDownloadCompeleteBlcok)compeleteBlcok{
    
    __block ZCICombineOperation *operation = [ZCICombineOperation new];
    __weak ZCICombineOperation *weakoperation = operation;
    
    operation.cacheOperation = [[ZCImageCacheManager shareManager]queryCacheoperationForkey:url.absoluteString compelete:^(UIImage * _Nonnull image) {
        if (image&&compeleteBlcok) {
            compeleteBlcok(image,nil,url);
            return;
        }
        
        ZCImageDownOperation *operation = [[ZCImageDownOperation alloc]initWithURL:url complete:^(UIImage * _Nonnull image) {
            if (compeleteBlcok) {
                compeleteBlcok(image, nil, url);
            }
            
         [self.operations removeObjectForKey:url.absoluteString];
            
        }];
        
        [self.queue addOperation:operation];
        [operation start];
        weakoperation.downoperation = operation;
        
    }];
        
    [self.operations setObject:operation forKey:url.absoluteString];
    
    
}
//取消操作
-(void)cancelOperationWithURL:(NSURL *)url{
    ZCICombineOperation *operation = self.operations[url.absoluteString];
    if (operation&&[operation respondsToSelector:@selector(cancel)]) {
        [operation cancel];
        [self.operations removeObjectForKey:url.absoluteString];
    }

}

-(NSMutableDictionary *)operations{
    if (_operations == nil) {
        _operations = [NSMutableDictionary dictionary];
    }
    
    return _operations;
    
}

-(NSOperationQueue *)queue{
    
    if (_queue) {
        _queue = [[NSOperationQueue alloc]init];
        _queue.maxConcurrentOperationCount = 4;
    }
    return _queue;
    
}

@end
