//
//  ZXResultTableVC.m
//  AIDesign
//
//  Created by xinying on 2018/1/22.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXResultTableVC.h"
#import "ZXGoodsCell01.h"

#define ZXProductCell @"ZXGoodsCell01"

@interface ZXResultTableVC ()<BDSClientASRDelegate ,BDSClientWakeupDelegate>

@property(nonatomic, strong) NSFileHandle *fileHandler;

@end

@implementation ZXResultTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:ZXProductCell bundle:nil] forCellReuseIdentifier:ZXProductCell];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
}

#pragma mark - MVoiceRecognitionClientDelegate

- (void)VoiceRecognitionClientWorkStatus:(int)workStatus obj:(id)aObj {
    switch (workStatus) {
        case EVoiceRecognitionClientWorkStatusNewRecordData: {
            [self.fileHandler writeData:(NSData *)aObj];
            break;
        }
            //------------开始识别
        case EVoiceRecognitionClientWorkStatusStartWorkIng: {
            NSDictionary *logDic = [self parseLogToDic:aObj];
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK: start vr, log: %@\n", logDic]];
            [self onStartWorking];
            break;
        }
        case EVoiceRecognitionClientWorkStatusStart: {
            [self printLogTextView:@"CALLBACK: detect voice start point.\n"];
            break;
        }
        case EVoiceRecognitionClientWorkStatusEnd: {
            [self printLogTextView:@"CALLBACK: detect voice end point.\n"];
            break;
        }
        case EVoiceRecognitionClientWorkStatusFlushData: {
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK: partial result - %@.\n\n", [self getDescriptionForDic:aObj]]];
            break;
        }
            //-----------------完成状态
        case EVoiceRecognitionClientWorkStatusFinish: {
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK: final result - %@.\n\n", [self getDescriptionForDic:aObj]]];
            if (aObj) {
                NSArray *resultsArray = [aObj objectForKey:@"results_recognition"];
                NSLog(@"resultsArray =%@",resultsArray);
            }
            break;
        }
            
        case EVoiceRecognitionClientWorkStatusMeterLevel: {
            break;
        }
        case EVoiceRecognitionClientWorkStatusCancel: {
            [self printLogTextView:@"CALLBACK: user press cancel.\n"];
            [self onEnd];
            break;
        }
        case EVoiceRecognitionClientWorkStatusError: {
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK: encount error - %@.\n", (NSError *)aObj]];
            [self onEnd];
            break;
        }
        case EVoiceRecognitionClientWorkStatusLoaded: {
            [self printLogTextView:@"CALLBACK: offline engine loaded.\n"];
            break;
        }
        case EVoiceRecognitionClientWorkStatusUnLoaded: {
            [self printLogTextView:@"CALLBACK: offline engine unLoaded.\n"];
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkThirdData: {
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK: Chunk 3-party data length: %lu\n", (unsigned long)[(NSData *)aObj length]]];
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkNlu: {
            NSString *nlu = [[NSString alloc] initWithData:(NSData *)aObj encoding:NSUTF8StringEncoding];
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK: Chunk NLU data: %@\n", nlu]];
            NSLog(@"%@", nlu);
            break;
        }
        case EVoiceRecognitionClientWorkStatusChunkEnd: {
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK: Chunk end, sn: %@.\n", aObj]];

            break;
        }
        case EVoiceRecognitionClientWorkStatusFeedback: {
            NSDictionary *logDic = [self parseLogToDic:aObj];
            [self printLogTextView:[NSString stringWithFormat:@"CALLBACK Feedback: %@\n", logDic]];
            break;
        }
        case EVoiceRecognitionClientWorkStatusRecorderEnd: {
            [self printLogTextView:@"CALLBACK: recorder closed.\n"];
            break;
        }
        case EVoiceRecognitionClientWorkStatusLongSpeechEnd: {
            [self printLogTextView:@"CALLBACK: Long Speech end.\n"];
            [self onEnd];
            break;
        }
        default:
            break;
    }
}
//--------结束 标志 和 视图变化
- (void)onEnd
{
    
}
//--------开始 标志 和 视图变化
-(void)onStartWorking{
    
}

- (void)printLogTextView:(NSString *)logString
{
    NSLog(@"logString \n %@",logString);
}

- (NSString *)getDescriptionForDic:(NSDictionary *)dic {
    if (dic) {
        return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dic
                                                                              options:NSJSONWritingPrettyPrinted
                                                                                error:nil] encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSDictionary *)parseLogToDic:(NSString *)logString
{
    NSArray *tmp = NULL;
    NSMutableDictionary *logDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    NSArray *items = [logString componentsSeparatedByString:@"&"];
    for (NSString *item in items) {
        tmp = [item componentsSeparatedByString:@"="];
        if (tmp.count == 2) {
            [logDic setObject:tmp.lastObject forKey:tmp.firstObject];
        }
    }
    return logDic;
}

#pragma mark - LazyLoad
//the search bar becomes first responder.
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSLog(@"update");
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXGoodsCell01 *cell = [tableView dequeueReusableCellWithIdentifier:ZXProductCell forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
@end
