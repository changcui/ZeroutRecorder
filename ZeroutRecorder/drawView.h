//
//  drawView.h
//  ZeroutRecorder
//
//  Created by user on 2017/6/22.
//  Copyright © 2017年 hulin. All rights reserved.
//

#ifndef drawView_h
#define drawView_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#endif /* drawView_h */

@interface DrawView : UIView

@property(nonatomic, assign) CGFloat lineWidth;
@property(nonatomic, retain) UIColor * pathColor;

-(void)clear;
-(void)undo;
-(void)eraser;
//-(void)save;

@end
