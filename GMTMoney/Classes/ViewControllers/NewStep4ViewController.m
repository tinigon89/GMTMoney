//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 ;. All rights reserved.
//

#import "NewStep4ViewController.h"
#import "AppDelegate.h"
#import "define.h"
#import "ServiceManager.h"
#import "SuccessViewController.h"
@interface NewStep4ViewController ()

@end

@implementation NewStep4ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView.contentSize = CGSizeMake(320, 2500);
    selectedSender = -1;
	// Do any additional setup after loading the view, typically from a nib.
    //scrollView.contentSize = CGSizeMake(320, 660);
    //[self registerForKeyboardNotifications];
    searchByArray = [[NSArray alloc] initWithObjects:@"FirstName",@"Sur name",@"Company Name",@"Phone", nil];
    beneList = [[NSUserDefaults standardUserDefaults] objectForKey:kBeneInfo];
    countryList = [[NSUserDefaults standardUserDefaults] objectForKey:kCountryList];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];    
}

- (void)viewDidAppear:(BOOL)animated

{
    [super viewDidAppear:YES];
    
    
    // Setup sender
    NSArray *senderList = [[NSUserDefaults standardUserDefaults] objectForKey:kSenderInfo];
    NSString *senderID = [[NSUserDefaults standardUserDefaults] objectForKey:kSenderID];
    NSArray *tempArray = [senderList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SendersID = %@",senderID]];
    if ([tempArray count] > 0) {
        NSDictionary *tempDict = [tempArray objectAtIndex:0];
        sNameTF.text = [NSString stringWithFormat:@"%@ %@",[tempDict objectForKey:@"FName"],[tempDict objectForKey:@"SurName"]];
        NSString *dateString = [tempDict objectForKey:@"DBirth"];
        dateString = [dateString stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
        dateString = [dateString substringToIndex:10];
        double rtimeInterval = [dateString doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:rtimeInterval];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"d-MMM-y"];
        dobTF.text = [dateFormatter stringFromDate:date];
        NSString * nationID = [[tempDict objectForKey:@"NationID"] stringValue];
        NSArray *countryArray = [countryList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CountryID = %@",nationID]];
        if ([countryArray count] > 0) {
            NSDictionary *tempNation = [countryArray objectAtIndex:0];
            nationTF.text = [tempNation objectForKey:@"CountryName"];
        }
        scompanyTF.text = [tempDict objectForKey:@"BisName"];
        sindentTF.text = [tempDict objectForKey:@"IdCode"];
        sPContact.text = [tempDict objectForKey:@"PContact"];
        sSContactTF.text = [tempDict objectForKey:@"SContact"];
        sEmailTF.text = [tempDict objectForKey:@"Email"];
        NSString *country = @"";
        countryArray = [countryList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CountryID = %@",[tempDict objectForKey:@"RCountryID"]]];
        
        if ([countryArray count] > 0) {
            NSDictionary *tempNation = [countryArray objectAtIndex:0];
            country = [tempNation objectForKey:@"CountryName"];
        }
        
        sRAddressTF.text = [NSString stringWithFormat:@"%@ %@,%@,%@,%@",[tempDict objectForKey:@"RStreet"],[tempDict objectForKey:@"RSub"],[tempDict objectForKey:@"RState"],[tempDict objectForKey:@"RPost"],country];
        
        country = @"";
        countryArray = [countryList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CountryID = %@",[tempDict objectForKey:@"PCountryID"]]];
        
        if ([countryArray count] > 0) {
            NSDictionary *tempNation = [countryArray objectAtIndex:0];
            country = [tempNation objectForKey:@"CountryName"];
        }
        sPAddress.text = [NSString stringWithFormat:@"%@ %@,%@,%@,%@",[tempDict objectForKey:@"PStreet"],[tempDict objectForKey:@"PSub"],[tempDict objectForKey:@"PState"],[tempDict objectForKey:@"PPost"],country];
    }
    
    NSArray *beneListInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kBeneInfo];
    NSString *beneID = [[NSUserDefaults standardUserDefaults] objectForKey:kBeneID];
    tempArray = [beneListInfo filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"BeneficiaryID = %@",beneID]];
    if ([tempArray count] > 0) {
        NSDictionary *tempDict = [tempArray objectAtIndex:0];
        bFullNameTF.text = [NSString stringWithFormat:@"%@ %@",[tempDict objectForKey:@"FirstN"],[tempDict objectForKey:@"SurN"]];
        bCNameTF.text = [tempDict objectForKey:@"CompN"];
        bIndentTF.text = [tempDict objectForKey:@"IDNo"];
        bPContact.text = [tempDict objectForKey:@"PCont"];
        bSContactTF.text = [tempDict objectForKey:@"SCont"];
        bEmailTF.text = [tempDict objectForKey:@"Emails1"];
        
        tempArray = [countryList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CountryID = %@",[tempDict objectForKey:@"CountryID"]]];
        NSString *country = @"";
        if ([tempArray count] > 0) {
            NSDictionary *tempDict = [tempArray objectAtIndex:0];
            country = [tempDict objectForKey:@"CountryName"];
        }
        
        bAddressTF.text = [NSString stringWithFormat:@"%@ %@,%@,%@,%@",[tempDict objectForKey:@"AddL1"],[tempDict objectForKey:@"Cityy"],[tempDict objectForKey:@"States"],[tempDict objectForKey:@"PostCode"],country];
    }
    
    int paytype = [[[NSUserDefaults standardUserDefaults] objectForKey:kPaymentType] intValue];
    if (paytype == 2) {
        NSDictionary *bankDict = [[NSUserDefaults standardUserDefaults] objectForKey:kSelectedBank];
        bankNameTF.text = [bankDict objectForKey:@"BankName"];
        BCode1TF.text = [bankDict objectForKey:@"BankCode"];
        BCode2TF.text = [bankDict objectForKey:@"SwiftCode"];
        BCode3TF.text = [bankDict objectForKey:@"RouteNo"];
        tempArray = [countryList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CountryID = %@",[bankDict objectForKey:@"CountryID"]]];
        NSString *country = @"";
        if ([tempArray count] > 0) {
            NSDictionary *tempDict = [tempArray objectAtIndex:0];
            country = [tempDict objectForKey:@"CountryName"];
        }
        
        bankAddressTF.text = [NSString stringWithFormat:@"%@ %@,%@,%@,%@,%@",[bankDict objectForKey:@"Branch1"],[bankDict objectForKey:@"Branch2"],[bankDict objectForKey:@"City"],[bankDict objectForKey:@"State"],[bankDict objectForKey:@"PostCode"],country];
        accountHolderTF.text = [bankDict objectForKey:@"AcHolderName"];
        accountNumberTF.text = [bankDict objectForKey:@"ACNo"];
    }
    else
    {
        bankDetailView.hidden = YES;
        CGRect frame = bottomView.frame;
        frame.origin.y -= bankDetailView.frame.size.height;
        bottomView.frame = frame;
    }
    paymentAmountTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:kPayAmount];
    commissionTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:kLessCommision];
    transferAmountTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:kTransferAmount];
    exchangeRateTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:kEXRate];
    FAmountTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:kFAmount];
    commentTV.text = [[NSUserDefaults standardUserDefaults] objectForKey:kComment];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)home_click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)next_Click:(id)sender {
}

