//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEPopoverController.h"
#import "WEPopoverContentViewController.h"
@interface NewSenderViewController : UIViewController<UIWebViewDelegate,WEPopoverContentViewControllerDelegate,WEPopoverControllerDelegate>
{
    WEPopoverController *popoverController;
    id selectedTF;
    NSArray *countryList;
    NSMutableArray *currentList;
    int nationIndex;
    
    NSArray *indentifyList;
    int identIndex;
    
    NSArray *stateList;
    int rstateIndex;
    int pstateIndex;
    
    UIDatePicker *datepicker;
    UIActionSheet *actionsheet;
    NSIndexPath *selectedIndex;
    int rCountryIndex;
    int pCountryIndex;
    
    
    NSArray *contactList;
    int pContactIndex;
    int sContactIndex;
    
    NSArray *sourceList;
    int sourceIndex;
    BOOL isFinish;
    IBOutlet UIScrollView *scrollView;
UIView *activeField;

    IBOutlet UITextField *fnameTF;
    IBOutlet UITextField *snameTF;
    IBOutlet UITextField *bnameTF;
    IBOutlet UITextField *dateofbirthTF;
    IBOutlet UITextField *nationTF;
    IBOutlet UITextField *identificationTF;
    IBOutlet UITextField *idnumTF;
    IBOutlet UITextField *idExpiredTF;
    IBOutlet UITextField *idIssuerTF;
    IBOutlet UITextField *occupation;
    
    IBOutlet UITextField *rstreetTF;
    IBOutlet UITextField *rsubburbTF;
    IBOutlet UITextField *rstateTF;
    IBOutlet UITextField *rpostcodeTF;
    IBOutlet UITextField *rCountryTF;
    
    IBOutlet UIButton *pSameAboveBT;
    IBOutlet UITextField *pstreetTF;
    IBOutlet UITextField *psubburbTF;
    IBOutlet UITextField *pstateTF;
    IBOutlet UITextField *ppostcodeTF;
    IBOutlet UITextField *pCountryTF;
    IBOutlet UITextField *pContact1;
    IBOutlet UITextField *pContact2TF;
    IBOutlet UITextField *sContact1TF;
    IBOutlet UITextField *sContact2TF;
    IBOutlet UITextField *emailTF;
    IBOutlet UIButton *acceptBT;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;

- (IBAction)dateofbirth_Click:(id)sender;
- (IBAction)nation_Click:(id)sender;
- (IBAction)ident_Click:(id)sender;

- (IBAction)idexpired_Click:(id)sender;
- (IBAction)rstart_Click:(id)sender;
- (IBAction)rcontry_Click:(id)sender;
- (IBAction)sameabove_Click:(id)sender;
- (IBAction)pstate_Click:(id)sender;
- (IBAction)pcountry_Click:(id)sender;
- (IBAction)pcontact_Click:(id)sender;
- (IBAction)sContact_Click:(id)sender;
- (IBAction)accept_Click:(id)sender;
- (IBAction)submit_Click:(id)sender;

@end
