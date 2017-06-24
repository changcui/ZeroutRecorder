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
    //pair set of <note,time>
    //pair set of <picture,time>
}
-(id) initWithName:(NSString *)filename withTime:(NSString * ) recordtime withLength:(NSString *) recordlength withFilePath:(NSString *) filepath withTextNote:(NSMutableDictionary *) textDic withPhotoNote:(NSMutableDictionary *) photoDic;
-(NSString *) getName;
-(NSString *) getTime;
-(NSString *) getLength;
-(NSString *) getPath;
@end
