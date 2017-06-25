//
//  speechRecognizeController.h
//  ZeroutRecorder
//
//  Created by hulin on 2017/6/24.
//  Copyright © 2017年 hulin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "aRecord.h"
#import <Foundation/Foundation.h>
#import <Speech/Speech.h>
//#import "speechRecognizationModel.h"

@interface speechRecognizeController : UIViewController <SFSpeechRecognitionTaskDelegate>

- (void) setFilePath:(NSString *) filepath;
@end
