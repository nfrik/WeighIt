//
//  DrawShapesController.m
//  AVCam
//
//  Created by nikolay on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrawShapesController.h"

@implementation DrawShapesController


- (void)initObject {
    // Initialization code
    [super setBackgroundColor:[UIColor clearColor]];
    
    
    //init base points
    baseFromPoint=CGPointMake(20, 400);
    baseToPoint=CGPointMake(300,400);
    baseUpFromPoint=CGPointMake(20, 200);
    baseUpToPoint=CGPointMake(300, 200);
    girthUpperPoint=CGPointMake(100, 300);
    girthLowerPoint=CGPointMake(100, 350);
    earPoint=CGPointMake(50, 250);
    tailPoint=CGPointMake(270, 300);     
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aCoder {
    if (self = [super initWithCoder:aCoder]) {
        // Initialization code
        [self initObject];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    //shadow parameters
    float glowWidth = 4.0;
    float colorValues[] = { 0, 0, 0, 1.0 };    
    
    // Drawing code
    
    CGContextRef context    = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorSpace(context, CGColorSpaceCreateDeviceRGB());
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef glowColor = CGColorCreate( colorSpace, colorValues );
    CGContextSetShadowWithColor( context, CGSizeMake( 0.0, 0.0 ), glowWidth, glowColor );
    
    
    //--------line between ears and tail-----------
    //---------------------------------------------   
    
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 4.0);    
        
    CGContextMoveToPoint(context, tailPoint.x,tailPoint.y); //start at this point
    
    CGContextAddLineToPoint(context, earPoint.x,earPoint.y); //draw to this point  
    
    // and now draw the Path!
    CGContextStrokePath(context);    

    
    //--------line between ears and tail-----------
    //---------------------------------------------   
    
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 4.0);    
    
    CGContextMoveToPoint(context, girthUpperPoint.x,girthUpperPoint.y); //start at this point
    
    CGContextAddLineToPoint(context, girthLowerPoint.x,girthLowerPoint.y); //draw to this point  
    
    // and now draw the Path!
    CGContextStrokePath(context);    
    
    
    //--------draw base line-----------
    //---------------------------------
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
        
    CGContextMoveToPoint(context, baseFromPoint.x,baseFromPoint.y); //start at this point
    
    CGContextAddLineToPoint(context, baseToPoint.x, baseToPoint.y); //draw to this point    
    
    CGContextAddLineToPoint(context, baseUpToPoint.x, baseUpToPoint.y); //draw to this point    
    
    CGContextAddLineToPoint(context, baseUpFromPoint.x, baseUpFromPoint.y); //draw to this point        
    
    CGContextAddLineToPoint(context, baseFromPoint.x, baseFromPoint.y); //draw to this point        
    
//    CGContextMoveToPoint(context, baseUpToPoint.x,baseUpToPoint.y); //start at this point
//    
//    CGContextAddLineToPoint(context, baseToPoint.x, baseToPoint.y); //draw to this point        
//    
//    CGContextMoveToPoint(context, baseUpFromPoint.x,baseUpFromPoint.y); //start at this point
//    
//    CGContextAddLineToPoint(context, baseFromPoint.x, baseFromPoint.y); //draw to this point            
//    
//    CGContextMoveToPoint(context, baseUpFromPoint.x,baseUpFromPoint.y); //start at this point
//    
//    CGContextAddLineToPoint(context, baseUpToPoint.x, baseUpToPoint.y); //draw to this point        
    
    [[UIColor whiteColor] set];
    [@"Ground" drawInRect:CGRectMake(baseFromPoint.x+4, baseToPoint.y-18, 100, 25) withFont:[UIFont fontWithName:@"HelveticaNeue" size:16.0f]
              lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];
    
    // and now draw the Path!
    CGContextStrokePath(context);
    
        
    //--------draw girth upper point---
    //---------------------------------
    
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint(context, girthUpperPoint.x+2,girthUpperPoint.y); //start at this point
    
    CGContextAddLineToPoint(context, girthUpperPoint.x+20,girthUpperPoint.y); //draw to this point
    
    CGContextMoveToPoint(context, girthUpperPoint.x,girthUpperPoint.y+2); //start at this point
    
    CGContextAddLineToPoint(context, girthUpperPoint.x,girthUpperPoint.y+20); //draw to this point    
    
    CGContextMoveToPoint(context, girthUpperPoint.x-2,girthUpperPoint.y); //start at this point
    
    CGContextAddLineToPoint(context, girthUpperPoint.x-20,girthUpperPoint.y); //draw to this point    
    
    CGContextMoveToPoint(context, girthUpperPoint.x,girthUpperPoint.y-2); //start at this point
    
    CGContextAddLineToPoint(context, girthUpperPoint.x,girthUpperPoint.y-20); //draw to this point            
    
    
    
    
    [[UIColor greenColor] set];
    [@"Girth B" drawInRect:CGRectMake(girthUpperPoint.x+3, girthUpperPoint.y+10, 100, 25) withFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]
               lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];     
     
    
    // and now draw the Path!
    CGContextStrokePath(context);    
    
    
    //--------draw girth lower point---
    //---------------------------------
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint(context, girthLowerPoint.x+2,girthLowerPoint.y); //start at this point
    
    CGContextAddLineToPoint(context, girthLowerPoint.x+20,girthLowerPoint.y); //draw to this point
    
    CGContextMoveToPoint(context, girthLowerPoint.x,girthLowerPoint.y+2); //start at this point
    
    CGContextAddLineToPoint(context, girthLowerPoint.x,girthLowerPoint.y+20); //draw to this point    
    
    CGContextMoveToPoint(context, girthLowerPoint.x-2,girthLowerPoint.y); //start at this point
    
    CGContextAddLineToPoint(context, girthLowerPoint.x-20,girthLowerPoint.y); //draw to this point    
    
    CGContextMoveToPoint(context, girthLowerPoint.x,girthLowerPoint.y-2); //start at this point
    
    CGContextAddLineToPoint(context, girthLowerPoint.x,girthLowerPoint.y-20); //draw to this point            
        
    [[UIColor greenColor] set];
    [@"Girth A" drawInRect:CGRectMake(girthLowerPoint.x+3, girthLowerPoint.y+10, 100, 25) withFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]
               lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];
    
    // and now draw the Path!
    CGContextStrokePath(context);
    
    
    //--------draw ears point ---------
    //---------------------------------
    
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint(context, earPoint.x+2,earPoint.y); //start at this point
    
    CGContextAddLineToPoint(context, earPoint.x+20,earPoint.y); //draw to this point
    
    CGContextMoveToPoint(context, earPoint.x,earPoint.y+2); //start at this point
    
    CGContextAddLineToPoint(context, earPoint.x,earPoint.y+20); //draw to this point    
    
    CGContextMoveToPoint(context, earPoint.x-2,earPoint.y); //start at this point
    
    CGContextAddLineToPoint(context, earPoint.x-20,earPoint.y); //draw to this point    
    
    CGContextMoveToPoint(context, earPoint.x,earPoint.y-2); //start at this point
    
    CGContextAddLineToPoint(context, earPoint.x,earPoint.y-20); //draw to this point
    
    
    [[UIColor greenColor] set];
    [@"Body A" drawInRect:CGRectMake(earPoint.x+3, earPoint.y+10, 100, 25) withFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]
               lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];     
    
    // and now draw the Path!
    CGContextStrokePath(context);
    
    
    //--------draw tail point ---------
    //---------------------------------    
    
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint(context, tailPoint.x+2,tailPoint.y); //start at this point
    
    CGContextAddLineToPoint(context, tailPoint.x+20,tailPoint.y); //draw to this point
    
    CGContextMoveToPoint(context, tailPoint.x,tailPoint.y+2); //start at this point
    
    CGContextAddLineToPoint(context, tailPoint.x,tailPoint.y+20); //draw to this point    
    
    CGContextMoveToPoint(context, tailPoint.x-2,tailPoint.y); //start at this point
    
    CGContextAddLineToPoint(context, tailPoint.x-20,tailPoint.y); //draw to this point    
    
    CGContextMoveToPoint(context, tailPoint.x,tailPoint.y-2); //start at this point
    
    CGContextAddLineToPoint(context, tailPoint.x,tailPoint.y-20); //draw to this point            
    
    
    [[UIColor greenColor] set];
    [@"Body B" drawInRect:CGRectMake(tailPoint.x+3, tailPoint.y+10, 100, 25) withFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]
         lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];     
    
    
    // and now draw the Path!
    CGContextStrokePath(context);
    
    
}


