//
//  tagTableViewController.h
//  ZeroutRecorder
//
//  Created by user on 2017/6/25.
//  Copyright © 2017年 hulin. All rights reserved.
//

#ifndef tagTableViewController_h
#define tagTableViewController_h
#import <UIKit/UIKit.h>
#import "aRecord.h"
#import "tag.h"

#endif /* tagTableViewController_h */

@interface tagTableViewController : UITableViewController
@property (nonatomic, strong) aRecord * recordSendToTagTVC;
@property NSInteger * recordSendTime;
@property (nonatomic, strong) UIImage * detailImage;
@property (nonatomic, strong) NSString * detailText;
@end
