//
//  ZhangjieViewController.m
//  ExamTreasured
//
//  Created by mac on 14-5-28.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ZhangjieViewController.h"
#import "ExamTestViewController.h"
#import "ChapterQAViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "ChapterModel.h"

@interface ZhangjieViewController ()
{
    
}
@end

@implementation ZhangjieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWittitle:(NSString*)title
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        [self setNaviTitle:title];
        
    }
    return self;
}

- (void)viewDidLoad
{
//    [super viewDidLoad];

    [self setNavgation];
    [self getAllOveryearsByZyidok: m_AppDelegate.zy_ID];
    [self initData];
    [self addNaviRightBtn];
}



- (void)addNaviRightBtn
{
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 2,130,30);
    [_backBtn setTitle:@"www.doctorvbook.com" forState:UIControlStateNormal];
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:8.0];
    _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
}

//获取章节列表
- (void)getAllOveryearsByZyidok:(NSString*)zyId
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:zyId,@"zy_id", nil];
    MKNetworkOperation  *op = [m_AppDelegate.networkEngineinstace getdata:dic path:NOTE_GETCHAPTERMINUTIA httpMethod:POST];
    NSLog(@"%@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         hud.hidden = YES;
         NSArray  *dic = [completedOperation responseJSON];
         NSLog(@"%@",dic);
         if (dic && [dic count] > 0)
         {
             dataSourceArray = [NSArray arrayWithArray:dic];
             [self zuzhuangListok:dic];
         }
     }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
     {
         hud.hidden = YES;
     }];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)setNavgation
{
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,30,30) target:self action:@selector(backController)];
    
    
    UIImage *nav_background = [UIImage imageNamed:@"navgation"];
    [self setNaviBackGroundWithImage:nav_background];
}
- (void)backController
{
    if ([self.navigationController.childViewControllers objectAtIndex:0] == self)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



#pragma  mark
- (BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return  NO;
}

- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return 47;
}

- (NSInteger)treeView:(RATreeView *)treeView indentationLevelForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return 3 * treeNodeInfo.treeDepthLevel;
}

- (BOOL)treeView:(RATreeView *)treeView shouldExpandItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return NO;
}

- (BOOL)treeView:(RATreeView *)treeView shouldItemBeExpandedAfterDataReload:(id)item treeDepthLevel:(NSInteger)treeDepthLevel
{
    if ( [item isEqual:self.expanded]|| (treeDepthLevel == 0) )
    {
        return YES;
    }
    return NO;
}

#pragma mark TreeView Data Source

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [treeView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    cell.textLabel.text = ((RADataObject *)item).name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (treeNodeInfo.treeDepthLevel == 0) {
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    NSLog(@"fdfd");
    if (item == nil) {
        return [self.data count];
    }
    RADataObject *data = item;
    return [data.children count];
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    RADataObject *data = item;
    if (item == nil) {
        return [self.data objectAtIndex:index];
    }
    return [data.children objectAtIndex:index];
}

- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    NSLog(@"%@",item);
    
    NSLog(@"%d---%d---%d\n%d---%d---%d",treeNodeInfo.treeDepthLevel,treeNodeInfo.siblingsNumber,treeNodeInfo.positionInSiblings,treeNodeInfo.parent.treeDepthLevel,treeNodeInfo.parent.siblingsNumber,treeNodeInfo.parent.positionInSiblings);
    
//    if (treeNodeInfo.treeDepthLevel == 1) {
//        NSDictionary *tempDic = [[[dataSourceArray objectAtIndex:treeNodeInfo.parent.positionInSiblings]  objectForKey:@"units"] objectAtIndex:treeNodeInfo.positionInSiblings];
//        
//        ChapterQAViewController  *chapterQAVC = [[ChapterQAViewController alloc]initWithDictionary:tempDic index:treeNodeInfo.positionInSiblings];
//        UINavigationController *ChapterNav = [[UINavigationController alloc]initWithRootViewController:chapterQAVC];
//        [self presentViewController:ChapterNav animated:YES completion:nil];
//    }
    
}




//overwrite  method
//遍历数据库上请求下来的数据
-(void)zuzhuangListok:(NSArray *)array
{
    
    NSMutableArray  *mutabArray = [[NSMutableArray alloc]init];
    for (NSDictionary  *firstdic  in array)
    {
        NSMutableArray  *secondArray = [[NSMutableArray alloc]init];
        for (NSDictionary *seconddic  in [firstdic objectForKey:@"ZJ"])
        {
           
            NSMutableArray  *thirdArray = [[NSMutableArray alloc]init];
            for (NSDictionary *thirdDic in [seconddic objectForKey:@"minutia"])
            {
                
                ChapterModel *thirdChapter = [[ChapterModel alloc]initWithName:[thirdDic objectForKey:@"XJ_MC"] children:nil];
                ChapterDatemMinutia   *dateMinutia = [[ChapterDatemMinutia alloc]init];
                
                NSArray  *thirdkeyarray = [thirdDic allKeys];
                for (int thridIndex = 0; thridIndex < [thirdDic allKeys].count; thridIndex++)
                {
                    [dateMinutia  setValue:[thirdDic objectForKey:[thirdkeyarray objectAtIndex:thridIndex]]  forKey:[thirdkeyarray objectAtIndex:thridIndex]];
                }
                thirdChapter.chapterDateMinutia = dateMinutia;
                [thirdArray addObject:thirdChapter];
            }
            
            ChapterModel *secondchapter = [[ChapterModel alloc]initWithName:[seconddic objectForKey:@"ZJ_MC"] children:thirdArray];
            ChapterDateZJ  *dataZj = [[ChapterDateZJ alloc]init];
            
            NSMutableDictionary  *tempSecondDic = [[NSMutableDictionary alloc]initWithDictionary:seconddic];
           [tempSecondDic removeObjectForKey:@"minutia"];
            NSArray  *secondkeyarray = [tempSecondDic allKeys];
            
            for (int secondIndex = 0; secondIndex < [secondkeyarray count]; secondIndex++)
            {
                NSLog(@"%@",[secondkeyarray objectAtIndex:secondIndex]);
                [dataZj  setValue:[tempSecondDic objectForKey:[secondkeyarray objectAtIndex:secondIndex]]  forKey:[secondkeyarray objectAtIndex:secondIndex]];
            }
            secondchapter.chapterDateZJ = dataZj;
            [secondArray addObject:secondchapter];
        }
        
        ChapterModel *chapter = [[ChapterModel alloc]initWithName:[firstdic objectForKey:@"KM_MC"] children:secondArray];
        ChapterDatestartNode *chapterDatenode = [[ChapterDatestartNode alloc]init];
        
        NSMutableDictionary  *tempFirstDic = [[NSMutableDictionary alloc]initWithDictionary:firstdic];
        [tempFirstDic removeObjectForKey:@"ZJ"];
        NSArray  *firstkeyarray = [tempFirstDic allKeys];
        for (int firstdicIndex = 0; firstdicIndex < [tempFirstDic allKeys].count; firstdicIndex++)
        {
            [chapter.startNode  setValue:[firstdic objectForKey:[firstkeyarray objectAtIndex:firstdicIndex]]  forKey:[firstkeyarray objectAtIndex:firstdicIndex]];
        }
        chapter.startNode = chapterDatenode;
        [mutabArray addObject: chapter];
    }
    self.data = mutabArray;
    
    [self.treeView reloadData];
}

@end