- (void)drawLineFrom:(CGPoint)from to:(CGPoint)to {
//    fromPoint = from;
//    toPoint = to;
    
    // Refresh
    [self setNeedsDisplay];
}


- (void)updateBaseUpLine:(CGPoint)from to:(CGPoint)to{
    baseUpFromPoint=from;
    baseUpToPoint=to;
    [self setNeedsDisplay];
}

- (void)updateBaseLine:(CGPoint)from to:(CGPoint)to{
    
    baseFromPoint=from;
    baseToPoint=to;
    // Refresh
    [self setNeedsDisplay];    
}

- (void)updateGirthUpperPoint:(CGPoint)point{
    girthUpperPoint=point;
    // Refresh
    [self setNeedsDisplay];    
}

- (void)updateGirthLowerPoint:(CGPoint)point{
    girthLowerPoint=point;
    // Refresh
    [self setNeedsDisplay];    
}

- (void)updateEarPoint:(CGPoint)point{
    earPoint=point;
    // Refresh
    [self setNeedsDisplay];    
}

- (void)updateTailPoint:(CGPoint)point{
    tailPoint=point;
    // Refresh
    [self setNeedsDisplay];    
}


- (float)getDistanceBaseUpFromPoint:(CGPoint)point{
    return 0;   
}

