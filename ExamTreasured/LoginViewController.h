//
//  LoginViewController.h
//  ExamTreasured
//
//  Created by mac on 14-5-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *_nameTextField;
    UITextField *_pwdTextField;
    UIButton *returnBtn;
    int     loginemum;
}
@property(nonatomic,strong) UITextField *nameTextField;
@property(nonatomic,strong) UITextField *pwdTextField;
@end
