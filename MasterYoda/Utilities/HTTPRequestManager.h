//
//  HTTPRequestManager.h
//  MasterYoda
//
//  Created by Pradnya on 4/16/14.
//  Copyright (c) 2014 Pradnya. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MAShapeResponse;

@interface HTTPRequestManager : NSObject

+ (void)getASynchMasterYodaResponseForString:(NSString*)requestString
                                   withBlock:(void (^)(MAShapeResponse* responseObject, BOOL success))block;

@end