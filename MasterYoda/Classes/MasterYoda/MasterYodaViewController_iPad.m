//
//  MasterYodaViewController_iPad.m
//  MasterYoda
//
//  Created by Pradnya on 4/15/14.
//  Copyright (c) 2014 Pradnya. All rights reserved.
//

#import "MasterYodaViewController_iPad.h"

@interface MasterYodaViewController_iPad ()

@end

@implementation MasterYodaViewController_iPad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int padding = 20;
    int textFieldWidth = (self.view.frame.size.width - (2*padding));
    
    inputTextField.frame = CGRectMake(padding, 100, textFieldWidth, 40);
    infoButton.frame = CGRectMake(textFieldWidth, 69, 30, 30);
    
    int submitWidth = (textFieldWidth- (textFieldWidth/2));
    int submitX = (self.view.frame.size.width - submitWidth)/2;
    submitButton.frame = CGRectMake(submitX, 170,submitWidth, 30);
    resultLabel.frame = CGRectMake(padding, 220, textFieldWidth, 30);
    outputBackground.frame = CGRectMake(padding, 250, textFieldWidth, 200);
    
    int labelPadding = 5;
    int labelWidth = textFieldWidth - (2*labelPadding);
    outputLabel.frame = CGRectMake(padding + labelPadding, 255,labelWidth, 190);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
