//
//  CollectViewController.h
//  ExamTreasured
//
//  Created by mac on 14-5-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIView *stView;
    UIView *bjView;
    UIView *glView;
    UIView *ctView;
    
    UITableView *aTable;
    NSDictionary *stDataSource;
    NSDictionary *bjDataSource;
    NSDictionary *glDataSource;
    NSDictionary *ctDataSource;
}
- (id)initWithtitle:(NSString *)titleString;
@end
