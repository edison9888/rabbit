//
//  ChangePassword.m
//  rabbitSister
//
//  Created by Jahnny on 13-12-5.
//  Copyright (c) 2013年 ownerblood. All rights reserved.
//

#import "ChangePassword.h"

@implementation ChangePassword

-(void)change:(NSString *)oldpass
         newpass:(NSString *)newpass
      conpass:(NSString *)conpass
         success:(requesterSuccess)success
          failed:(requesterFailed)failed
{
    PSSFileOperations *writeOperation=[[PSSFileOperations alloc] init];
    NSMutableDictionary *registInfo=[[NSMutableDictionary alloc] initWithContentsOfFile:[writeOperation mainPath:[NSString stringWithFormat:@"%@.plist",WRITELOGIN]]];
    
    NSMutableDictionary   *postDic=[[NSMutableDictionary alloc] init];
    [postDic setObject:[registInfo objectForKey:@"usercode"] forKey:@"usercode"];
    [postDic setObject:[registInfo objectForKey:@"userkey"] forKey:@"userkey"];
    [postDic setObject:@"user.ChangePass" forKey:@"initWithMethod"];
    [postDic setObject:@"1" forKey:@"useRpc"];
    [postDic setObject:oldpass forKey:@"oldpass"];
    [postDic setObject:newpass forKey:@"newpass"];
    [postDic setObject:conpass forKey:@"conpass"];
    
    [[RabbitMKNetwork sharedHTTPClient:@"t"] requestWithMethod:@"user.php" parameter:postDic delegate:self HTTPType:BaseHTTPClient_POST];
    
    self.requesterSuccessBlock = success;
    self.requesterFailedBlock = failed;
}

@end