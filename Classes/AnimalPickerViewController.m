//
//  AnimalPickerViewController.m
//  weigh it
//
//  Created by nikolay on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AnimalPickerViewController.h"

@implementation AnimalPickerViewController

@synthesize isHidden;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        // Custom initialization
//      myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 480, 320, 180)];
//      myPickerView.delegate = self;
//      myPickerView.showsSelectionIndicator = YES;
//      [self.view addSubview:myPickerView];        
    }
    return self;
}

-(id)init{    
    if (self==[super init]) {
        
    //currently is hidden
        isHidden=YES;
        
    self.view = [[[UIView alloc] initWithFrame:CGRectMake(0,480, 320, 180)] autorelease];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view setAlpha:.87];
    
    // Custom initialization
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    [self.view addSubview:myPickerView];            
        
    [self loadSelectedAnimal];
        
    }    
    return self;    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)showPopUp{
    CGRect frame = self.view.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.75];
    //frame.origin.y = 256;
    frame.origin.y = 256;
    self.view.frame = frame;
    
    isHidden=NO;
}

-(void)hidePopUp{
    CGRect frame = self.view.frame;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.75];    
    
    frame.origin.y=480;
    self.view.frame=frame;
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    [UIView commitAnimations];
    
    isHidden=YES;
}


-(void)dealloc{
    if ([self.view superview]) {
        [self.view removeFromSuperview];
        [myPickerView release];
        [super dealloc];
    }
}

#pragma mark -
#pragma Picker Delegates

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"hideAnimalPicker"
//     object:nil ];    
    [self saveSelectedAnimal];
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = 4;
    
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    
    switch (row) {
        case 0:title=@"Beef Cattle"; break;
        case 1:title=@"Hogs"; break;
        case 2:title=@"Sheep and Goats"; break;
        case 3:title=@"Horses"; break;
            
        default:
            break;
    }
    
    //title = [@"" stringByAppendingFormat:@"%d",row];
    
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}


//save/load animal
-(void)saveSelectedAnimal{
    NSUserDefaults *standardUserDefaults=[NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setObject:[NSString stringWithFormat:@"%d",[myPickerView selectedRowInComponent:0]] forKey:@"animal"];
        [standardUserDefaults synchronize];
        NSLog(@"%@",@"Animal Saved");
    }
    
}

//save/load height
-(void)loadSelectedAnimal{
    NSUserDefaults *standardUserDefaults=[NSUserDefaults standardUserDefaults];
    NSInteger selectedRow;
    if (standardUserDefaults) {
        selectedRow=[[standardUserDefaults objectForKey:@"animal"] integerValue];
        if (selectedRow<10) {
            [myPickerView selectRow:selectedRow inComponent:0 animated:NO];
            NSLog(@"%@",@"Animal Loaded");            
        }
    }
}

@end
