//
//  Save.m
//  LockGennerator
//
//  Created by cncsoft on 3/12/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import "Save.h"
#import "Savecell.h"
#import "AppDelegate.h"
@interface Save ()

@end

@implementation Save

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[AppDelegate shareAppDelegate] isTall]) {
            self = [super initWithNibName:[NSString stringWithFormat:@"%@_iphone5",nibNameOrNil] bundle:nibBundleOrNil];
        }else{
            self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        }
    } else {
        self = [super initWithNibName:[NSString stringWithFormat:@"%@_ipad",nibNameOrNil] bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
  [AppDelegate shareAppDelegate].listImage=[[AppDelegate shareAppDelegate] findFiles:@"png"];
    NSLog(@"list image:%@",[AppDelegate shareAppDelegate].listImage);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark - table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[AppDelegate shareAppDelegate].listImage count];
}
- (UITableViewCell*)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *indentifier = @"SaveCell";
    Savecell *cell = (Savecell *)[aTableView dequeueReusableCellWithIdentifier: indentifier];
    if (cell == nil)  {
        NSString *nibname=@"";
        if ([AppDelegate shareAppDelegate].isIpad) {
            nibname=@"Customcell_ipad";
        }
        else{
             nibname=@"Customcell"; 
        }
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibname
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[Savecell class]])
            {
                cell = (Savecell *)oneObject;
            }
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        UIImage *image = [UIImage imageWithContentsOfFile:[[AppDelegate shareAppDelegate].listImage objectAtIndex:indexPath.row]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.picture.image=image;

        });
        
    });
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([AppDelegate shareAppDelegate].isIpad) {
        return 149;
    }
    else
    return 86;
    return 0;
}
#pragma mark-
#pragma mark-selected table
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    //The user is selecting the cell which is currently expanded
   
    
}

- (IBAction)backPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
