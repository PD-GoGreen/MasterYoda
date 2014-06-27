//
//  MasterYodaTests.m
//  MasterYodaTests
//
//  Created by Pradnya on 4/15/14.
//  Copyright (c) 2014 Pradnya. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HTTPRequestManager.h"
#import "UNIRest.h"

@interface MasterYodaTests : XCTestCase

@end

@implementation MasterYodaTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    // Validate API response is string
    
    NSString* requestString = @"I am MasterYoda";
    if ([requestString length]>0)
    {
        
        UNIHTTPResponse* responseObject = [HTTPRequestManager getSynchMasterYodaResponseForString:requestString];
        NSString* str = [[NSString alloc] initWithData:responseObject.rawBody
                                              encoding:NSUTF8StringEncoding];
        
        
        if (!(str && [str length] > 0)){
            XCTFail(@"Service is returning non-string object");
        }
        
    }
    
}

@end
