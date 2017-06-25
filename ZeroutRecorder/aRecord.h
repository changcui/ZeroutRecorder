//
//  aRecord.h
//  ZeroutRecorder
//
//  Created by hulin on 2017/6/3.
//  Copyright © 2017年 hulin. All rights reserved.
//

#ifndef aRecord_h
#define aRecord_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#endif /* aRecord_h */
@interface aRecord : NSObject
{
    NSString * fileName;
    NSString * recordTime;
    NSString * recordLength;
    NSString * filePath;
    NSMutableDictionary * textNotePairDic;
    NSMutableDictionary * photoNotePairDic;
    NSMutableDictionary * drawNotePairDic;
    //pair set of <note,time>
    //pair set of <picture,time>
}
-(id) initWithName:(NSMutableDictionary *) textDic
     withPhotoNote:(NSMutableDictionary *) photoDic
      withDrawNote:(NSMutableDictionary *) drawDic;
-(void) setVars:(NSString *)filename
       withTime:(NSString * ) recordtime
     withLength:(NSString *) recordlength
   withFilePath:(NSString *) filepath;
-(NSString *) getName;
-(NSString *) getTime;
-(NSString *) getLength;
-(NSString *) getPath;
-(void) addTextNote:(NSString *)text withKey:(int) time;
-(void) addPhotoNote:(UIImage *)photo withKey:(int) time;
-(void) addDrawNote:(UIImage *)draw withKey:(int) time;
-(NSMutableDictionary *) getTextNoteDic;
-(NSMutableDictionary *) getPhotoNoteDic;
-(NSMutableDictionary *) getDrawNoteDic;
@end
