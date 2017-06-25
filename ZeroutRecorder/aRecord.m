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
-(id) initWithName:(NSMutableDictionary *) textDic
     withPhotoNote:(NSMutableDictionary *) photoDic
      withDrawNote:(NSMutableDictionary *) drawDic{
    self = [super init];
    if (self != nil)
    {
        
        textNotePairDic = textDic;
        photoNotePairDic = photoDic;
        drawNotePairDic = drawDic;
    }
    return self;
}

-(void) setVars:(NSString *) filename
       withTime:(NSString * ) recordtime
     withLength:(NSString *) recordlength
   withFilePath:(NSString *) filepath{
    
    fileName = filename;
    recordTime = recordtime;
    recordLength = recordlength;
    filePath = filepath;
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
-(void) addTextNote:(NSString *)text
            withKey:(int)time
{
    [textNotePairDic setObject:text forKey:[NSNumber numberWithInt:time]];
}
-(void) addPhotoNote:(UIImage *)photo
             withKey:(int)time
    {
        [photoNotePairDic setObject:photo forKey:[NSNumber numberWithInt:time]];
    }
-(void) addDrawNote:(UIImage *)draw
            withKey:(int) time
{
    [drawNotePairDic setObject:draw forKey:[NSNumber numberWithInt:time]];
}
-(NSMutableDictionary *) getTextNoteDic{
    return textNotePairDic;
}
-(NSMutableDictionary *) getPhotoNoteDic{
    return photoNotePairDic;
}
-(NSMutableDictionary *) getDrawNoteDic{
    return drawNotePairDic;
}
@end
