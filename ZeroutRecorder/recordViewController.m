//
//  ViewController.m
//  RLAudioRecord
//
//  Created by Rachel on 16/2/26.
//  Copyright © 2016年 Rachel. All rights reserved.
//

#import "recordViewController.h"
#import "drawViewController.h"
#import "speechRecognizeController.h"
#import "textNoteViewController.h"
#import <AVFoundation/AVFoundation.h>

# define COUNTDOWN 60

@interface recordViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate> {

    NSTimer *_timer; //定时器
    NSInteger countDown;  //倒计时
    NSString * filePath;
    NSString * startRecordTime;
    
    bool newRecordPrepared;
    bool newPlayPrepared;
    
    //vars used to add text note
    //UITextView * textView;
    int noteTime;
    NSString * textNote;
    UIButton * saveButton;
    NSMutableDictionary * textNotePairDictionary;
    NSMutableDictionary * photoNotePairDictionary;
    //NSMutableArray * recordArrays;
    
    
 //   recordFileTable *recFileTable = [[recordFileTable alloc] init];


}

@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;


@property (nonatomic, strong) AVAudioSession *session;

@property (nonatomic, strong) aRecord * curRecord;
//TODO: is this ok ?
@property  BOOL playMode;

@property (nonatomic, strong) AVAudioRecorder *recorder;//录音器

@property (nonatomic,strong) NSMutableArray * recordArrays;

@property (nonatomic, strong) AVAudioPlayer *player; //播放器

@property (nonatomic, strong) NSURL *recordFileUrl; //文件地址

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) UIImage *currentImage;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;


@end

@implementation recordViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsEditing = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;

    self->newRecordPrepared = true;
    self->newPlayPrepared = true;
}



