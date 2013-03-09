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
}
@property (retain, nonatomic) IBOutlet UILabel *labelText;
@property (retain, nonatomic) IBOutlet UIPickerView *mypicker1;
@property (retain, nonatomic) IBOutlet UIPickerView *mypicker2;
@property (retain, nonatomic) IBOutlet UIPickerView *mypicker3;
@property (retain, nonatomic) IBOutlet UIPickerView *mypicker4;
- (IBAction)genePress:(id)sender;
@end
