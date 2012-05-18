//
//  derivatives.c
//  LucasKanadeV1
//
//  Created by nikolay on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "derivatives.h"


//test function to calculate angle of the point
float ppvisangl(float y, float pitch){
    float ah;
    ah = 2*atanf((416-y)/416*tan(55.7/180*M_PI_2)) + pitch - 55.7*M_PI_2/180;    
    return ah;
}

//distance
float getdistance(float h, float alpha){
    return h*tanf(alpha);
}

//height
float getheight(float h, float d,float alpha){
    return h-d*tanf(alpha);
}
