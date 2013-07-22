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
@interface NewBankViewController : UIViewController<UIWebViewDelegate,WEPopoverContentViewControllerDelegate,WEPopoverControllerDelegate>
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


    IBOutlet UITextField *fnameTF;
    IBOutlet UITextField *accountNumTF;
    IBOutlet UITextField *bankNameTF;
    IBOutlet UITextField *bankCodeTF;
    IBOutlet UITextField *swiftCodeTF;
    IBOutlet UITextField *routingNumberTF;
    
    
    IBOutlet UITextField *rstreetTF;
    IBOutlet UITextField *rsubburbTF;
    IBOutlet UITextField *rstateTF;
    IBOutlet UITextField *rpostcodeTF;
    IBOutlet UITextField *rCountryTF;
    
    IBOutlet UITextField *rcityTF;

}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;



- (IBAction)rcontry_Click:(id)sender;

- (IBAction)submit_Click:(id)sender;

@end
