//
//  ExamTestVC
//  ExamTreasured
//
//  Created by mac on 14-7-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface ExamTestVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    int  sectiononeHeight;
}
@property (nonatomic,strong) UITableView   *tableView;
@property (nonatomic,strong) NSMutableDictionary  *dataDict;
@property (nonatomic,strong) UIView    *sectionView;
@property (nonatomic,assign) int   gindex;
- (id)initWithStyle:(UITableViewStyle)style  Dictinary:(NSDictionary*)dataDictory index:(int)index;

-(void)disposeDictionary:(NSDictionary *)dataDictory;
-(void)disposeDictionarychange:(int )index;
-(void)initTableView;

- (BOOL)checkChangeValue;
- (void)saveData :(int )index;
- (void)QuestionUptoServer:(int)index;
- (BOOL)showSectionView;
- (void)changeSectionView;
- (void)collectExercises;

-(int)calculateSectionHeight:(NSString*)calultString;

@end
