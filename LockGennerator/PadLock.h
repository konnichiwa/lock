//
//  PadLock.h
//  LockGennerator
//
//  Created by luan on 3/6/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PadLock : UIViewController
{
    NSString *randomNum;
    BOOL timeTocheck;
    NSString *getPickerTag;
}
@property (retain, nonatomic) IBOutlet UIView *viewPicker;
@property (retain, nonatomic) IBOutlet UILabel *labelText;
@property (retain, nonatomic) IBOutlet UIPickerView *mypicker1;
@property (retain, nonatomic) IBOutlet UIPickerView *mypicker2;
@property (retain, nonatomic) IBOutlet UIPickerView *mypicker3;
@property (retain, nonatomic) IBOutlet UIButton *clearbtn;
@property (retain, nonatomic) IBOutlet UIButton *practisebtn;
@property (retain, nonatomic) IBOutlet UIPickerView *mypicker4;
@property (retain, nonatomic) IBOutlet UIView *overLayer;
- (IBAction)genePress:(id)sender;
- (IBAction)clearPress:(id)sender;
- (IBAction)practisePress:(id)sender;
- (IBAction)settingPress:(id)sender ;
@end
