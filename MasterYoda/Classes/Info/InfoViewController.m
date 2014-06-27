//
//  InfoViewController.m
//  MasterYoda
//
//  Created by Pradnya on 4/17/14.
//  Copyright (c) 2014 Pradnya. All rights reserved.
//

#import "InfoViewController.h"
#import "SVWebViewController.h"
#import "UIColor+Hex.h"

@implementation InfoViewController

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
    
    self.title = TIPS_VIEW_TITLE;
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:TIPS_CLOSE_BUTTON_TITLE
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(closeButtonClicked)];
    self.navigationItem.rightBarButtonItem = closeButton;
    
    CGRect segmentFrame = CGRectMake(0, 64, self.view.frame.size.width, 44);
    NSArray *itemArray = [NSArray arrayWithObjects: TIPS_VIEW_TITLE, CREDITS_VIEW_TITLE, nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = segmentFrame;
    segmentedControl.tintColor = [UIColor colorWithHexString:COLOR_BLUE_1];
    [segmentedControl addTarget:self
                         action:@selector(segmentChanged)
               forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:segmentedControl];
    [self segmentChanged];
}

- (CGRect)detailsFrame{
    int padding = 10;
    int textFieldWidth = (self.view.frame.size.width - (2*padding));
    return CGRectMake(padding, 103, textFieldWidth, 350);
}

- (void)segmentChanged{
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        [self customizeTipsView];
    }else{
        [self customizeCreditsView];
    }
}

- (void)customizeTipsView{
    
    self.title = TIPS_VIEW_TITLE;
    
    creditsView.hidden = YES;
    
    if (tipsView != nil) {
        tipsView.hidden = NO;
        return;
    }
    
    tipsView = [[UIView alloc] initWithFrame:[self detailsFrame]];
    [self.view addSubview:tipsView];

    CGRect tipsFrame = CGRectMake(0, -20, tipsView.frame.size.width, tipsView.frame.size.height);
    UILabel* tipsLabel = [[UILabel alloc] initWithFrame:tipsFrame];
    tipsLabel.textColor = [UIColor blackColor];
    tipsLabel.numberOfLines = 0;
    tipsLabel.text =
    @"Make sure you use proper english grammar and punctuation,"
    " our little green friend can't read your mind. \"Don't\","
    " instead of \"Dont\", and so on.\n\n"
    " The exception is this: You should use extra punctuation"
    " if a sentence contains more than one clause, often split"
    " with 'and', 'or', etc. For example: \"Put your hands up"
    " and step away from the turnip.\" should be \"Put your"
    " hands up, and step away from the turnip.\" or \"Put"
    " your hands up. Step away from the turnip.\"\n"
    " If using commas and full stops in currencies or"
    " initialisms, do not use spaces.The use of parenthesis"
    " is not y recommended\n\n"
    " The use of parenthesis is not yet recommended.";
    
    [tipsLabel sizeToFit] ;
    tipsLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    [tipsView addSubview:tipsLabel];
}

- (void)customizeCreditsView{
    
    self.title = CREDITS_VIEW_TITLE;
    tipsView.hidden = YES;
        
    if (creditsView != nil) {
        creditsView.hidden = NO;
        return;
    }
    
    creditsView = [[UIView alloc] initWithFrame:[self detailsFrame]];
    [self.view addSubview:creditsView];
    
    int posX = 30;
    int posY = 20;
    int buttonWidth = 260;
    int buttonHeight = 35;
    
    posY += [self createButton:CGRectMake(posX, posY, buttonWidth, buttonHeight)
                         title:MASHAPE_API_TITLE
                           tag:1];
    
    posY += [self createButton:CGRectMake(posX, posY, buttonWidth, buttonHeight)
                         title:YODA_SPEAK_WEBSITE_TITLE
                           tag:2];

    posY += [self createButton:CGRectMake(posX, posY, buttonWidth, buttonHeight)
                         title:UNIREST_TITLE
                           tag:3];

    posY += [self createButton:CGRectMake(posX, posY, buttonWidth, buttonHeight)
                         title:PROGRESS_HUD_TITLE
                           tag:4];
    
    posY += [self createButton:CGRectMake(posX, posY, buttonWidth, buttonHeight)
                         title:EDCOLOR_TITLE
                           tag:5];
    
    posY += [self createButton:CGRectMake(posX, posY, buttonWidth, buttonHeight)
                         title:SVWEBVIEWCONTROLLER_TITLE
                           tag:6];
    
}

- (int)createButton:(CGRect)_frame title:(NSString*)_buttonTitle tag:(int)_buttonTag{
    
    int padding = 5;
    
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:_buttonTitle];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:FONT_REGULAR
                                                                           size:15],
                                      NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                                      NSForegroundColorAttributeName:[UIColor blackColor]}
                              range:[_buttonTitle rangeOfString:_buttonTitle]];
    
    UIButton* creditsButton = [[UIButton alloc] initWithFrame:_frame];
    creditsButton.tag = _buttonTag;
    creditsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    creditsButton.titleLabel.numberOfLines = 0;
    [creditsButton setAttributedTitle:attributedString
                             forState:UIControlStateNormal];
    [creditsButton addTarget:self
                      action:@selector(linkClicked:)
            forControlEvents:UIControlEventTouchUpInside];
    [creditsView addSubview:creditsButton];
    
    return _frame.size.height + padding;
    
}

- (void)linkClicked:(UIButton*)_button{
    
    NSString* link;
    
    if (_button.tag == 1) {
        link = MASHAPE_API_DOC_URL;
    } else if (_button.tag == 2) {
        link = YODA_SPEAK_WEBSITE_URL;
    } else if (_button.tag == 3) {
        link = UNIREST_URL;
    } else if (_button.tag == 4) {
        link = PROGRESS_HUD_URL;
    } else if (_button.tag == 5) {
        link = EDCOLOR_URL;
    } else {
        link = SVWEBVIEWCONTROLLER_URL;
    }
    
    SVWebViewController* webViewController = [[SVWebViewController alloc] initWithAddress:link];
    [self.navigationController pushViewController:webViewController
                                         animated:YES];
    
}

- (void)closeButtonClicked{
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
