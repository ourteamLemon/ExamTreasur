//
//  MainScrollViewController.h
//  ExamTreasured
//
//  Created by shagua on 14-6-1.
//  Copyright (c) 2014年 shagua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GongLue/GongLueModel.h"
@interface MainScrollViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate>
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
