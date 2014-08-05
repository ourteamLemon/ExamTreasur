//
//  ShoppingCartViewController.h
//  ExamTreasured
//
//  Created by LYS on 14-8-6.
//  Copyright (c) 2014年 LYS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
}
@property (nonatomic, strong)UITableView *iTableView;
@end
