//
//  FourDigital.h
//  LockGennerator
//
//  Created by luan on 3/6/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourDigital : UIViewController<UIAlertViewDelegate>
{
    int r;
    NSString *resutlStr;
    BOOL enableInput;
}

@property (retain, nonatomic) IBOutlet UIButton *practisePress;

@property (retain, nonatomic) IBOutlet UILabel *numText;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *numBtn;
@property (retain, nonatomic) IBOutlet UIButton *praBtn;
@property (retain, nonatomic) IBOutlet UIButton *clearbtn;

- (IBAction)numPress:(id)sender;
- (IBAction)generatePress:(id)sender;
- (IBAction)practisePress:(id)sender;
- (IBAction)clearPress:(id)sender;

@end
