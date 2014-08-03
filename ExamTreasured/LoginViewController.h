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
    UITextField *nameTextField;
    UITextField *pwdTextField;
    UIButton *returnBtn;
    int     loginemum;
}
@end
