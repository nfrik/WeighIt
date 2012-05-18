//
//  DrawShapesController.h
//  AVCam
//
//  Created by nikolay on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawShapesController : UIView{
           CGPoint baseUpFromPoint;
           CGPoint baseUpToPoint;
           CGPoint baseFromPoint;
           CGPoint baseToPoint;
    
           CGPoint girthUpperPoint;
           CGPoint girthLowerPoint;
           CGPoint earPoint;
           CGPoint tailPoint;    
}

- (void)drawLineFrom:(CGPoint)from to:(CGPoint)to;

- (void)updateBaseUpLine:(CGPoint)from to:(CGPoint)to;

- (void)updateBaseLine:(CGPoint)from to:(CGPoint)to;

- (void)updateGirthUpperPoint:(CGPoint)point;

- (void)updateGirthLowerPoint:(CGPoint)point;

- (void)updateEarPoint:(CGPoint)point;

- (void)updateTailPoint:(CGPoint)point;


- (float)getDistanceBaseUpFromPoint:(CGPoint)point;
- (float)getDistanceBaseUpToPoint:(CGPoint)point;
- (float)getDistanceBaseFromPoint:(CGPoint)point;
- (float)getDistanceBaseToPoint:(CGPoint)point;
- (float)getDistanceGirthUpperPoint:(CGPoint)point;
- (float)getDistanceGirthLowerPoint:(CGPoint)point;
- (float)getDistanceEarPoint:(CGPoint)point;
- (float)getDistanceTailPoint:(CGPoint)point;

- (CGPoint)getBaseUpFromPoint;
- (CGPoint)getBaseUpToPoint;
- (CGPoint)getBaseFromPoint;
- (CGPoint)getBaseToPoint;
- (CGPoint)getGirthLowerPoint;
- (CGPoint)getGirthUpperPoint;
- (CGPoint)getEarPoint;
- (CGPoint)getTailPoint;

@end
