//
//  MiddleViewController.h
//  ExamTreasured
//
//  Created by mac on 14-5-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiddleViewController : UIViewController
{
    NSMutableArray *mainArrayData;
    NSMutableArray *mainViewArray;
}
@property (strong, nonatomic)NSMutableArray *mainViewArray;
- (void)setNaviName:(NSString*)iString;
@end
