//
//  BaseViewController.m
//  MasterYoda
//
//  Created by Pradnya on 5/2/14.
//  Copyright (c) 2014 Pradnya. All rights reserved.
//

#import "BaseViewController.h"
#import "UIColor+Hex.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:COLOR_GRAY_1];
	// Do any additional setup after loading the view.
}


@end
