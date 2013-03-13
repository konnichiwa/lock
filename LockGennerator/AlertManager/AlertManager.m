//
//  AlertManager.m
//  UBizCharge
//
//  Created by Web Factory on 3/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlertManager.h"

int const kAlertDialogVoid = 100;

@implementation AlertManager

@synthesize delegate, currentAlert;

-(AlertManager*)init:(id)pDelegate{
	
   	self.delegate = pDelegate;
	displayedLoadingAlerts = 0;
	return self;
	
}


	
    -(void)showAlertLoading:(NSString*) message{
        
        if (displayedLoadingAlerts > 0) 
        {
            [self dismissCurrentAlert];
        }
        
        currentAlert = [[[UIAlertView alloc] initWithTitle:message message:nil delegate:self.delegate cancelButtonTitle:nil otherButtonTitles: nil] autorelease];
        [currentAlert show];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        // Adjust the indicator so it is up a few pixels from the bottom of the alert
        indicator.center = CGPointMake(currentAlert.bounds.size.width / 2, currentAlert.bounds.size.height - 50);
        [indicator startAnimating];
        [currentAlert addSubview:indicator];
        [indicator release];
        displayedLoadingAlerts++;
        
    }

	
	


-(void)showAlertWithPositiveButton:(NSString*) message WithTag:(int)tag{
	
	currentAlert = [[[UIAlertView alloc] initWithTitle:message message:nil delegate:self.delegate cancelButtonTitle:@"OK" otherButtonTitles: nil] autorelease];
	currentAlert.tag = tag;
	[currentAlert show];
}

-(void)showAlertWithPositiveButtonAndNegativeButton:(NSString*) message WithTag:(int)tag
{
	
	currentAlert = [[[UIAlertView alloc] initWithTitle:message message:nil delegate:self.delegate cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] autorelease];
	currentAlert.tag = tag;
	[currentAlert show];
	//[memo release];
}

-(void)showAlertWithPositiveButtonAndNegativeButtonYoutube:(NSString*) message WithTag:(int)tag
{
	
	currentAlert = [[[UIAlertView alloc] initWithTitle:message message:nil delegate:self.delegate cancelButtonTitle:@"Cancel" otherButtonTitles:@"Link My Account", nil] autorelease];
	currentAlert.tag = tag;
	[currentAlert show];
	//[memo release];
}

-(void)showAlertWithPositiveButtonAndNegativeButton:(NSString*)message title:(NSString*)title WithTag:(int)tag
{
    currentAlert = [[[UIAlertView alloc] initWithTitle:title message:message delegate:self.delegate cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] autorelease];
	currentAlert.tag = tag;
	[currentAlert show];
	//[memo release];
}

-(void)showAlertWithContinueButtonAndCancelButton:(NSString*) message WithTag:(int)tag
{
	
	currentAlert = [[[UIAlertView alloc] initWithTitle:message message:nil delegate:self.delegate cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil] autorelease];
	currentAlert.tag = tag;
	[currentAlert show];
	//[memo release];
	
	
}

-(void)showAlertWithAcceptButtonAndRejectButton:(NSString*) message WithTag:(int) tag
{
    currentAlert = [[[UIAlertView alloc] initWithTitle:message message:nil delegate:self.delegate cancelButtonTitle:@"Reject" otherButtonTitles:@"Accept", nil] autorelease];
    currentAlert.tag = tag;
    [currentAlert show];
}

-(void)showBatchCloseAlert:(NSString*)message{
	
	currentAlert = [[[UIAlertView alloc] initWithTitle:message message:nil delegate:self.delegate cancelButtonTitle:@"Cancel" otherButtonTitles:@"Proceed", nil] autorelease];
	currentAlert.tag = 0;
	[currentAlert show];
	
}

-(void)showVoidAlert:(NSString*)message{
	
	
	currentAlert = [[[UIAlertView alloc] initWithTitle:message message:nil delegate:self.delegate cancelButtonTitle:@"Cancel" otherButtonTitles:@"View Details",@"Void", nil] autorelease];
	currentAlert.tag = 0;
	[currentAlert show];

}

-(void)showDeleteTransactionAlert:(NSString*)message{
	
	currentAlert = [[[UIAlertView alloc] initWithTitle:message message:nil delegate:self.delegate cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil] autorelease];
	currentAlert.tag = 0;
	[currentAlert show];
}

-(void)dismissCurrentAlert{
    
	if (currentAlert && currentAlert!=NULL && displayedLoadingAlerts > 0) {
		[currentAlert dismissWithClickedButtonIndex:0 animated:NO];
        currentAlert = nil;
        currentAlert = NULL;
        displayedLoadingAlerts--;
        
	}
	
	
}


@end
