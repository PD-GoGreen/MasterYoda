//
//  MAShapeResponseObject.h
//  MasterYoda
//
//  Created by Pradnya on 5/22/14.
//  Copyright (c) 2014 Pradnya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAShapeResponse : NSObject

@property (nonatomic, strong) NSString* message;

- (instancetype)initWithDictionary:(NSDictionary*)_dictionary;

@end
