//
//  ViewController.m
//  ZCTSJWebImage
//
//  Created by 张葱 on 2018/11/26.
//  Copyright © 2018年 聪哥. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+ZCWebChache.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *centerImage = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:centerImage];
    
    [centerImage setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3739597541,3585053471&fm=26&gp=0.jpg"] placeholderImage:nil compeletedBlcok:^(UIImage * _Nonnull image, NSError * _Nonnull error, NSURL * _Nonnull imageURL) {
        
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
