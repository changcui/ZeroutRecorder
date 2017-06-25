//
//  tagTableViewController.m
//  ZeroutRecorder
//
//  Created by user on 2017/6/25.
//  Copyright © 2017年 hulin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "aRecord.h"
#import "tag.h"

#import "tagTableViewController.h"
#import "showDetailViewController.h"

@interface tagTableViewController()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray * tagArray;
    NSString * emptyString;
    UIImage * emptyImage;
    UITableView *tableview;
    
}
@property (strong,nonatomic) UITableView * tagTableView;

@end

@implementation tagTableViewController
@synthesize tagTableView;


-(void)viewDidLoad {
    [super viewDidLoad];
    emptyString = @"";
    emptyImage = [[UIImage alloc] init];
    [self makeTagArray];
    tagTableView =  [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStylePlain];
    [tagTableView setDataSource:self];
    [tagTableView setDelegate:self];
    [self.view addSubview: tagTableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}
 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tagArray.count;
}


//prepare data

-(void)makeTagArray {
    tagArray = [[NSMutableArray alloc] init];
    NSMutableDictionary * sendTextDictionary = [_recordSendToTagTVC getTextNoteDic];
    NSMutableDictionary * sendPhotoDictionary = [_recordSendToTagTVC getPhotoNoteDic];
    NSMutableDictionary * sendDrawDictionary = [_recordSendToTagTVC getDrawNoteDic];
    tag * makingTag;
    int timeLength = _recordSendTime;
    for (int key = 0; key < timeLength + 1; key++) {
        NSString * keyString = [NSString stringWithFormat:@"%d", key];
        
        if ([sendTextDictionary objectForKey:[NSNumber numberWithInt:key]] != nil) {
            makingTag = [[tag alloc] initWithType:@"text"
                                         withTime:keyString
                                      withPicture:emptyImage
                                         withText:[sendTextDictionary objectForKey:[NSNumber numberWithInt:key]]];
            [tagArray addObject:makingTag];
        }
        if ([sendPhotoDictionary objectForKey:[NSNumber numberWithInt:key]] != nil) {
            makingTag = [[tag alloc] initWithType:@"photo"
                                         withTime:keyString
                                      withPicture:[sendPhotoDictionary objectForKey:[NSNumber numberWithInt:key]]
                                         withText:emptyString
                         ];
            [tagArray addObject:makingTag];
        }
        if ([sendDrawDictionary objectForKey:[NSNumber numberWithInt:key]] != nil) {
            makingTag = [[tag alloc] initWithType:@"draw"
                                         withTime:keyString
                                      withPicture:[sendDrawDictionary objectForKey:[NSNumber numberWithInt:key]]
                                         withText:emptyString
                         ];
            [tagArray addObject:makingTag];
        }
    }
}

//draw

-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1
                                      reuseIdentifier: TableSampleIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSUInteger row = [indexPath row];
    tag * tagToDraw = [tagArray objectAtIndex:row];
    cell.textLabel.text = [@"time:" stringByAppendingString:[tagToDraw getTime]];
    cell.detailTextLabel.text = [tagToDraw getType];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    tag * tagClicked = [tagArray objectAtIndex:row];
    showDetailViewController * detailVC;
    if ([[tagClicked getType] isEqualToString:@"photo"]) {
        _detailImage = [tagClicked getPicture];
        detailVC = [[showDetailViewController alloc]initWithImage:_detailImage withText:emptyString withType:@"picture"];
    }
    if ([[tagClicked getType]  isEqual: @"draw"]) {
        _detailImage = [tagClicked getPicture];
        detailVC = [[showDetailViewController alloc]initWithImage:_detailImage withText:emptyString withType:@"picture"];
    }
    if ([[tagClicked getType]  isEqual: @"text"]) {
        _detailText = [tagClicked getText];
        detailVC = [[showDetailViewController alloc]initWithImage:emptyImage withText:_detailText withType:@"text"];
    }

    [self.navigationController pushViewController:detailVC animated:YES];

   

}

//translate text to picture




@end
