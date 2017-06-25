//
//  textNoteViewController.h
//  ZeroutRecorder
//
//  Created by hulin on 2017/6/24.
//  Copyright © 2017年 hulin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "aRecord.h"
#import <Foundation/Foundation.h>
#import <Speech/Speech.h>
//typedef void (^ReturnText)(NSString *textNote);
@interface textNoteViewController : UIViewController
{
    @public NSMutableDictionary * dic;
    @public int noteTime;
}
//@property (atomic,copy) ReturnText resultString;
//- (void)returnText:(ReturnText)block;
@end
