//
//  ForgetPasswordVC.h
//  ExamTreasured
//
//  Created by mac on 14-5-26.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordVC : UIViewController<UIWebViewDelegate>
@property(nonatomic ,strong)  UIWebView  *iWebView;
- (id)initWithHTTP:(NSString *)httpsStr;
@end
