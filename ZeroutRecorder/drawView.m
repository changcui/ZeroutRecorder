//
//  drawView.m
//  ZeroutRecorder
//
//  Created by user on 2017/6/22.
//  Copyright © 2017年 hulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "drawView.h"
#import "drawPath.h"

@interface DrawView()

@property(nonatomic, strong)DrawPath * path;
@property(nonatomic, strong)NSMutableArray * pathArray;

@end

@implementation DrawView

- (void)awakeFromNib{
    
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    for (DrawPath * path in self.pathArray) {
        [path.pathColor set];
        [path stroke];
    }
}

-(NSMutableArray *)pathArray {
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}


#pragma mark - Init

-(void)setUp{
    UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    [self addGestureRecognizer:panGestureRecognizer];
    
    self.lineWidth = 1;
    self.pathColor = [UIColor blackColor];
}

#pragma mark - Event

-(void)panGestureRecognizer:(UIGestureRecognizer *)ges{
    CGPoint startPoint = [ges locationInView:self];
    if (ges.state == UIGestureRecognizerStateBegan) {
        _path = [[DrawPath alloc] init];
        _path.lineWidth = _lineWidth;
        _path.pathColor = _pathColor;
        [_path moveToPoint:startPoint];
        [self.pathArray addObject:_path];
    }
    [_path addLineToPoint:startPoint];
    [self setNeedsDisplay];
}

#pragma mark - Method

-(void)clear {
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}

-(void)undo {
    [self.pathArray removeLastObject];
    [self setNeedsDisplay];
}

-(void)eraser {
    self.pathColor = [UIColor whiteColor];
    [self setNeedsDisplay];
}


@end





