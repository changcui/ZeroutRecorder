//
//  timeAxis.h
//  ZeroutRecorder
//
//  Created by cc on 2017/6/25.
//  Copyright © 2017年 hulin. All rights reserved.
//

#ifndef timeAxis_h
#define timeAxis_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "aRecord.h"
#include "recordViewController.h"
#endif /* timeAxis_h */

IB_DESIGNABLE
@interface timeAxis : UIView
{
    
}
@property(nonatomic, assign) int timeWidth;
@property(nonatomic, assign) double lineWidth;
@property(nonatomic, retain) UIColor * color;
@property(nonatomic, retain) aRecord * record;
@property(nonatomic, retain) recordViewController * rVC;
@property(nonatomic, assign) double currentTime;

-(id) initParam;
-(void) setRecord: (aRecord *) record withTime: (double) currentTime_;
@end
