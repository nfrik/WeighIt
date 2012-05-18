//
//  PhotoPreviewController.m
//  AVCam
//
//  Created by nikolay on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoPreviewController.h"
#import "AVCamCaptureManager.h"
#import "SHK.h"
#import "GetDeviceType.h"

@implementation PhotoPreviewController

@synthesize imagePreviewView;
@synthesize retakeButton;
@synthesize actionButton;
@synthesize saveButton;
@synthesize imageOperations;
@synthesize touchController;
@synthesize customDrawingView;
@synthesize infoLabel;
@synthesize animalButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization        
    }
    
    if (imageOperations==nil) {
        imageOperations = [[ImageFileOperations alloc] init];
    }
    
    //set notification for new image arrival
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(imageUpdatedNotification:)
     name:@"currentImageSaved"
     object:nil ];
    
    [self loadSelectedAnimal];
    
    return self;
}


-(void)dealloc{
    [imageOperations release];
    [touchController release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //Animal Picker Controller
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAnimalPicker:) name:@"hideAnimalPicker" object:nil];        
    
    [self fakeTouch];    
    
    [super viewDidLoad];
}

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

-(void)viewWillAppear:(BOOL)animated{
    // Do any additional setup after loading the view from its nib.
    //    UIImage *roateImage = [[UIImage alloc] initWithCGImage:[[imageOperations loadImage:@"currentimage"] CGImage] scale:1.0f orientation:UIImageOrientationRight];  
}

-(void)fakeTouch{
    //-------------------FAKE TOUCH-------------------------    
    
    CGPoint tapPoint=CGPointMake(100, 300);    
    
    CGPoint basefrom=[customDrawingView getBaseFromPoint];
    CGPoint baseto=[customDrawingView getBaseToPoint];
    CGPoint girthlower=[customDrawingView getGirthLowerPoint];
    CGPoint girthupper=[customDrawingView getGirthUpperPoint];
    CGPoint ear=[customDrawingView getEarPoint];
    CGPoint tail=[customDrawingView getTailPoint];      
    
    GetDeviceType *deviceType = [[GetDeviceType alloc] init];
    CGPoint deviceAngleOfView=[deviceType AngleOfView];
    float devicex=deviceAngleOfView.x;//device horizontal FOV
    float devicey=deviceAngleOfView.y;//device vertical FOV
    
    float dist=getdistance(lensH, ppvisanglv(basefrom.y, currentPitch,devicey));
    float al=getalpha(dist, lensH);//alpha 1m from to 1 m from ground
    float dal=getdalpha(dist, lensH, 1.0);
    float betbot=getbetta(0.5, dist, al);//betta for 0.5 m
    float bettop=getbetta(0.5, dist, al+dal);//betta for 0.5 m    
    float pixbot=getshiftedx(betbot, devicex, 160);
    float pixtop=getshiftedx(bettop, devicex, 160);    
    float piy=gety(al+dal, devicey, currentPitch);
    
    
    //               [customDrawingView updateBaseLine:CGPointMake(0, tapPoint.y) to:CGPointMake(320, tapPoint.y)];               
    //[customDrawingView updateBaseLine:CGPointMake(160-(pixbot-160), tapPoint.y) to:CGPointMake(pixbot, tapPoint.y)];                           
    //[customDrawingView updateBaseUpLine:CGPointMake(160-(pixtop-160), piy) to:CGPointMake(pixtop, piy)];
    
    
    
    
    
    [self loadSelectedAnimal];
    
    NSString *animal=@"some";
    switch (selectedAnimal) {
        case 0:animal=@"Beef"; break;
        case 1:animal=@"Hog"; break;
        case 2:animal=@"Sheep"; break;
        case 3:animal=@"Horse"; break;            
        default:
            break;
    }
    
    
    infoLabel.text=[NSString stringWithFormat:@"Distance = %2.2f m Girth = %2.2f m Body = %2.2f m \n Weight = %2.2f lb  Weight %2.2f kg %@ %@",
                    getdistance(lensH, ppvisanglv(basefrom.y, currentPitch,devicey)),
                    get2PlaneDistanceOnDistance(girthlower, girthupper, baseto, lensH, currentPitch,devicex,devicey),
                    get2PlaneDistanceOnDistance(ear, tail, baseto, lensH, currentPitch,devicex,devicey),
                    getanimalweight(girthlower, girthupper, ear, tail, baseto, lensH, currentPitch,devicex,devicey,selectedAnimal),
                    getanimalweight(girthlower, girthupper, ear, tail, baseto, lensH, currentPitch,devicex,devicey,selectedAnimal)*0.45359237,
                    [deviceType getDeviceType], animal];
    [deviceType release];    
    //---------------------------------------------       
}

