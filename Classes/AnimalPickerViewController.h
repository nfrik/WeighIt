//
//  AnimalPickerViewController.h
//  weigh it
//
//  Created by nikolay on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimalPickerViewController : UIViewController <UIPickerViewDelegate>{
    UIPickerView *myPickerView;    
    BOOL isHidden;
}

@property (nonatomic,assign) BOOL isHidden;

-(void)showPopUp;
-(void)hidePopUp;
-(void)saveSelectedAnimal;
-(void)loadSelectedAnimal;

@end
