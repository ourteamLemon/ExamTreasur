//
//  GongLueViewController.h
//  ExamTreasured
//
//  Created by yuan on 14-5-28.
//  Copyright (c) 2014年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GongLueModel.h"
@interface GongLueViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UIWebView *iWebView;
    
}
@property (strong, nonatomic)GongLueModel *glModel;
@property (strong, nonatomic)  UIButton *sendBtn;
@property (strong, nonatomic)  UIButton *shoucangBtn;
@property (strong, nonatomic)  UIButton *pinglunBtn;
@property (strong, nonatomic)  UITextField *messageTextField;
@property (strong, nonatomic)  UIView *sendView;

@end
