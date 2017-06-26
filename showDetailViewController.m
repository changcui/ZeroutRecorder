//
//  showDetailViewController.m
//  ZeroutRecorder
//
//  Created by user on 2017/6/26.
//  Copyright © 2017年 hulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "aRecord.h"
#import "tag.h"

#import "tagTableViewController.h"
#import "showDetailViewController.h"



@implementation showDetailViewController


-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([_showDetailType isEqual:@"picture"]) {
        UIImageView *pictureView = [[UIImageView alloc]initWithImage: _showDetailImage];
        pictureView.frame = self.view.bounds;
        //[pictureView sizeToFit];
        [self.view addSubview:pictureView];
    }
    if ([_showDetailType isEqual:@"text"]) {
        UITextView *textView = [[UITextView alloc]initWithFrame:self.view.bounds];
        textView.textColor = [UIColor blackColor];
        textView.text = _showDetailText;
        textView.backgroundColor = [UIColor whiteColor];
        textView.font = [UIFont systemFontOfSize:25];
        [self.view addSubview:textView];
    }
    
    
}

-(id)initWithImage:(UIImage *)detailImage withText:(NSString *) detailText withType:(NSString *) detailType{
    self = [super init];
    if (self != nil) {
        _showDetailImage = detailImage;
        _showDetailText = detailText;
        _showDetailType = detailType;
    }
    return self;
}

@end
