//
//  AlertManager.h
//  UBizCharge
//
//  Created by Web Factory on 3/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern int const kAlertDialogVoid;

@interface AlertManager : NSObject {
	
	id delegate;
	UIAlertView* currentAlert;
    int displayedLoadingAlerts;
	
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) UIAlertView* currentAlert;

-(AlertManager*)init:(id)pDelegate;
-(void)showAlertLoading:(NSString*) message;
-(void)showAlertWithPositiveButton:(NSString*) message WithTag:(int)tag;
-(void)showAlertWithPositiveButtonAndNegativeButton:(NSString*)message title:(NSString*)title WithTag:(int)tag;
-(void)showAlertWithPositiveButtonAndNegativeButton:(NSString*) message WithTag:(int) tag;
-(void)showAlertWithContinueButtonAndCancelButton:(NSString*) message WithTag:(int)tag;
-(void)showAlertWithAcceptButtonAndRejectButton:(NSString*) message WithTag:(int) tag;
-(void)showVoidAlert:(NSString*)message;
-(void)showBatchCloseAlert:(NSString*)message;
-(void)showDeleteTransactionAlert:(NSString*)message;
-(void)showAlertWithPositiveButtonAndNegativeButtonYoutube:(NSString*) message WithTag:(int)tag;
-(void)dismissCurrentAlert;

@end
