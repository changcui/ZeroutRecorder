//
//  aRecord.m
//  ZeroutRecorder
//
//  Created by hulin on 2017/6/3.
//  Copyright © 2017年 hulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "aRecord.h"


/*@interface aRecord()
{
    NSString * fileName;
    NSString * recordTime;
    NSString * recordLength;
    //file path
    //pair set of <note,time>
    //pair set of <photo,time>
}
-(id) initWithName:(NSString *)filename withTime:(NSString * ) recordtime withLength:(NSString *) recordlength;
@end
*/
@implementation aRecord
-(id) initWithName:(NSString *)filename withTime:(NSString * ) recordtime withLength:(NSString *) recordlength withFilePath:(NSString *) filepath withTextNote:(NSMutableDictionary *) textDic withPhotoNote:(NSMutableDictionary *) photoDic{
    self = [super init];
    if (self != nil)
    {
        fileName = filename;
        recordTime = recordtime;
        recordLength = recordlength;
        filePath = filepath;
        textNotePairDic = textDic;
        photoNotePairDic = photoDic;
    }
    return self;
}

-(NSString *) getName{
    return fileName;
}
-(NSString *) getTime{
    return recordTime;
}
-(NSString *) getLength{
    return recordLength;
}
-(NSString *) getPath{
    return filePath;
}
@end
