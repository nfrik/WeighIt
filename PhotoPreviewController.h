//
//  PhotoPreviewController.h
//  AVCam
//
//  Created by nikolay on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageFileOperations.h"
#import "AVCamTouchController.h"
#import "DrawShapesController.h"
#import "AnimalPickerViewController.h"

@interface PhotoPreviewController : UIViewController<UIPickerViewDelegate> {
    BOOL mouseSwiped;
    float currentPitch;
     int pointnumber;    
    float lensH;
    CGPoint currentDeviceFieldOfView;
    AnimalPickerViewController *animalPicker;
    int selectedAnimal;
    //animalPickerController *animalPickerView;
    //UIPickerView *myPickerView;
}

//@property (nonatomic,retain) DrawShapesController *customDrawing;
@property (nonatomic,retain) AVCamTouchController *touchController;
@property (nonatomic,retain) ImageFileOperations* imageOperations;
@property (nonatomic,retain) IBOutlet UIView *imagePreviewView;
@property (nonatomic,retain) IBOutlet DrawShapesController *customDrawingView;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *retakeButton;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *actionButton;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *saveButton;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *animalButton;
@property (nonatomic,retain) IBOutlet UILabel* infoLabel;


-(IBAction)toggleRetakeButton:(id)sender;
-(IBAction)toggleActionButton:(id)sender;
-(IBAction)toggleSaveButton:(id)sender;
-(IBAction)toggleAnimalButton:(id)sender;

-(void)setCurrentImage:(UIImage*)image;
-(void)imageUpdatedNotification:(NSNotification *)notification;
-(void)setCurrentPitch:(float)val;
-(void)setLensHeight:(float)val;
-(void)setFieldOfView:(CGPoint)val;


-(void)initPopUpView;
-(void)animatePopUpShow;
-(void)hidePopUp;

-(void)hideAnimalPicker:(NSNotification*)notification;

-(void)fakeTouch;

//Save/Load selected animal
-(void)saveSelectedAnimal;
-(void)loadSelectedAnimal;

//-(float) ppvisanglv:(float)y pitch:(float)pitch;
//
//-(float) ppvisanglh:(float)x;

//@@deprecated: use Objective-C
//test function to calculate angle of the point vertical
float ppvisanglv(float y, float pitch, float devicey);

//@@deprecated: use Objective-C
//test function to calculate angle of the point horizontal
float ppvisanglh(float x,float devicex);

//distance
float getdistance(float h, float alpha);

//height
float getheight(float h, float d,float alpha);

//width
float getwidth(float d, float alpha, float betta);

//--------REVERSED PROBLEM-------------

//reversed problem alpha
float getalpha(float d, float H);

//reversed problem alpha
float getdalpha(float d, float H, float h);

//reversed problem betta
float getbetta(float w, float d, float alpha);

//reversed problem x
float getx(float betta, float devicex);

//reversed problem x
float getshiftedx(float betta, float devicex, int shift);

//reversed problem y
float gety(float alpha,float devicey, float pitch);

//--------------------------------------

//get weight for hog
float get2PlaneDistanceOnDistance(CGPoint point1, CGPoint point2, CGPoint baseline, float H, float currentPitch, float devicex, float devicey);

//get weight for hog
float getanimalweight(CGPoint girthdown, CGPoint girthup, CGPoint ear, CGPoint tail, CGPoint baseline, float H, float currentPitch,float devicex, float devicey, int animal);

@end
