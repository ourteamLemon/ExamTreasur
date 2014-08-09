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
    CGFloat        tableViewYheight;
    //contain charelist Object
    NSMutableArray *rechargeArray;
}
@property (nonatomic, strong)UITableView *iTableView;

@property (nonatomic, strong)UIScrollView *iScrollView;
@end

@interface chargeList : NSObject
{
    
}
@property (nonatomic, strong) NSString  *giveIntegral;
@property (nonatomic, strong) NSString  *monthCount;
@property (nonatomic, strong) NSString  *price;
@property (nonatomic, strong) NSString  *professionID;
@property (nonatomic, strong) NSString  *rechargeListID;
@end