#pragma mark -
#pragma tool bar buttons actions

-(void)toggleRetakeButton:(id)sender{
    [self.view removeFromSuperview];
}

-(void)toggleActionButton:(id)sender{
    
	UIGraphicsBeginImageContext(customDrawingView.frame.size);
	[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();    
    
    // Create the item to share (in this example, a url)    
    SHKItem *item = [SHKItem image:viewImage title:@"Look at this picture!"];  
    
	// Get the ShareKit action sheet
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    
	// Display the action sheet
	[actionSheet showFromBarButtonItem:actionButton animated:YES];
}

-(void)toggleSaveButton:(id)sender{
	UIGraphicsBeginImageContext(customDrawingView.frame.size);
	[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);    
}


-(void)toggleAnimalButton:(id)sender{
    
    if (animalPicker==nil) {
        animalPicker=[[AnimalPickerViewController alloc] init];
        [self.view addSubview:animalPicker.view];
    }
    
    if (animalPicker.isHidden)
        [animalPicker showPopUp];
    else
        [animalPicker hidePopUp];
    
    [self fakeTouch];//recalculate Weight if animal changed
}


-(void)imageUpdatedNotification:(NSNotification*)notification{
    
    UIImage *roateImage = [[UIImage alloc] initWithCGImage:[[AVCamCaptureManager currentImage] CGImage] scale:1.0f orientation:UIImageOrientationRight];    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:roateImage];
    
    [imageView setFrame:imagePreviewView.frame];
    
    [[self imagePreviewView] addSubview:imageView];
    
    [imageView release];      
    
    
    //--init touch controller
    //--------------------------------
    //      [touchView setFrame:[imagePreviewView frame]];
    //       touchController = [[AVCamTouchController alloc] initWithFrame:[[self touchView] bounds]];
    //      [[self imagePreviewView] addSubview:touchController];
    //--------------------------------
    //--------------------------------           
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if([touches count]==1){
        UITouch *touch = [touches anyObject];
        CGPoint tapPoint=[touch locationInView:imagePreviewView];
        NSLog(@"x:%f y:%f",tapPoint.x,tapPoint.y);
        
        float point[6]={[customDrawingView getDistanceBaseFromPoint:tapPoint],
            [customDrawingView getDistanceBaseToPoint:tapPoint],
            [customDrawingView getDistanceGirthUpperPoint:tapPoint],
            [customDrawingView getDistanceGirthLowerPoint:tapPoint],
            [customDrawingView getDistanceEarPoint:tapPoint],
            [customDrawingView getDistanceTailPoint:tapPoint]        };
        int index[6]={0,1,2,3,4,5};
        
        
        for (int i=0; i<5; i++) {
            for (int k=0; k<5; k++) {
                if (point[k]>point[k+1]) {
                    int a=point[k+1];
                    float b=index[k+1];    
                    point[k+1]=point[k];
                    index[k+1]=index[k];
                    point[k]=a;
                    index[k]=b;
                }
            }
        }
        
        
        
        //check if we are in the range for touch
        if (point[0]<20)
            pointnumber=index[0];
        else
            pointnumber=1024;
        
        
        //        switch (pointnumber) {
        //            case 0:
        //                //                   p1x=tapPoint.y/self.frame.size.height*320;
        //                //                   p1y=(1-tapPoint.x/self.frame.size.width)*215;
        //                //pointnumber++;
        //                break;
        //            case 1:
        //                //                   p2x=tapPoint.y/self.frame.size.height*320;
        //                //                   p2y=(1-tapPoint.x/self.frame.size.width)*215;
        //                //pointnumber++;
        //                break;
        //            case 2:
        //                //                   p3x=tapPoint.y/self.frame.size.height*320;
        //                //                   p3y=(1-tapPoint.x/self.frame.size.width)*215;
        //                //pointnumber++;
        //                break;
        //            case 3:
        //                //                   p4x=tapPoint.y/self.frame.size.height*320;
        //                //                   p4y=(1-tapPoint.x/self.frame.size.width)*215;
        //                //pointnumber++;
        //                break;                        
        //            case 4:
        //                //                   p4x=tapPoint.y/self.frame.size.height*320;
        //                //                   p4y=(1-tapPoint.x/self.frame.size.width)*215;
        //                //pointnumber++;
        //                break;
        //            default:
        //                break;
        //        }
        //        if(pointnumber==MAX_POINT_NUMBER)
        //            pointnumber=0;
        //        //need_to_init = 1;
        
        NSLog(@"Touch catch");
        
        //[customDrawingView updateBaseLine:CGPointMake(0, tapPoint.y) to:CGPointMake(320, tapPoint.y)];        
        
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint tapPoint=[touch locationInView:imagePreviewView];    
    
    CGPoint basefrom=[customDrawingView getBaseFromPoint];
    CGPoint baseto=[customDrawingView getBaseToPoint];
    CGPoint girthlower=[customDrawingView getGirthLowerPoint];
    CGPoint girthupper=[customDrawingView getGirthUpperPoint];
    CGPoint ear=[customDrawingView getEarPoint];
    CGPoint tail=[customDrawingView getTailPoint];      
    
    GetDeviceType *deviceType = [[GetDeviceType alloc] init];
    CGPoint deviceAngleOfView=[deviceType AngleOfView];
    float devicex=deviceAngleOfView.x;//device horizontal FOV
    float devicey=deviceAngleOfView.y;//device vertical FOV
    
    float dist=getdistance(lensH, ppvisanglv(basefrom.y, currentPitch,devicey));
    float al=getalpha(dist, lensH);//alpha 1m from to 1 m from ground
    float dal=getdalpha(dist, lensH, 1.0);
    float betbot=getbetta(0.5, dist, al);//betta for 0.5 m
    float bettop=getbetta(0.5, dist, al+dal);//betta for 0.5 m    
    float pixbot=getshiftedx(betbot, devicex, 160);
    float pixtop=getshiftedx(bettop, devicex, 160);    
    float piy=gety(al+dal, devicey, currentPitch);
    
    switch (pointnumber) {
        case 0:
            //               [customDrawingView updateBaseLine:CGPointMake(0, tapPoint.y) to:CGPointMake(320, tapPoint.y)];               
            [customDrawingView updateBaseLine:CGPointMake(160-(pixbot-160), tapPoint.y) to:CGPointMake(pixbot, tapPoint.y)];                           
            [customDrawingView updateBaseUpLine:CGPointMake(160-(pixtop-160), piy) to:CGPointMake(pixtop, piy)];
            break;
        case 1:
            //                [customDrawingView updateBaseLine:CGPointMake(0, tapPoint.y) to:CGPointMake(320, tapPoint.y)];               
            [customDrawingView updateBaseLine:CGPointMake(160-(pixbot-160), tapPoint.y) to:CGPointMake(pixbot, tapPoint.y)];                           
            [customDrawingView updateBaseUpLine:CGPointMake(160-(pixtop-160), piy) to:CGPointMake(pixtop, piy)];
            break;
        case 2:
            [customDrawingView updateGirthUpperPoint:tapPoint];               
            break;
        case 3:
            [customDrawingView updateGirthLowerPoint:tapPoint];                           
            break;
        case 4:
            [customDrawingView updateEarPoint:tapPoint];                           
            break;            
            
        case 5:
            [customDrawingView updateTailPoint:tapPoint];                           
            break;
            
        default:
            break;
    }
    
    [self loadSelectedAnimal];
    
    NSString *animal=@"some";
    switch (selectedAnimal) {
        case 0:animal=@"Beef"; break;
        case 1:animal=@"Hog"; break;
        case 2:animal=@"Sheep"; break;
        case 3:animal=@"Horse"; break;            
        default:
            break;
    }
    
    
    infoLabel.text=[NSString stringWithFormat:@"Distance = %2.2f m Girth = %2.2f m Body = %2.2f m \n Weight = %2.2f lb  Weight %2.2f kg %@ %@",
                    getdistance(lensH, ppvisanglv(basefrom.y, currentPitch,devicey)),
                    get2PlaneDistanceOnDistance(girthlower, girthupper, baseto, lensH, currentPitch,devicex,devicey),
                    get2PlaneDistanceOnDistance(ear, tail, baseto, lensH, currentPitch,devicex,devicey),
                    getanimalweight(girthlower, girthupper, ear, tail, baseto, lensH, currentPitch,devicex,devicey,selectedAnimal),
                    getanimalweight(girthlower, girthupper, ear, tail, baseto, lensH, currentPitch,devicex,devicey,selectedAnimal)*0.45359237,
                    [deviceType getDeviceType], animal];
    [deviceType release];
    
    //    infoLabel.text=[NSString stringWithFormat:@"Distance = %2.2f m Girth Diam = %2.2f",
    //                    getdistance(lensH, ppvisanglv(basefrom.y, currentPitch)),
    //                    //get2PlaneDistanceOnDistance(girthlower, girthupper, baseto, lensH, currentPitch)
    //                    getwidth(getdistance(lensH, ppvisanglv(basefrom.y, currentPitch)), 
    //                    ppvisanglv(girthlower.y, currentPitch), ppvisanglh(girthlower.x))];
    
    //    infoLabel.text=[NSString stringWithFormat:@"Pitch = %2.2f Alpha = %2.2f Betta = %2.2f",
    //                    currentPitch*180/M_PI,
    //                    ppvisanglv(girthlower.y, currentPitch)*180/M_PI,
    //                    ppvisanglh(girthlower.x)*180/M_PI];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

//set current pitch in radians from gyro
-(void)setCurrentPitch:(float)val{
    currentPitch=val;
}

-(void)setLensHeight:(float)val{
    lensH=val;
}

-(void)setFieldOfView:(CGPoint)val{
    currentDeviceFieldOfView=val;
}


//PopUp picker view stuffs
/*
 -(void)initPopUpView{
 
 self.view = [[UIView alloc] initWithFrame:CGRectMake(0,480, 320, 180)];    
 [self.view setBackgroundColor:[UIColor blackColor]];
 [self.view setAlpha:.87];
 
 myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
 myPickerView.delegate = self;
 myPickerView.showsSelectionIndicator = YES;
 [self.view addSubview:myPickerView];
 }
 */

-(void)animatePopUpShow{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(initPopUpView)];
    
    //    animalPickerView.alpha = 1.0;
    //    animalPickerView.frame = CGRectMake(0, 0, 320, 181);
    
    [UIView commitAnimations];    
}

-(void)hidePopUp{
    
}


-(void)hideAnimalPicker:(NSNotification*)notification{
    [animalPicker hidePopUp];
}


//save/load animal
-(void)saveSelectedAnimal{
    NSUserDefaults *standardUserDefaults=[NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setObject:[NSString stringWithFormat:@"%d",selectedAnimal] forKey:@"animal"];
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
            selectedAnimal=selectedRow;
            NSLog(@"%@",@"Animal Loaded");            
        }
    }
}



