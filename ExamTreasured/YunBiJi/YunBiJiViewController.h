//
//  YunBiJiViewController.h
//  ExamTreasured
//
//  Created by yuan on 14-6-3.
//  Copyright (c) 2014年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RATreeView.h"
#import "RADataObject.h"

@interface YunBiJiViewController : UIViewController<RATreeViewDelegate, RATreeViewDataSource>
{
    NSArray *dataSourceArray;
}
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) id expanded;

@property (strong, nonatomic) RATreeView *treeView;

- (id)initWittitle:(NSString*)title;

@end