- (IBAction)submit_Click:(id)sender {
    if (!btnAccept.selected)
    {
        [Util showAlertWithString:@"Please must agree to continue!"];
        return;
    }
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
    NSString *regid = [dict objectForKey:@"RegisterID"];
    int utype = [[dict objectForKey:@"UType"] intValue];
    int online = 0;
    if (utype == 0) {
        online = 1;
    }
    NSString *remid = [[NSUserDefaults standardUserDefaults] objectForKey:kRemitID];
    NSString *sid = [[NSUserDefaults standardUserDefaults] objectForKey:kSenderID];
    NSString *beneId = [[NSUserDefaults standardUserDefaults] objectForKey:kBeneID];
    int paytype = [[[NSUserDefaults standardUserDefaults] objectForKey:kPaymentType] intValue];
    NSString *bankID = @"0";
    if (paytype == 2) {
        bankID = [[NSUserDefaults standardUserDefaults] objectForKey:kBankID];
    }
    BOOL result = [ServiceManager submitStep4:regid remid:remid sid:sid benID:beneId bnkID:bankID paytype:paytype online:online];
    [SVProgressHUD dismiss];
    if (result) {

            SuccessViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SuccessViewController"];
            [self.navigationController pushViewController:viewController animated:YES];
        
    
    }

    
}

- (IBAction)accept_Click:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (!button.selected) {
        button.selected = YES;
    }
    else
    {
        button.selected = NO;
    }
}

- (void)showProcess
{
    [SVProgressHUD showWithStatus:@"Loading"];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