- (float)getDistanceBaseUpToPoint:(CGPoint)point{
    return 0;
}

- (float)getDistanceBaseFromPoint:(CGPoint)point{
    return sqrtf(powf(point.y-baseFromPoint.y, 2));
}

- (float)getDistanceBaseToPoint:(CGPoint)point{
    return sqrtf(powf(point.y-baseToPoint.y, 2));    
}
- (float)getDistanceGirthUpperPoint:(CGPoint)point{
    return sqrtf(powf(point.x-girthUpperPoint.x, 2)+powf(point.y-girthUpperPoint.y, 2));    
}
- (float)getDistanceGirthLowerPoint:(CGPoint)point{
    return sqrtf(powf(point.x-girthLowerPoint.x, 2)+powf(point.y-girthLowerPoint.y, 2));    
}
- (float)getDistanceEarPoint:(CGPoint)point{
    return sqrtf(powf(point.x-earPoint.x, 2)+powf(point.y-earPoint.y, 2));
}
- (float)getDistanceTailPoint:(CGPoint)point{
    return sqrtf(powf(point.x-tailPoint.x, 2)+powf(point.y-tailPoint.y, 2));
}


- (CGPoint)getBaseUpFromPoint{
    return baseUpFromPoint;
}

- (CGPoint)getBaseUpToPoint{
    return baseUpToPoint;
}

- (CGPoint)getBaseFromPoint{
    return baseFromPoint;
}
- (CGPoint)getBaseToPoint{
    return baseToPoint;
}
- (CGPoint)getGirthLowerPoint{
    return girthLowerPoint;
}
- (CGPoint)getGirthUpperPoint{
    return girthUpperPoint;
}
- (CGPoint)getEarPoint{
    return earPoint;
}
- (CGPoint)getTailPoint{
    return tailPoint;
}


@end
