//
//  showDetailViewController.h
//  ZeroutRecorder
//
//  Created by user on 2017/6/26.
//  Copyright © 2017年 hulin. All rights reserved.
//

#ifndef showDetailViewController_h
#define showDetailViewController_h
#import <UIKit/UIKit.h>
#import "aRecord.h"
#import "tag.h"


#endif /* showDetailViewController_h */

@interface showDetailViewController : UIViewController
@property(strong, nonatomic) UIImage * showDetailImage;
@property(strong, nonatomic) NSString * showDetailText;
@property(strong, nonatomic) NSString * showDetailType;


-(id)initWithImage:(UIImage *)detailImage withText:(NSString *) detailText withType:(NSString *) detailType;

@end
