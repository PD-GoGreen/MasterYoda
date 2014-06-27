//
//  MasterYodaViewController_iPhoneViewController.m
//  MasterYoda
//
//  Created by Pradnya on 4/15/14.
//  Copyright (c) 2014 Pradnya. All rights reserved.
//

#import "MasterYodaViewController.h"
#import "HTTPRequestManager.h"
#import "MAShapeResponse.h"
#import "ProgressHUD.h"
#import "InfoViewController.h"
#import "UIColor+Hex.h"
#import <Social/Social.h>

@implementation MasterYodaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = MASTER_YODA_VIEW_TITLE;
    
    [self createView];
}

- (void)createView{
    
    UIView* inputBackground = [[UIView alloc] initWithFrame:CGRectZero];
    inputBackground.backgroundColor = [UIColor clearColor];
    inputBackground.layer.borderColor = [UIColor blackColor].CGColor;
    inputBackground.layer.borderWidth = 1;
    inputBackground.layer.cornerRadius = 8;
    [self.view addSubview:inputBackground];
    
    inputTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    inputTextField.backgroundColor = [UIColor clearColor];
    inputTextField.placeholder = INPUT_TEXT_PLACEHOLDER;
    inputTextField.returnKeyType = UIReturnKeyDone;
    inputTextField.delegate = self;
    inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    inputTextField.font = [UIFont fontWithName:FONT_REGULAR size:15];
    [self.view addSubview:inputTextField];
    
    UIButton* submitButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [submitButton addTarget:self
                     action:@selector(submitClicked)
           forControlEvents:UIControlEventTouchUpInside];
    [submitButton setTitle:SUBMIT_BUTTON_TITLE forState:UIControlStateNormal];
    submitButton.backgroundColor = [UIColor colorWithHexString:COLOR_GREEN_1];
    submitButton.layer.cornerRadius = 8;
    submitButton.layer.borderWidth = 1;
    submitButton.layer.borderColor = [UIColor grayColor].CGColor;
    submitButton.clipsToBounds = YES;
    submitButton.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:15];
    [self.view addSubview:submitButton];
    
    UILabel* resultMessage = [[UILabel alloc] initWithFrame:CGRectZero];
    resultMessage.BackgroundColor=[UIColor clearColor];
    resultMessage.textColor = [UIColor colorWithHexString:COLOR_BLUE_1];
    resultMessage.text = RESULTS_MESSAGE_TITLE;
    resultMessage.font = [UIFont fontWithName:FONT_REGULAR size:15];
    [self.view addSubview:resultMessage];
    
    UIView* outputBackground = [[UIView alloc] initWithFrame:CGRectZero];
    outputBackground.backgroundColor = [UIColor clearColor];
    outputBackground.layer.borderColor = [UIColor blackColor].CGColor;
    outputBackground.layer.borderWidth = 1;
    outputBackground.layer.cornerRadius = 8;
    [self.view addSubview:outputBackground];
    
    outputLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    outputLabel.BackgroundColor=[UIColor clearColor];
    outputLabel.text = @"";
    outputLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    outputLabel.numberOfLines = 0;
    [outputLabel sizeToFit];
    [self.view addSubview:outputLabel];
    
    UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [infoButton addTarget:self
                   action:@selector(infoClicked)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoButton];
    
    UIButton* copyButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [copyButton addTarget:self
                   action:@selector(copyClicked)
         forControlEvents:UIControlEventTouchUpInside];
    [copyButton setTitle:COPY_RESPONSE_BUTTON_TITLE forState:UIControlStateNormal];
    copyButton.backgroundColor = [UIColor colorWithHexString:COLOR_GREEN_1];
    copyButton.layer.cornerRadius = 8;
    copyButton.layer.borderWidth = 1;
    copyButton.layer.borderColor = [UIColor grayColor].CGColor;
    copyButton.clipsToBounds = YES;
    copyButton.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:15];
    [self.view addSubview:copyButton];
    
    UIButton* facebookButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [facebookButton addTarget:self
                       action:@selector(facebookClicked)
             forControlEvents:UIControlEventTouchUpInside];
    UIImage *facebookImage = [UIImage imageNamed:FACEBOOK_BUTTON_IMAGE_NAME];
    [facebookButton setImage:facebookImage forState:UIControlStateNormal];
    [self.view addSubview:facebookButton];
    
    UIButton* twitterButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [twitterButton addTarget:self
                      action:@selector(twitterClicked)
            forControlEvents:UIControlEventTouchUpInside];
    UIImage *twitterImage = [UIImage imageNamed:TWITTER_BUTTON_IMAGE_NAME];
    [twitterButton setImage:twitterImage forState:UIControlStateNormal];
    [self.view addSubview:twitterButton];
    
    int padding = 20;
    int textFieldWidth = (self.view.frame.size.width - (2*padding));
    
    inputBackground.frame = CGRectMake(padding, 100, textFieldWidth, 40);
    inputTextField.frame = CGRectMake(padding+5, 100, textFieldWidth, 40);
    infoButton.frame = CGRectMake(textFieldWidth, 69, 30, 30);
    
    int submitWidth = 200;
    int submitX = (self.view.frame.size.width - submitWidth)/2;
    submitButton.frame = CGRectMake(submitX, 165,submitWidth, 40);
    resultMessage.frame = CGRectMake(padding, 220, textFieldWidth, 30);
    outputBackground.frame = CGRectMake(padding, 250, textFieldWidth, 170);
    
    int labelPadding = 5;
    int labelWidth = textFieldWidth - (2*labelPadding);
    outputLabel.frame = CGRectMake(padding + labelPadding, 255,labelWidth, 160);
    copyButton.frame = CGRectMake(padding, 430,150,40);
    twitterButton.frame = CGRectMake(200, 430,40,40);
    facebookButton.frame = CGRectMake(255, 430,40,40);
}


