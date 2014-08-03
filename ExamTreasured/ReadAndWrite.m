//
//  ReadAndWrite.m
//  ExamTreasured
//
//  Created by mac on 14-5-26.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ReadAndWrite.h"
@implementation ReadAndWrite
-(id)init
{
    self = [super init];
    return self;
}

-(NSMutableDictionary *)readPlistFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *readPlistPath = [plistPath1 stringByAppendingString:@"/examplist.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:readPlistPath];
    return  data;
}

- (void)writePlistFile:(NSDictionary*)writeDic
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *readPlistPath = [plistPath1 stringByAppendingString:@"/examplist.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:readPlistPath];
    if (!data) {
        data = [[NSMutableDictionary alloc]init];
    }

    NSArray *writeArray = [writeDic allKeys];
    for ( int i = 0; i < [writeDic allKeys].count;i++)
    {
        NSString *tempstr = [writeDic objectForKey:writeArray[i]];
        [data setObject:tempstr forKey:writeArray[i]];
    }
    
    NSLog(@"%@",data);
   if([data writeToFile:readPlistPath atomically:YES])
   {
       NSLog(@"成功");
   }
   else
   {
       NSLog(@"%@", data);
   }
}

-(BOOL)deleteDocument
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *readPlistPath = [plistPath1 stringByAppendingString:@"/examplist.plist"];
    NSFileManager *fileManager = NSFileManager.new;
    if ([fileManager fileExistsAtPath:readPlistPath])
    {
        [fileManager delegate];
        return  YES;
    }
    return NO;
    
}
@end
