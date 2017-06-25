//
//  timeAxis.m
//  ZeroutRecorder
//
//  Created by cc on 2017/6/25.
//  Copyright © 2017年 hulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "timeAxis.h"
#include "showDetailViewController.h"
@implementation timeAxis
-(instancetype)initParam {
    self = [super init];
    self.timeWidth = 6;
    self.lineWidth = 1.0;
    return self;
}

-(void)setRecord: (aRecord *) record withTime:(double) currentTime_ {
    self.record = record;
    self.currentTime = currentTime_;

}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //add point
    double startTime = _currentTime - (_timeWidth*1000/2);
    int startIntPoint = (int)(startTime/1000);
    //NSLog(@"the start point is %d", startIntPoint);
    double pix = self.bounds.size.width/(1000*_timeWidth);
    for(int i = 0; i <= 6; i ++) {
        int pointToDraw = startIntPoint + (int)i;
        double x = ((pointToDraw*1000 - startTime)*pix);
        double y = self.bounds.size.height/2;
        if(pointToDraw >= 0 && pointToDraw*1000 <= (_currentTime + _timeWidth*1000/2)) {
            
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%02d:%02d",pointToDraw/60,pointToDraw%60]];
            [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]  range:NSMakeRange(0,5)];
            [text drawAtPoint:CGPointMake(x, y)];
        }
    }
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //add label for text
    
    for(NSNumber * key in _record.getTextNoteDic)
    {
        if([key intValue] < startIntPoint || [key intValue] > (_currentTime/1000 + _timeWidth/2)){
            break;
        }
    //    NSLog(@"the key is %@,and the text string is %@",key,[_record.getTextNoteDic objectForKey:key]);
        UIButton * button = [[UIButton alloc] init];
        [button setTitle:@"T" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor blackColor]];
        double size = self.bounds.size.height/4;
        button.frame = CGRectMake((([key intValue]*1000 - startTime)*pix),self.bounds.size.height/6 , size, size);
        [self addSubview: button];
        
        button.tag = [key integerValue];
        [button addTarget:self
                   action:@selector(event1:)
         forControlEvents: UIControlEventTouchUpInside];
    }
    //add label for photo
    for(NSNumber * key in _record.getPhotoNoteDic)
    {
        if([key intValue] < startIntPoint || [key intValue] > (_currentTime/1000 + _timeWidth/2)){
            break;
        }
    //    NSLog(@"the key is %@,and the text string is %@",key,[_record.getPhotoNoteDic objectForKey:key]);
        UIButton * button = [[UIButton alloc] init];
        [button setTitle:@"P" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor blackColor]];
        double size = self.bounds.size.height/4;
        button.frame = CGRectMake((([key intValue]*1000 - startTime)*pix),self.bounds.size.height/6 , size, size);
        [self addSubview: button];
        
        button.tag = [key integerValue];
        [button addTarget:self
                   action:@selector(event2:)
         forControlEvents: UIControlEventTouchUpInside];
        
    }
    //add label for draw
    for(NSNumber * key in _record.getDrawNoteDic)
    {
        if([key intValue] < startIntPoint || [key intValue] > (_currentTime/1000 + _timeWidth/2)){
            break;
        }
   //     NSLog(@"the key is %@,and the text string is %@",key,[_record.getDrawNoteDic objectForKey:key]);
        UIButton * button = [[UIButton alloc] init];
        [button setTitle:@"D" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor blackColor]];
        double size = self.bounds.size.height/4;
        button.frame = CGRectMake((([key intValue]*1000 - startTime)*pix),self.bounds.size.height/6 , size, size);
        [self addSubview: button];
        
        button.tag = [key integerValue];
        [button addTarget:self
                   action:@selector(event3:)
         forControlEvents: UIControlEventTouchUpInside];
    }
    //add axis
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextMoveToPoint(context, 0, self.bounds.size.height/2);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height/2);
    CGContextMoveToPoint(context, self.bounds.size.width/2, 0);
    CGContextAddLineToPoint(context, self.bounds.size.width/2, self.bounds.size.height);
    CGContextStrokePath(context);
}
-(void) event1:(UIButton *) btn {
    
    showDetailViewController * detailVC;
    NSNumber * num = [NSNumber numberWithInteger:  btn.tag];
    detailVC = [[showDetailViewController alloc] initWithImage: [[UIImage alloc] init]
                                                      withText: [_record.getTextNoteDic objectForKey: num]
                                                      withType: @"text"];
    NSLog(@"the num is %@,the text is %@",num,[_record.getTextNoteDic objectForKey: num]);
    [self.rVC.navigationController pushViewController:detailVC animated:NO];
}
-(void) event2:(UIButton *) btn {
    
    showDetailViewController * detailVC;
    NSNumber * num = [NSNumber numberWithInteger:  btn.tag];
    detailVC = [[showDetailViewController alloc] initWithImage: [_record.getPhotoNoteDic objectForKey: num]
                                                      withText: @""
                                                      withType: @"picture"];
    [self.rVC.navigationController pushViewController:detailVC animated:YES];
}
-(void) event3:(UIButton *) btn {
    
    showDetailViewController * detailVC;
    NSNumber * num = [NSNumber numberWithInteger:  btn.tag];
    detailVC = [[showDetailViewController alloc] initWithImage: [_record.getDrawNoteDic objectForKey: num]
                                                      withText: @""
                                                      withType: @"picture"];
    [self.rVC.navigationController pushViewController:detailVC animated:YES];
}
@end