#pragma mark -
#pragma some math functions


//-(float) ppvisanglv:(float)y pitch:(float)pitch{
//    float ah;
//    ah = 2*atanf((416.0-y)/416.0*tan(currentDeviceFieldOfView.y/180.0*M_PI_2)) + pitch - currentDeviceFieldOfView.y*M_PI_2/180.0;
//    return ah;    
//}
//
//-(float) ppvisanglh:(float)x{
//    float ah;
//    ah = 2*atanf(x/320.0*tan(currentDeviceFieldOfView.x/180.0*M_PI_2));
//    return ah;    
//}


//function to calculate angle for the vertical point
//zero on the bottom
float ppvisanglv(float y, float pitch, float devicey){
    float ah;
    ah = 2*atanf((416.0-y)/416.0*tan(devicey/180.0*M_PI_2)) + pitch - devicey*M_PI_2/180.0;
    return ah;
}

//calculate angle for the horizontal point 
//with zero on the left side
float ppvisanglh(float x, float devicex){
    float ah;
    ah = 2*atanf(x/320.0*tan(devicex/180.0*M_PI_2));
    return ah;
}

//distance
float getdistance(float h, float alpha){
    return h*tanf(alpha);
}

//height
float getheight(float h, float d,float alpha){
    return h+d*tanf(alpha+M_PI_2);
}

