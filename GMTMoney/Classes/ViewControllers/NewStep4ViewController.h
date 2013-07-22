//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NewStep4ViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIScrollView *scrollView;
    NSArray *searchByArray;
    NSArray *beneList;
    int currentIndex;
    NSArray *searchList;
    NSArray *countryList;
    IBOutlet UITableView *searchTableView;
    int selectedSender;
    NSIndexPath *selectedIndexPath;
    
    IBOutlet UITextField *sNameTF;
    IBOutlet UITextField *dobTF;
    
    IBOutlet UITextField *nationTF;
    IBOutlet UITextField *scompanyTF;
    IBOutlet UITextField *sindentTF;
    IBOutlet UITextField *sPContact;
    IBOutlet UITextField *sSContactTF;
    IBOutlet UITextField *sEmailTF;
    IBOutlet UITextField *sRAddressTF;
    IBOutlet UITextField *sBAddressTF;
    IBOutlet UITextField *sPAddress;
    
    IBOutlet UITextField *bFullNameTF;
    IBOutlet UITextField *bCNameTF;
    IBOutlet UITextField *bIndentTF;
    IBOutlet UITextField *bPContact;
    IBOutlet UITextField *bSContactTF;
    IBOutlet UITextField *bEmailTF;
    IBOutlet UITextField *bAddressTF;
    
    IBOutlet UITextField *bankNameTF;
    IBOutlet UITextField *BCode1TF;
    IBOutlet UITextField *BCode2TF;
    IBOutlet UITextField *BCode3TF;
    IBOutlet UITextField *bankAddressTF;
    IBOutlet UITextField *accountHolderTF;
    IBOutlet UITextField *accountNumberTF;
    
    IBOutlet UITextField *paymentAmountTF;
    IBOutlet UITextField *commissionTF;
    IBOutlet UITextField *transferAmountTF;
    IBOutlet UITextField *exchangeRateTF;
    IBOutlet UITextField *FAmountTF;
    IBOutlet UITextView *commentTV;
    
    IBOutlet UIButton *btnAccept;
    IBOutlet UIView *bottomView;
    IBOutlet UIView *bankDetailView;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;

- (IBAction)next_Click:(id)sender;
- (IBAction)submit_Click:(id)sender;
- (IBAction)accept_Click:(id)sender;

@end
