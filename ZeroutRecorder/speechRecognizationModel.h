//
//  speechRecognizationModel.h
//  ZeroutRecorder
//
//  Created by hulin on 2017/6/18.
//  Copyright © 2017年 hulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Speech/Speech.h>

@interface speechRecognizationModel : NSObject  <SFSpeechRecognitionTaskDelegate>
{
    NSString * filePath;
    NSString * resultString;
}
- (NSString *) startRecognize:(NSString *) filepath;
@end
