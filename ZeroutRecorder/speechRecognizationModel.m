//
//  speechRecognizationModel.m
//  ZeroutRecorder
//
//  Created by hulin on 2017/6/18.
//  Copyright © 2017年 hulin. All rights reserved.
//
#import "speechRecognizationModel.h"
@interface speechRecognizationModel ()  <SFSpeechRecognitionTaskDelegate>

@property (nonatomic ,strong) SFSpeechRecognitionTask   *recognitionTask;
@property (nonatomic ,strong) SFSpeechRecognizer      *speechRecognizer;
@property (nonatomic ,strong) UILabel                *recognizerLabel;
@end
@implementation speechRecognizationModel


- (void)dealloc {
    [self.recognitionTask cancel];
    self.recognitionTask = nil;
}

- (NSString *) startRecognize:(NSString *) filepath{
   // NSString * result = [NSString stringWithFormat:@" "];
    NSLog(@"%@",filepath);
    filePath = filepath;
    //0.0获取权限
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        switch (status) {
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                NSLog(@"StatusNotDetermined");
                break;
            case SFSpeechRecognizerAuthorizationStatusDenied:
                NSLog(@"StatusDenied");
                break;
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                NSLog(@"StatusRestricted");
                break;
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                NSLog(@"StatusAuthorized");
                break;
            default:
                break;
        }
    }];
    
    
    //1.创建SFSpeechRecognizer识别实例
    self.speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];//中文识别
    //2.创建识别请求
    
    NSURL * nsurl = [NSURL fileURLWithPath:filePath];
    //   NSURL * nsurl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:filePath ofType:nil]];
    if(nsurl == nil)
    {
        NSLog(@"the nsurl is nil!");
    }
    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:nsurl];
    
    //3.开始识别任务
    
    self.recognitionTask = [self recognitionTaskWithRequest0:request];
    
  /*
    self.recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (!error) {
            resultString = result.bestTranscription.formattedString;
            
            NSLog(@"语音识别解析正确--%@", resultString);
            
        }else {
            NSLog(@"语音识别解析失败--%@", error);
        }
    }];
    */
    NSLog(@"in startRecognize, the resultString is %@",resultString);
    return resultString;
}

- (SFSpeechRecognitionTask *)recognitionTaskWithRequest0:(SFSpeechURLRecognitionRequest *)request{
    return [self.speechRecognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (!error) {
            resultString = result.bestTranscription.formattedString;

            NSLog(@"语音识别解析正确--%@", resultString);
            
        }else {
            NSLog(@"语音识别解析失败--%@", error);
        }
    }];
    
}

@end
