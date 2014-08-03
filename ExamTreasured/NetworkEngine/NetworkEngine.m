//
//  NetworkEngine.m
//  ExamTreasured
//
//  Created by mac on 14-5-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//


#import "NetworkEngine.h"

@implementation NetworkEngine
- (MKNetworkOperation*)getdata:(NSDictionary*)params path:(NSString*)pathStr httpMethod:(NSString*)httpMethod
{
    MKNetworkOperation *op = [self operationWithPath:pathStr params:params httpMethod:httpMethod];
    [self enqueueOperation:op];
    return op;
}
@end