//width 
float getwidth(float d, float alpha, float betta){     
    return 2*d/sinf(alpha)*tanf(betta/2.0);
    //return h+d*tanf(betta+M_PI_2);
}


//reversed problem alpha for ground point
float getalpha(float d, float H){
    return atanf(d/H);
}

//reversed problem alpha for altered point
float getdalpha(float d, float H, float h){
    return atanf(d/(H-h))-atanf(d/H);    
}

//reversed problem betta
float getbetta(float w, float d, float alpha){
    //return 2*asinf(w/2/sqrt(pow(H, 2)+pow(d, 2)));
    return 2*atanf(w*sinf(alpha)/(2.0*d));
}

//reversed problem x
float getx(float betta, float devicex){
    return (float)(320*tanf(betta/2.0)/tanf(devicex*M_PI_2/180));
}

//reversed problem x
float getshiftedx(float betta, float devicex, int shift){
    float dx=(int)(320*tanf(betta/2.0)/tanf(devicex*M_PI_2/180));
    return shift+dx;
}

//reversed problem y
float gety(float alpha,float devicey, float pitch){
    return (float)(416*(1-tanf((alpha-pitch+devicey*M_PI_2/180)/2.0)/tanf(devicey*M_PI_2/180)));
}



//get weight for hog
float get2PlaneDistanceOnDistance(CGPoint point1, CGPoint point2, CGPoint baseline, float H, float currentPitch, float devicex, float devicey){    
    //get height over the ground
    float dist=getdistance(H, ppvisanglv(baseline.y, currentPitch,devicey));
    float dy1=getheight(H, dist, ppvisanglv(point1.y, currentPitch,devicey));
    float dy2=getheight(H, dist, ppvisanglv(point2.y, currentPitch,devicey));
    float dx1=getwidth(dist, ppvisanglv(point1.y, currentPitch,devicey), ppvisanglh(point1.x,devicex));
    float dx2=getwidth(dist, ppvisanglv(point2.y, currentPitch,devicey), ppvisanglh(point2.x,devicex));
    
    return sqrtf(powf(dy2-dy1, 2)+powf(dx2-dx1, 2));
}

//get weight for hog
float getanimalweight(CGPoint girthdown, CGPoint girthup, CGPoint ear, CGPoint tail, CGPoint baseline, float H, float currentPitch, float devicex, float devicey, int animal){
    //girth diameter
    float gd=get2PlaneDistanceOnDistance(girthup, girthdown, baseline, H, currentPitch,devicex,devicey)*39.3700787;
    //body length
    float bl=get2PlaneDistanceOnDistance(ear, tail, baseline, H, currentPitch,devicex,devicey)*39.3700787;
    
    int denominator=300;
    
    switch (animal) {
        case 0: denominator = 300; break; //Beef
        case 1: denominator = 400; break; //Hog
        case 2: denominator = 300; break; //Sheep
        case 3: denominator = 330; break; //Horse
        default:
            break;
    }
    
    float weight = (M_PI*gd)*(M_PI*gd)*bl/denominator;
    
    if (animal==1) {
        //add 7 lbs if < 150
        if (weight<150) {
            weight+=7;
        }
    }
    
    return weight;
}

@end
