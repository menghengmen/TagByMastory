//
//  ViewController.m
//  TagByMastory
//
//  Created by 哈哈 on 2018/9/26.
//  Copyright © 2018年 哈哈. All rights reserved.
//

#import "ViewController.h"
#import "tagView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"蒙奇帝路飞",@"索隆",@"京东金融",@"乌索普",@"山治--厨师",@"东尼。东尼.乔巴",@"尼克罗宾luobinluobinluobin",@"232323",@"弗兰奇---fulanqi",@"shenpingsasa",@".",@"萨博sasa",@"海军大将322",@"12",@"漫漫",@"1",@"哈哈",@"哈鲁也"];

    tagView *tag = [[tagView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 400) dataArray:[array copy]];
    [self.view addSubview:tag];
    tag.clickBlock = ^(NSString *tagTitle) {
        NSLog(@"%@",tagTitle);
    };
    
}


@end
