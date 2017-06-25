//
//  tag.h
//  ZeroutRecorder
//
//  Created by user on 2017/6/25.
//  Copyright © 2017年 hulin. All rights reserved.
//

#ifndef tag_h
#define tag_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#endif /* tag_h */

@interface tag : NSObject {
    NSString * tagType;
    NSString * tagTime;
    UIImage * tagPicture;
    NSString * tagText;
}

-(id) initWithType: (NSString *) tagtype
          withTime: (NSString *) tagtime
       withPicture: (UIImage *) tagpicture
          withText: (NSString *) tagtext;
-(NSString *) getType;
-(NSString *) getTime;
-(UIImage *) getPicture;
-(NSString *) getText;

@end
