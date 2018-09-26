//
//  tagView.h
//  TagByMastory
//
//  Created by 哈哈 on 2018/9/26.
//  Copyright © 2018年 哈哈. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tagClick)(NSString *tagTitle);

@interface tagView : UIView
-(instancetype)initWithFrame:(CGRect)frame dataArray:(NSMutableArray*)data;
@property (nonatomic,copy)  tagClick clickBlock;//回调
@property (nonatomic,strong)  NSMutableArray *dataArray;

@end

