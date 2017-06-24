//
//  drawViewController.h
//  ZeroutRecorder
//
//  Created by user on 2017/6/22.
//  Copyright © 2017年 hulin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnImageBlock)(UIImage *showImage);
@interface drawViewController : UIViewController
@property (nonatomic, copy) ReturnImageBlock returnImageBlock;

- (void)returnImage:(ReturnImageBlock)block;
@end
