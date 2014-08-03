//
//  YunBiJiViewController.m
//  ExamTreasured
//
//  Created by yuan on 14-6-3.
//  Copyright (c) 2014年 yuan. All rights reserved.
//

#import "YunBiJiViewController.h"
#import "ShowBiJiViewController.h"
@interface YunBiJiViewController ()

@end

@implementation YunBiJiViewController
@synthesize treeView;

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
    [super viewDidLoad];
    [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,30,30) target:self action:@selector(backController)];
    [self setNaviTitle:@"复习笔记"];
    [self addNaviRightBtn];

    UIImage *nav_background = [UIImage imageNamed:@"navgation"];
    [self setNaviBackGroundWithImage:nav_background];

    [self setNavgation];
    [self getAllOveryearsByZyid:m_AppDelegate.zy_ID];
    
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
    //    [treeView expandRowForItem:phone withRowAnimation:RATreeViewRowAnimationLeft];
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
    
    if (treeNodeInfo.treeDepthLevel == 2) {
        NSDictionary *tempDic = [[[[[dataSourceArray objectAtIndex:treeNodeInfo.parent.parent.positionInSiblings]  objectForKey:@"ZJ"] objectAtIndex:treeNodeInfo.parent.positionInSiblings]objectForKey:@"minutia"]objectAtIndex:treeNodeInfo.positionInSiblings];
        
        ShowBiJiViewController *next = [[ShowBiJiViewController alloc]initWithDictionary:tempDic];
        UINavigationController *bijiNav = [[UINavigationController alloc]initWithRootViewController:next];
        [self presentViewController:bijiNav animated:YES completion:nil];
        [next creatWebView];
//        ExamTestViewController *examTestVC = [[ExamTestViewController alloc]initWithDictionary:tempDic index:treeNodeInfo.positionInSiblings ];
        
//        UINavigationController *examNav = [[UINavigationController alloc]initWithRootViewController:examTestVC];
//        [self presentViewController:examNav animated:YES completion:nil];
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




- (void)getAllOveryearsByZyid:(NSString*)zyId
{
    NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:zyId,@"zy_id",nil];
    MKNetworkOperation  *op = [m_AppDelegate.networkEngineinstace getdata:dic path:NOTE_GETCHAPTERMINUTIA httpMethod:POST];
    MBProgressHUD  *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         NSArray  *dic = [completedOperation responseJSON];
         NSLog(@"%@",dic);
         if (dic && [dic count] > 0) {
             dataSourceArray = [NSArray arrayWithArray:dic];
             [self zuzhuangList:dic];
         }
         hub.hidden = YES;
     }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
     {
         hub.hidden = YES;
     }];
}
- (void)zuzhuangList:(NSArray*)array
{
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [array count]; i++) {
        NSArray *tempArr = [[array objectAtIndex:i] objectForKey:@"ZJ"];
        NSMutableArray *childrenArr = [[NSMutableArray alloc]init];
        if (tempArr && [tempArr count]>0) {
            for (int j = 0; j < [tempArr count]; j++) {
                NSArray *tempArr1 = [[tempArr objectAtIndex:j] objectForKey:@"minutia"];
                NSMutableArray *childrenArr1 = [[NSMutableArray alloc]init];

                if (tempArr1 && [tempArr1 count]>0) {
                    for (int k = 0; k < [tempArr1 count]; k++) {
                        RADataObject *phone11 = [RADataObject dataObjectWithName:[[tempArr1 objectAtIndex:k] objectForKey:@"XJ_MC"] children:nil];
                        [childrenArr1 addObject:phone11];

                    }
                }
                RADataObject *phone1 = [RADataObject dataObjectWithName:[[tempArr objectAtIndex:j] objectForKey:@"ZJ_MC"] children:childrenArr1];
                [childrenArr addObject:phone1];
            }
        }
        RADataObject *phone = [RADataObject dataObjectWithName:[[array objectAtIndex:i] objectForKey:@"KM_MC"]
                                                      children:childrenArr];
        [dataArray addObject:phone];
    }
    self.data = dataArray;
    [treeView reloadData];
    
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

@end
