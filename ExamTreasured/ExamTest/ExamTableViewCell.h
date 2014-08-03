//
//  ExamTableViewCell.h
//  ExamTreasured
//
//  Created by mac on 14-6-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamTableViewCell : UITableViewCell
@property (strong,nonatomic)UIButton  *selectbtn;
@property (strong,nonatomic)UILabel   *answerlabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tag:(long)tag flatStr:(NSString *)flatStr;
@end
