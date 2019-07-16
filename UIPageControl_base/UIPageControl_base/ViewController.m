//
//  ViewController.m
//  UIPageControl_base
//
//  Created by 谢鑫 on 2019/7/15.
//  Copyright © 2019 Shae. All rights reserved.
//

#import "ViewController.h"
#import "MyScrollView.h"
@interface ViewController ()
@property(nonatomic,strong)MyScrollView *myScrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)NSTimer *timer;
@property int currentImageIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myScrollView];
    [self.view addSubview:self.pageControl];
    //应用一启动就立即启动定时器
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    
}
- (MyScrollView *)myScrollView{
    if (_myScrollView==nil) {
        //获取图片的高度
        UIImage *image=[UIImage imageNamed:@"0"];
        CGFloat imageWidth=image.size.width;
        CGFloat imageHeight=image.size.height;
        CGFloat imageWHRatio=imageWidth/imageHeight;
        CGFloat screenWidth=[UIScreen mainScreen].bounds.size.width;
        CGFloat imageViewHeight=screenWidth/imageWHRatio;
        _myScrollView=[[MyScrollView alloc]initWithFrame:CGRectMake(0, 20, screenWidth, imageViewHeight)];
    }
    return _myScrollView;
}

- (UIPageControl *)pageControl{
    if(_pageControl==nil){
        _pageControl=[[UIPageControl alloc]init];
        _pageControl.frame=CGRectMake(0, 215, [UIScreen mainScreen].bounds.size.width, 37);
        _pageControl.numberOfPages=4;
        _pageControl.currentPage=0;
        _pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor=[UIColor blackColor];
        //监控用户用于pageController的点击事件
        [_pageControl addTarget:self action:@selector(clickPageControl) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}
-(void)clickPageControl{
    //*********
    //根据点击的pageControl的值，来更新scrollview的contentoffset
    CGFloat x = [UIScreen mainScreen].bounds.size.width * self.pageControl.currentPage;
    [self.myScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    //更新一下currentImageIndex的值
    self.currentImageIndex = (int)self.pageControl.currentPage;
}
- (void)changeImage {
    //********
    //更新pageControl的值
    self.pageControl.currentPage = self.currentImageIndex;
    //计算每次偏移的x值
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat x = screenWidth * self.currentImageIndex++;
    [self.myScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    //重新更新index的值
    if (self.currentImageIndex == 4) self.currentImageIndex = 0;
}
@end
