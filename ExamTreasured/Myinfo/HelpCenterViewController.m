//
//  HelpCenterViewController.m
//  ExamTreasured
//
//  Created by mac on 14-5-28.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "HelpCenterViewController.h"

@interface HelpCenterViewController ()

@end

@implementation HelpCenterViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNaviRightBtn];
    [self setNavgation];
    [self selfViewContentInit];
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)setNavgation
{


     [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,130,30) target:self action:@selector(backController)];
    [self setNaviTitle:@"帮助中心"];
    UIImage *nav_background = [UIImage imageNamed:@"navgation"];
    [self setNaviBackGroundWithImage:nav_background];
}
- (void)backController
{
    if ([self.navigationController.childViewControllers objectAtIndex:0] == self)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)selfViewContentInit
{
    UIWebView *iwebView       = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, MAINSCREENHEIGHT-20-44)];
    iwebView.delegate         = self;
    MKNetworkOperation *op    = [m_AppDelegate.networkEngineinstace  getdata:nil path:PHONEABOUT httpMethod:GET];
    NSURLRequest  *requestURL = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:op.url]];
    [iwebView  loadRequest:requestURL];
    [self.view addSubview:iwebView];
}
#pragma mark webViewdelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webviewStart");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
      NSLog(@"webViewDidFinishLoad");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
      NSLog(@"webViewDidFinishLoad");
}

@end
