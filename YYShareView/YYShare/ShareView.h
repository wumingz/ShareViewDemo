//
//  YYShareView.h
//  YYShareView
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 Jack YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView

@property (strong,nonatomic)void (^getTouch)(NSInteger ButTag);
@property (strong, nonatomic) UIView *ShareView;

-(void)show;
-(void)close;


@end
