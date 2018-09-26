//
//  tagView.m
//  TagByMastory
//
//  Created by 哈哈 on 2018/9/26.
//  Copyright © 2018年 哈哈. All rights reserved.
//

#import "tagView.h"
#import <Masonry/Masonry.h>
#define SCREENWIDTH   [UIScreen mainScreen].bounds.size.width

@interface tagView()
@property (nonatomic,assign)  CGFloat tagHeight;///标签的高度
@property (nonatomic,assign)  CGFloat horMargin;///左右间距
@property (nonatomic,assign)  CGFloat verMargin;///上下间距
@property (nonatomic,assign)  CGFloat tagInnerVerMargin;///标签内部上下间距
@property (nonatomic,assign)  CGFloat tagInnerHorMargin;///标签内部左右间距
@property (nonatomic,assign)  CGFloat tagVerMargin;///标签之间的间距
@property(nonatomic,strong)NSMutableArray *tagsArray; ///


@end

@implementation tagView

-(instancetype)initWithFrame:(CGRect)frame dataArray:(NSMutableArray*)data{
    self = [super initWithFrame:frame];
    if (self) {
        self.tagHeight = 44;
        self.horMargin = 10;
        self.verMargin = 10;
        self.tagInnerVerMargin = 5;
        self.tagInnerHorMargin = 5;
        self.tagVerMargin = 20;
        self.dataArray = data;
       [self setUpUi];


    }
    return self;
    
}



-(void)setUpUi{
    self.tagsArray = [NSMutableArray new];
    for (int i = 0 ; i <self.dataArray.count; i ++) {
        UIButton *tagBtn = [UIButton new];
        [tagBtn setTitle:self.dataArray[i] forState:UIControlStateNormal];
        [tagBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tagBtn];
        [self.tagsArray addObject:tagBtn];
    }
    
    [self layoutTags];
}

-(void)click:(UIButton*)sender{
    if (self.clickBlock!=nil) {
        self.clickBlock(sender.titleLabel.text);

    }
}

#pragma mark 布局
-(void)layoutTags{
    CGFloat tagLineWidth = self.horMargin;
    __block BOOL changeNewLine = NO;/// 是否换行
    UIButton *lastItem = nil;

    for (int i =0 ; i <self.tagsArray.count; i ++) {
        UIButton *itemBtn = self.tagsArray[i];
        itemBtn.backgroundColor = [UIColor grayColor];

        NSString *tagTitle = itemBtn.titleLabel.text;
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
        CGRect rect =  [tagTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, self.tagHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
        CGFloat tagWidth = rect.size.width + 2*self.tagInnerHorMargin +2;//mastory布局会四舍五入，加1防止宽度不够
        tagLineWidth += tagWidth + self.tagVerMargin;
        
        /// 当长度超过一行
        if (tagLineWidth > SCREENWIDTH -self.horMargin) {
            changeNewLine = YES;
            if (tagWidth > SCREENWIDTH - 2*self.horMargin) {
                tagWidth = SCREENWIDTH - 2*self.horMargin;
                
            }
            tagLineWidth = self.horMargin + self.tagVerMargin+tagWidth;
        }
   
   
        [itemBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(tagWidth);
            make.height.mas_equalTo(self.tagHeight);
             ///第一个标签
            if (!lastItem) {
                make.top.mas_equalTo(self.verMargin);
                make.left.mas_equalTo(self.horMargin);
            } else {
                 /// 需要换行
                if (changeNewLine) {
                  make.top.mas_equalTo(lastItem.mas_bottom).offset(self.tagVerMargin);
                      make.left.mas_equalTo(self.verMargin);
                      changeNewLine = NO;
                } else {
                    make.left.mas_equalTo(lastItem.mas_right).offset(self.tagVerMargin);
                       make.top.mas_equalTo(lastItem.mas_top);
                }
                
            }
                
         }];
    
        lastItem = itemBtn;
    }
}



@end
