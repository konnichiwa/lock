//
//  AlphaNum.h
//  LockGennerator
//
//  Created by luan on 3/6/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlphaNum : UIViewController
{
    NSString *letters;
    NSString *rcode;
    NSString *resutlStr;
}
@property (retain, nonatomic) IBOutlet UILabel *textLabel;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *btnNum;
@property (retain, nonatomic) IBOutlet UIButton *geneBtn;
@property (retain, nonatomic) IBOutlet UIButton *pracBtn;
@property (retain, nonatomic) IBOutlet UIButton *clearBtn;

- (IBAction)btnPress:(id)sender;
- (IBAction)geneCode:(id)sender;
- (IBAction)practisePress:(id)sender;
- (IBAction)clearPress:(id)sender;
@end
