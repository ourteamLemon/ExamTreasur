//
//  RegisterViewController.h
//  ExamTreasured
//
//  Created by mac on 14-5-20.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
}
@property (strong, nonatomic)UITableView  *iTableView;
@property (strong, nonatomic)UITextField  *nameTextField;
@property (strong, nonatomic)UITextField  *passWdTextField;
@property (strong, nonatomic)UITextField  *suerPasswdTextField;
@property (strong, nonatomic)UITextField  *neroTextField;
@property (strong, nonatomic)UITextField  *emailTextField;
@property (strong, nonatomic)UITextField  *phoneNumTextField;
- (id)initWithtitle :(NSString*)titleString;

@end
