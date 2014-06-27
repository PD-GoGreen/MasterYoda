//
//  HTTPRequestManager.m
//  MasterYoda
//
//  Created by Pradnya on 4/16/14.
//  Copyright (c) 2014 Pradnya. All rights reserved.
//

#import "HTTPRequestManager.h"
#import "UNIRest.h"
#import "UNIHTTPJsonResponse.h"
#import "UNISimpleRequest.h"
#import "MAShapeResponse.h"

static NSString * const BaseURLString = @"https://yoda.p.mashape.com/yoda";
static NSString * const MasterYodaOnlineAPIKey = @"M79FOD81uGlydgqnvZ1VmFG9F3dqK2Ws";


@implementation HTTPRequestManager

+ (NSDictionary*)getHeader{
    return @{@"X-Mashape-Authorization": @"M79FOD81uGlydgqnvZ1VmFG9F3dqK2Ws"};
}

+ (NSString*)getEncodedURLString:(NSString*)string{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                    (CFStringRef)string,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8 ));
    
    NSString *urlString =[NSString stringWithFormat:@"https://yoda.p.mashape.com/yoda?sentence=%@",encodedString];
    
    return urlString;
    
}

+ (void)getASynchMasterYodaResponseForString:(NSString*)requestString
                                   withBlock:(void (^)(MAShapeResponse* responseObject, BOOL success))block {
    
    [[UNIRest get:^(UNISimpleRequest* request) {
        
        [request setUrl:[HTTPRequestManager getEncodedURLString:requestString]];
        [request setHeaders:[HTTPRequestManager getHeader]];
        
    }] asJsonAsync:^(UNIHTTPJsonResponse* response, NSError *error) {
        
        MAShapeResponse* responseObject = nil;
        BOOL responseStatus = NO;
        
        if (response.code == 200 || response.rawBody != nil || [response.rawBody length] != 0) {
            
            NSString* responseString = [[NSString alloc] initWithData:response.rawBody encoding:NSUTF8StringEncoding];
            responseObject = [[MAShapeResponse alloc] initWithDictionary:@{MASHAPE_API_RESPONSE_KEY: responseString}];
            responseStatus = YES;
        }
        
        block(responseObject,responseStatus);
        
    }];
    
}


@end