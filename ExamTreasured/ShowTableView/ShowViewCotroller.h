//
//  ShowViewCotroller.h
//  ExamTreasured
//
//  Created by mac on 14-5-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RATreeView.h"
#import "RADataObject.h"
@interface ShowViewCotroller : UIViewController <RATreeViewDelegate, RATreeViewDataSource>
{
    NSArray *dataSourceArray;
}
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) id expanded;
@property (strong, nonatomic) RATreeView *treeView;
- (id)initWittitle:(NSString*)title;
- (void)initData;
- (void)backController;
- (void)getAllOveryearsByZyid:(NSString*)zyId;
- (void)zuzhuangList:(NSArray*)array;
@end