- (IBAction)startRecord:(id)sender {
    
    if([_recorder isRecording])
    {
        [_recorder  pause];
        NSLog(@"pause record");
        newRecordPrepared = false;
    }
    else if(newRecordPrepared == false)
    {
        [_recorder record];
        NSLog(@"continue record");
    }
    else
    {
        //every time start a new record, reset the textNoteDic
        textNotePairDictionary = [[NSMutableDictionary alloc] init];
        photoNotePairDictionary = [[NSMutableDictionary alloc] init];
        
        NSLog(@"start record");

        countDown = 60;
        [self addTimer];
        
        AVAudioSession *session =[AVAudioSession sharedInstance];
        NSError *sessionError;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        
        if (session == nil) {
            
            NSLog(@"Error creating session: %@",[sessionError description]);
            
        }else{
            [session setActive:YES error:nil];
            
        }
        
        self.session = session;
        
        NSDate * date = [NSDate date];//获取当前时间
        NSDateFormatter *format1 = [[NSDateFormatter alloc]init];
        [format1 setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSString * tempString = [format1 stringFromDate:date];
        startRecordTime = [tempString stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        NSLog(@"%@",startRecordTime);
        
        //1.获取沙盒地址
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString * tempString2 = [startRecordTime stringByReplacingOccurrencesOfString:@":" withString:@""];
        filePath = [NSString stringWithFormat:@"%@/rec%@.wav",path,[tempString2 substringWithRange:NSMakeRange(11,6)]];
        
        //2.获取文件路径
        self.recordFileUrl = [NSURL fileURLWithPath:filePath];
        
        //设置参数
        NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                         //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                       [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                       // 音频格式
                                       [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                       //采样位数  8、16、24、32 默认为16
                                       [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                       // 音频通道数 1 或 2
                                       [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                       //录音质量
                                       [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                       nil];

        
        _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:recordSetting error:nil];
        
        if (_recorder) {
            
            _recorder.meteringEnabled = YES;
            [_recorder prepareToRecord];
            [_recorder record];
            
            
 /*           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self stopRecord:nil];
            });
  */
           // NSLog(@"set ready");
            
            
        }else{
            NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
            
        }
        self->newRecordPrepared = false;
    }
}


- (IBAction)saveRecord:(id)sender {

   [self removeTimer];
    NSLog(@"save record");
    
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        
        _noticeLabel.text = [NSString stringWithFormat:@"录了 %ld 秒",COUNTDOWN - (long)countDown];
        
        //add obj to recordArrays
        NSString * length = [NSString stringWithFormat:@"%ld",COUNTDOWN - (long)countDown];

        NSString * filename = [NSString stringWithFormat:@"rec%@.wav",[startRecordTime substringWithRange:NSMakeRange(11,8)]];
        
        if(_playMode == false){
       //     NSLog(@"not playMode");
            aRecord * newrecord = [[aRecord alloc] initWithName:filename withTime:startRecordTime withLength:length withFilePath:filePath withTextNote:textNotePairDictionary withPhotoNote:photoNotePairDictionary];
        
            [_recordArrays addObject: newrecord];
        }
        
    }else{
    
        _noticeLabel.text = @"最多录60秒";

    }
    
    self->newRecordPrepared = true;

}
- (IBAction)abortRecord:(UIButton *)sender {
    [self removeTimer];
    NSLog(@"abort the record");
    if([_recorder deleteRecording] == false)
    {
        NSLog(@"fail to delete record!!");
    }
    self->newRecordPrepared = true;
}
- (IBAction)PlayRecord:(id)sender {
    
    NSLog(@"播放录音");
    [self.recorder stop];
    
    if ([self.player isPlaying])
    {
        [self.player pause];
    }
    //else if (self->newPlayPrepared == false)
    //{
    //    [self.player play];
    //}
    else
    {
        if(_playMode == false)
        {
            self.recordFileUrl = [NSURL fileURLWithPath:filePath];
        }else{
            self.recordFileUrl = [NSURL fileURLWithPath:[_curRecord getPath]];
        }
        
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl error:nil];
        
        NSLog(@"%li",self.player.data.length/1024);
        
        [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
        [self.player play];
    //    self->newPlayPrepared = true;
    }
}


/**
 *  添加定时器
 */
- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshLabelText) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
    
}


- (void)imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    self.imageView.image = image;
    self.currentImage = image;
    //add (photo,time) pair to dictionary
    noteTime = COUNTDOWN - countDown;
    [self->photoNotePairDictionary setObject:image forKey:[NSNumber numberWithInt:self->noteTime]];
    
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void)imagePickerControllerDidCancel: (UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showAlertWithMessage: (NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction: [UIAlertAction actionWithTitle:@"OK"
                                               style:UIAlertActionStyleCancel
                                             handler:nil]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addPhotoNote:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    //take photo
    [alertController addAction: [UIAlertAction actionWithTitle:@"take photo"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action)
                                 {
                                     if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                         self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                         [self presentViewController:self.imagePickerController animated:YES completion:nil];
                                     }else {
                                         [self showAlertWithMessage:@"Camera is not available"];
                                     }
                                 }]];
    
    //choose a photo from album
    [alertController addAction: [UIAlertAction actionWithTitle:@"Choose Existing Photo"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action)
                                 {
                                     if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                                         self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                         [self presentViewController:self.imagePickerController animated:YES completion:nil];
                                     }
                                 }]];
    
    //cancel
    [alertController addAction: [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

//draw
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier  isEqual: @"drawViewSegue"])
    {
        noteTime = COUNTDOWN - countDown;
        drawViewController * drawVC = segue.destinationViewController;
        
        [drawVC returnImage:^(UIImage *showImage) {
            self.imageView.image = showImage;
            [self->photoNotePairDictionary setObject:showImage forKey:[NSNumber numberWithInt:self->noteTime]];
            NSLog(@"draw time is %d", noteTime);
        }];
    }
    else if ([segue.identifier  isEqual: @"voiceRecognizeSegue"])
    {
        speechRecognizeController * destinationVC = segue.destinationViewController;
        NSString * pathString;
        if(_playMode == false)
        {
            pathString = filePath;
        }else{
            pathString = [_curRecord getPath];
        }
        [destinationVC setFilePath: pathString];
    }
    else if([segue.identifier  isEqual: @"textNoteSegue"])
    {
        textNoteViewController * textNoteVC = segue.destinationViewController;
        noteTime = COUNTDOWN - countDown;
        textNoteVC->dic = self->textNotePairDictionary;
        textNoteVC->noteTime = self->noteTime;
    }
    
}



-(void)refreshLabelText{
    if([_recorder isRecording])
    {
        countDown --;
        _noticeLabel.text = [NSString stringWithFormat:@"还剩 %ld 秒",(long)countDown];
    }
}

@end
