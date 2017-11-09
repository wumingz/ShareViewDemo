//
//  YYShareView.m
//  YYShareView
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 Jack YY. All rights reserved.
//

#import "ShareView.h"

static CGFloat const IPHONE_6PLUS_WIDTH = 414;
#define screenWidth         [UIScreen mainScreen].bounds.size.width
#define exchangeSize(size)  (size * screenWidth) / IPHONE_6PLUS_WIDTH

#define screenHeight        [UIScreen mainScreen].bounds.size.height
#define shareViewHeight     exchangeSize(175.f)
#define btn_width           screenWidth/4
#define btn_height          exchangeSize(120.f)
#define img_width           exchangeSize(55.f)
#define img_top             exchangeSize(20.f)
#define img_left            (btn_width- img_width)/2
#define lab_top             exchangeSize(14.f)
#define lab_height          exchangeSize(15.f)
#define seprLine_height     exchangeSize(4.f)
#define CancelBtn_height    exchangeSize(51.f)


@implementation ShareView

-(instancetype)init{
    
    if (self = [super init]) {
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self addSubview:self.ShareView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


-(void)show{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
//    if (view) [view addSubview:self];
    [UIView animateWithDuration:0.3f animations:^{
        
        self.ShareView.frame = CGRectMake(0, self.frame.size.height - shareViewHeight, self.frame.size.width, shareViewHeight);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)close
{
    [UIView animateWithDuration:0.3f animations:^{
        
        self.ShareView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, shareViewHeight);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark -shareView
-(UIView *)ShareView{
    if (!_ShareView) {
        _ShareView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, shareViewHeight)];
        
        //btn的父视图
        UIView *btnSuperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, btn_height)];
        btnSuperView.backgroundColor = [UIColor whiteColor];
        
        NSArray *imgArr = @[@"share_timeLine.png",@"share_weixin.png",@"share_qq.png",@"share_weibo.png"];
        NSArray *textArr = @[@"朋友圈",@"微信",@"QQ",@"微博"];
        for (NSInteger i=0; i<imgArr.count; i++) {
            
            CGRect frame =CGRectMake(i*btn_width, 0, btn_width, btn_height);
            UIButton *btn = [self shareButton:frame img:imgArr[i] labText:textArr[i] tag:i];
            
            [btnSuperView addSubview:btn];
        }
        
        
        //sepreLine
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, btn_height, screenWidth, seprLine_height)];
        lab.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        //cancelBtn
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, btn_height + seprLine_height , screenWidth, CancelBtn_height);
        cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn setTitleColor:[UIColor colorWithRed:71/255. green:179/255. blue:249/255. alpha:1] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:exchangeSize(18.f)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_ShareView addSubview:btnSuperView];
        [_ShareView addSubview:lab];
        [_ShareView addSubview:cancelBtn];
    }
    
    return _ShareView;
}


-(UIButton *)shareButton:(CGRect)frame img:(NSString *)imgName labText:(NSString *)text tag:(NSInteger)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = tag;
    btn.frame = frame;
    //img
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(img_left, img_top, img_width, img_width)];
    [img setImage:[UIImage imageNamed:imgName]];
    img.layer.cornerRadius = img_width/2;
    img.layer.masksToBounds = YES;
    
    //lab
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, img_top+img_width+lab_top, btn_width, lab_height)];
    lab.text = text;
    lab.textColor = [UIColor grayColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:exchangeSize(15.f)];
    
    [btn addSubview:img];
    [btn addSubview:lab];
    
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

-(void)btnClicked:(UIButton *)btn{
    
    self.getTouch(btn.tag);
    [self close];
}


@end

