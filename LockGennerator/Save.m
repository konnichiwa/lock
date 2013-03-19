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
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [AppDelegate shareAppDelegate].listImage=[[AppDelegate shareAppDelegate] findFiles:@"png"];
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [_popupView release];
    [_imageView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [self setPopupView:nil];
    [self setImageView:nil];
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
    static NSString *indentifier = @"SaveCell";
    Savecell *cell = (Savecell *)[aTableView dequeueReusableCellWithIdentifier: indentifier];
    cell=nil;
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
    NSString* path = [[AppDelegate shareAppDelegate].listImage objectAtIndex:indexPath.row];
    if ([AppDelegate shareAppDelegate].isIpad) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            UIImage *image = [UIImage imageWithContentsOfFile:path];

           UIImage *thumb=[[self crop:image withFrame:CGRectMake(0, 45, 768, 690)] retain];
            UIImage *thumb1=[self resizeImage:thumb withFrame:CGRectMake(0, 0, 768, 690)];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.picture.image=thumb1;
            });
            
        });
    }else
    {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        UIImage *thumb=nil;
        if ([[AppDelegate shareAppDelegate] isTall]) {
            thumb=[[self crop:image withFrame:CGRectMake(0, 45, 320, 370)] retain];
        }else{
        thumb=[[self crop:image withFrame:CGRectMake(0, 45, 320, 320)] retain];
        }
        UIImage *thumb1=[self resizeImage:thumb withFrame:CGRectMake(0, 0, 320 , 320)];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.picture.image=thumb1;
        });
        
    });
    }
    
    
    NSFileManager* fm = [NSFileManager defaultManager];
    NSDictionary* attrs = [fm attributesOfItemAtPath:path error:nil];
    NSArray *temp=[path componentsSeparatedByString:@"/"];
    cell.nametext.text=[temp lastObject];
    float sizeMbFile=[[attrs objectForKey:NSFileSize] floatValue]/1024/1024;
    cell.sizeText.text=[NSString stringWithFormat:@"%0.2fMb",sizeMbFile];
    
    NSDate *dateCreate=[attrs objectForKey:NSFileCreationDate];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:usLocale];
    NSString *stringFromDate = [formatter stringFromDate:dateCreate];
    
    cell.dateText.text=stringFromDate;
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"h:mm a"];
    NSString *stringFromDate1 = [formatter stringFromDate:dateCreate];
    cell.timeText.text=stringFromDate1;
    [formatter release];
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
    [self showpopupmenu];
    NSString* path = [[AppDelegate shareAppDelegate].listImage objectAtIndex:indexPath.row];
    _imageView.image=[UIImage imageWithContentsOfFile:path];
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    //The user is selecting the cell which is currently expanded
    
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString* path = [[AppDelegate shareAppDelegate].listImage objectAtIndex:indexPath.row];
        [[NSFileManager defaultManager] removeItemAtPath: path error: nil];
        [[AppDelegate shareAppDelegate].listImage removeObjectAtIndex:indexPath.row];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}
- (IBAction)backPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if ([touch view]==_popupView){
        [self hidepopupmenu];
    }
}
#pragma mark-show hide popup menu
-(void)showpopupmenu
{
    _popupView.alpha=0;
    _popupView.frame=self.view.frame;
    [self.view addSubview:_popupView];
    [UIView animateWithDuration:0.6
                          delay:0.1
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         _popupView.alpha=1.0;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
}
-(void)hidepopupmenu
{
    [UIView animateWithDuration:0.3
                          delay:0.1
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         _popupView.alpha=0.0;
                     }
                     completion:^(BOOL finished){
                         [_popupView removeFromSuperview];
                         
                     }];
    
}
#pragma mark-crop image
- (UIImage *)resizeImage:(UIImage *)oldImage withFrame:(CGRect)frame {
    UIImage *newImage = oldImage;
    CGSize itemSize = frame.size;
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect =frame;
    [oldImage drawInRect:imageRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *)crop:(UIImage *)oldImage withFrame:(CGRect)frame {
    float scale=[UIScreen mainScreen].scale;
    scale=1.0;
    NSLog(@"scale;%f",scale);
    CGRect newFrame=CGRectMake(frame.origin.x*scale, frame.origin.y*scale, frame.size.width*scale, frame.size.height*scale);
      NSLog(@"frame;%@",NSStringFromCGRect(newFrame));
    // Create a new image in quartz with our new bounds and original ne
    CGImageRef tmp = CGImageCreateWithImageInRect([oldImage CGImage], newFrame);
    
    // Pump our cropped image back into a UIImage object
    UIImage *newImage = [UIImage imageWithCGImage:tmp];
    
    // Be good memory citizens and release the memory
    CGImageRelease(tmp);
    return newImage;
}
@end
