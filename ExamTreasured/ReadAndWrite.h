//
//  ReadAndWrite.h
//  ExamTreasured
//
//  Created by mac on 14-5-26.
//  Copyright (c) 2014年 mac. All rights reserved.
//


//   "zy_id" = 2;

#import <Foundation/Foundation.h>

@interface ReadAndWrite : NSObject

-(id)init;

-(NSMutableDictionary *)readPlistFile;

- (void)writePlistFile:(NSDictionary*)writeDic;

-(BOOL)deleteDocument;
@end
