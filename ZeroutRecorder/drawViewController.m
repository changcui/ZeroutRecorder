//
//  drawViewController.m
//  ZeroutRecorder
//
//  Created by user on 2017/6/22.
//  Copyright © 2017年 hulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "drawViewController.h"
#import "drawView.h"

@interface drawViewController()

@property(nonatomic, weak)IBOutlet DrawView * drawView;
@property(nonatomic, strong) UIImage * drawViewImage;

@end

@implementation drawViewController

-(void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Event

- (IBAction)changeLineWidth:(UISlider *)sender {
    _drawView.lineWidth = sender.value;
}

- (IBAction)changePathColor:(UIButton *)sender {
    _drawView.pathColor = sender.backgroundColor;
}

- (IBAction)clearAll:(id)sender {
    [_drawView clear];
}

- (IBAction)undoDraw:(id)sender {
    [_drawView undo];
}

- (IBAction)eraserDraw:(id)sender {
    [_drawView eraser];
}

- (IBAction)saveDraw:(id)sender {
    //get image from drawView
    UIGraphicsBeginImageContextWithOptions(_drawView.bounds.size, _drawView.opaque, 0.0);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    [_drawView.layer renderInContext:currentContext];
    _drawViewImage = UIGraphicsGetImageFromCurrentImageContext();
    if (self.returnImageBlock != nil) {
        self.returnImageBlock(_drawViewImage);
    }
    UIGraphicsEndImageContext();
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)returnImage:(ReturnImageBlock)block {
    self.returnImageBlock = block;
}

@end
