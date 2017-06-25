//
//  tag.m
//  ZeroutRecorder
//
//  Created by user on 2017/6/25.
//  Copyright © 2017年 hulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "tag.h"

@implementation tag

-(id) initWithType:(NSString *)tagtype withTime:(NSString *)tagtime withPicture:(UIImage *) tagpicture withText:(NSString *)tagtext {
    self = [super init];
    if (self != nil) {
        tagType = tagtype;
        tagTime = tagtime;
        tagPicture = tagpicture;
        tagText = tagtext;
    }
    return self;
}

-(NSString *)getType {
    return tagType;
}

-(NSString *)getTime {
    return tagTime;
}

-(UIImage *)getPicture {
    return tagPicture;
}

-(NSString *)getText {
    return tagText;
}

@end
