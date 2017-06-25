//
//  textNoteViewController.m
//  ZeroutRecorder
//
//  Created by hulin on 2017/6/24.
//  Copyright © 2017年 hulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "textNoteViewController.h"

@interface textNoteViewController()
{
    NSString * result;
}
@property (weak, nonatomic) IBOutlet UITextView *noteText;


@end

@implementation textNoteViewController
- (IBAction)saveText:(UIButton *)sender {
    [self->dic setObject:_noteText.text forKey:[NSNumber numberWithInt:self->noteTime]];
    NSLog(@"%@",_noteText.text);

}
- (IBAction)clearTextView:(id)sender {
    _noteText.text = @"";
}

@end
