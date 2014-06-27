//
//  MAShapeResponseObject.m
//  MasterYoda
//
//  Created by Pradnya on 5/22/14.
//  Copyright (c) 2014 Pradnya. All rights reserved.
//

#import "MAShapeResponse.h"

@implementation MAShapeResponse

- (instancetype)initWithDictionary:(NSDictionary*)_dictionary{
    
    self = [super init];
    
    if (self) {
        
        if (_dictionary[MASHAPE_API_RESPONSE_KEY] != nil) {
            self.message = _dictionary[MASHAPE_API_RESPONSE_KEY];
        }
    }
    
    return self;
}

@end