- (void)submitClicked{
    
    [inputTextField resignFirstResponder];
    
    NSString* requestString = inputTextField.text;
    
    if ([requestString length] > 0){
        [ProgressHUD show:PROGRESS_HUD_MESSAGE];
        
        [HTTPRequestManager getASynchMasterYodaResponseForString:requestString
                                                       withBlock:^(MAShapeResponse* response, BOOL success) {
            [self handleServiceResponse:response success:success];
        }];
    }
}

- (void)handleServiceResponse:(MAShapeResponse*)_response success:(BOOL)_success{

    [ProgressHUD dismiss];
    
    if (_success && _response != nil && _response.message != nil) {
        
        outputLabel.text = _response.message;
        [outputLabel sizeToFit];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ERROR_ALERT_TITLE
                                                        message:ERROR_ALERT_MESSAGE
                                                       delegate:nil
                                              cancelButtonTitle:ERROR_ALERT_CANCEL_TITLE
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [inputTextField resignFirstResponder];
    return YES;
}


- (void)infoClicked{
    
    InfoViewController *info = [[InfoViewController alloc] init];
    UINavigationController *infoNav = [[UINavigationController alloc] initWithRootViewController:info];
    [self presentViewController:infoNav
                       animated:YES
                     completion:nil];
}

- (void)facebookClicked{
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [controller setInitialText:outputLabel.text];
    [self presentViewController:controller
                       animated:YES
                     completion:Nil];
}

- (void)twitterClicked{
    
    SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweetSheet setInitialText:outputLabel.text];
    [self presentViewController:tweetSheet
                       animated:YES
                     completion:nil];
}

- (void)copyClicked{
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = outputLabel.text;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:COPY_RESPONSE_ALERT_MESSAGE
                                                   delegate:nil
                                          cancelButtonTitle:COPY_RESPONSE_ALERT_CANCEL_TITLE
                                          otherButtonTitles:nil];
    [alert show];
}

@end