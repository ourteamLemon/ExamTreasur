//
//  CapionTableviewCell.h
//  ExamTreasured
//
//  Created by mac on 14-7-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ExamTableViewCell.h"

@interface CapionTableviewCell : ExamTableViewCell
@property (strong ,nonatomic) UIButton *rightOrWrongBtn;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tag:(long)tag flatStr:(NSString *)flatStr;
@end
