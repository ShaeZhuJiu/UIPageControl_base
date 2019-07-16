//
//  MyScrollView.m
//  UIPageControl_base
//
//  Created by 谢鑫 on 2019/7/15.
//  Copyright © 2019 Shae. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat contentSizeWidth=[UIScreen mainScreen].bounds.size.width*4;
        //大小，也可以设置为图片高度
        self.contentSize=CGSizeMake(contentSizeWidth, 0);
        //位置
        self.contentOffset=CGPointZero;
        
        self.pagingEnabled=YES;
        self.showsVerticalScrollIndicator=NO;
        self.showsHorizontalScrollIndicator=NO;
        //取消弹簧效果
        self.bounces=NO;
        self.clipsToBounds=NO;
        
        [self addImageView];
    }
    return self;
}
- (void)addImageView{
    for (int i=0; i<4; i++) {
        NSString *imageName=[NSString stringWithFormat:@"%d",i];
        UIImage *image=[UIImage imageNamed:imageName];
        //获取图片宽高
        CGFloat imageWidth=image.size.width;
        CGFloat imageHeight=image.size.height;
        CGFloat imageWHRatio=imageWidth/imageHeight;
        CGFloat screenWidth=[UIScreen mainScreen].bounds.size.width;
        CGFloat imageViewX=i*screenWidth;
        //根据图片的实际宽度计算显示出来后图片的高度（不失真）,按图片的比例计算高度
        CGFloat imageViewHeight=screenWidth/imageWHRatio;
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageViewX, 0, screenWidth, imageViewHeight)];
        imageView.image=image;
        //添加图片到scrollView
        [self addSubview:imageView];
    }
}
@end
