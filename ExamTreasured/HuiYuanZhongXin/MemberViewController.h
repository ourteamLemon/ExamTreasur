//
//  MemberViewController.h
//  ExamTreasured
//
//  Created by yuan on 14-5-21.
//  Copyright (c) 2014年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)  UITableView *iTableView;
- (id)initWithtitle :(NSString*)titleString;
@end
