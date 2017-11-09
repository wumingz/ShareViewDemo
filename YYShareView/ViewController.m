//
//  ViewController.m
//  YYShareView
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 Jack YY. All rights reserved.
//

#import "ViewController.h"
#import "ShareView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)touch:(id)sender
{
    [self skipOtherApp];
    
    ShareView * share = [[ShareView alloc] init];
    [share setGetTouch:^(NSInteger tag)
    {
        [self getTag:tag];
    }];
    [share show];
}

- (void)skipOtherApp{
    
    NSURL* open_URL_A = [NSURL URLWithString:@"dscf://"];
    //判断是否是否有can打开应用程序，如果成功就打开
    if ([[UIApplication sharedApplication] canOpenURL:open_URL_A]) {
        NSLog(@"可以打开");
        [[UIApplication sharedApplication] openURL:open_URL_A];
    }else{
        NSLog(@"没有安装app");
    }
    
}


-(void)getTag:(NSInteger)tag
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"点击第%d个图标",tag] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
