//
//  ForgetPasswordVC.m
//  ExamTreasured
//
//  Created by mac on 14-5-26.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ForgetPasswordVC.h"

@interface ForgetPasswordVC ()

@end

@implementation ForgetPasswordVC
@synthesize iWebView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithHTTP:(NSString *)httpsStr
{
    self = [super initWithNibName:nil  bundle:nil];
    if (self)
    {
        [self initWebView:httpsStr];
    
    }
    return self;

}

-(void)initWebView :(NSString*)httpsStr
{
    
    
    iWebView.frame = CGRectMake(0, 0 ,320 ,isIPhone5?568:460);
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:httpsStr]];
    [iWebView loadRequest:request];
    iWebView.delegate = self;
    [self.view addSubview:iWebView];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavgation];
    [self addNaviRightBtn];

    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];


}
- (void)setNavgation
{
    [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,30,30) target:self action:@selector(backController)];
    
    [self setNaviTitle:@"找回密码"];
    
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void )webViewDidStartLoad:(UIWebView  *)webView
{
    NSLog(@"start did Start Load");
}
- (void )webViewDidFinishLoad:(UIWebView  *)webView
{
    NSLog(@"web Did Finish");
}

-(void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error
{
    
}

@end
