//
//  ShowViewCotroller.m
//  ExamTreasured
//
//  Created by mac on 14-5-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ShowViewCotroller.h"
#import "ExamTestViewController.h"

@interface ShowViewCotroller ()
@end
@implementation ShowViewCotroller
@synthesize treeView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

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


-(void)initData
{

    int tempH = 0;
    CGRect  treeRect;
    if (isIPhone5) {
        tempH = 64;
    }
    else{
        tempH = 44;
    }
    treeRect = CGRectMake(0, 0, 320, self.view.frame.size.height-tempH);
    
    treeView = [[RATreeView alloc] initWithFrame:treeRect];
    treeView.delegate = self;
    treeView.dataSource = self;
    treeView.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;
    [treeView setEditing:NO];
    [treeView reloadData];
    [self.view addSubview:treeView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavgation];
    [self getAllOveryearsByZyid: m_AppDelegate.zy_ID];
    [self initData];
    [self setNavgation];
    [self addNaviRightBtn];
}

- (BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return  NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

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
    return YES;
}

- (BOOL)treeView:(RATreeView *)treeView shouldItemBeExpandedAfterDataReload:(id)item treeDepthLevel:(NSInteger)treeDepthLevel
{
    if ([item isEqual:self.expanded]) {
        return NO;
    }
    return YES;
}

//- (void)treeView:(RATreeView *)treeView willDisplayCell:(UITableViewCell *)cell forItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
//{
//    if (treeNodeInfo.treeDepthLevel == 0) {
//        cell.backgroundColor = UIColorFromRGB(0xF7F7F7);
//    } else if (treeNodeInfo.treeDepthLevel == 1) {
//        cell.backgroundColor = UIColorFromRGB(0xD1EEFC);
//    } else if (treeNodeInfo.treeDepthLevel == 2) {
//        cell.backgroundColor = UIColorFromRGB(0xE0F8D8);
//    }
//}

#pragma mark TreeView Data Source

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    cell.textLabel.text = ((RADataObject *)item).name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (treeNodeInfo.treeDepthLevel == 0) {
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
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

    if (treeNodeInfo.treeDepthLevel == 1) {
        NSDictionary *tempDic = [[[dataSourceArray objectAtIndex:treeNodeInfo.parent.positionInSiblings]  objectForKey:@"units"] objectAtIndex:treeNodeInfo.positionInSiblings];
        
        ExamTestViewController *examTestVC = [[ExamTestViewController alloc]initWithDictionary:tempDic index:treeNodeInfo.positionInSiblings ];
        
        UINavigationController *examNav = [[UINavigationController alloc]initWithRootViewController:examTestVC];
        [self presentViewController:examNav animated:YES completion:nil];
    }
    
}



#pragma mark
//
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


//获取历年真题的
- (void)getAllOveryearsByZyid:(NSString*)zyId
{
    NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:zyId,@"zy_id",nil];
    MKNetworkOperation  *op = [m_AppDelegate.networkEngineinstace getdata:dic path:OVERYEARS_GETALLOVERYEAR httpMethod:POST];
    NSLog(@"%@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         NSArray  *dic = [completedOperation responseJSON];
         NSLog(@"%@",dic);
         if (dic && [dic count] > 0) {
             dataSourceArray = [NSArray arrayWithArray:dic];
             [self zuzhuangList:dataSourceArray];
         }
     }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
     {
         
     }];
}

//添加顺序为  先做子节点的内容，并且对应名称 ，在做父节点名称
/*
  Example:  
    NSArray  *array ;
    NSDictionary  *dic = [NSDictionary dictionaryWithObjectsAndKeys:array,@"父节点"];
 */
- (void)zuzhuangList:(NSArray*)array
{
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [array count]; i++) {
        NSArray *tempArr = [[array objectAtIndex:i] objectForKey:@"units"];
        NSMutableArray *childrenArr = [[NSMutableArray alloc]init];
        if (tempArr && [tempArr count]>0) {
            for (int j = 0; j < [tempArr count]; j++) {
                //作子节点的内容
                RADataObject *phone1 = [RADataObject dataObjectWithName:[[tempArr objectAtIndex:j] objectForKey:@"ZTDY_MC"] children:nil];
                
                [childrenArr addObject:phone1];
            }
        }
//        父节点
        RADataObject *phone = [RADataObject dataObjectWithName:[[array objectAtIndex:i] objectForKey:@"LNZT_BT"]
                                                      children:childrenArr];
        [dataArray addObject:phone];
    }
    self.data = dataArray;
    [treeView reloadData];

    

}
@end
