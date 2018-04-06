//
//  ZXMessageVC.m
//  AIDesign
//
//  Created by xinying on 2018/3/18.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXMessageVC.h"
#import "ZXConversationVC.h"

@interface ZXMessageVC ()

@property(nonatomic,strong) NSString *token;
@property(nonatomic,strong) NSMutableArray *msgListArray;
@end

@implementation ZXMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSString *goodsPath = [[NSBundle mainBundle] pathForResource:@"messageList" ofType:@"json"];
    
    if (goodsPath == nil || [goodsPath isEqualToString: @""]) {
    } else{
        NSData *data = [NSData dataWithContentsOfFile:goodsPath];
        NSError *error;
        NSDictionary *goodsDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSLog(@"%@",error);
        NSArray *array = [goodsDic objectForKey:@"user"];
        for (NSDictionary *dic in array) {
            ZXUserModel *model = [ZXUserModel modelWithDictionary:dic];
            [self.msgListArray addObject:model];
        }
    }
}
    
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    RCConversationModel *model = [[RCConversationModel alloc] init];
//    model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_NORMAL;
//    model.conversationType = ConversationType_PRIVATE;
//    model.targetId = @"1234567";
//    model.receivedStatus = ReceivedStatus_UNREAD;
//
//    self.conversationListDataSource = [NSMutableArray arrayWithObject:model];
//
//    [self refreshConversationTableViewIfNeeded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXConversationVC *conversationVC = [[ZXConversationVC alloc]init];
    conversationVC.conversationType = ConversationType_PRIVATE;
    
    ZXUserModel *userModel = self.msgListArray[indexPath.row];
    conversationVC.targetId = @"123456";
    conversationVC.title = userModel.nickname;
    [conversationVC.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"more_restaurant_call"] title:@"语音转文字" atIndex:0 tag:1314];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.msgListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    ZXUserModel *userModel = self.msgListArray[indexPath.row];
    if ([userModel.portrait hasPrefix:@"http"]) {
        [cell.imageView setImageWithURL:[NSURL URLWithString:userModel.portrait] placeholder:[UIImage imageNamed:@"allocation_btn_add"]];
    } else {
        [cell.imageView setImageWithURL:[NSURL URLWithString:@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=552972519,2902321478&fm=58"] placeholder:[UIImage imageNamed:@"allocation_btn_add"]];
    }

    cell.textLabel.text = userModel.nickname;
    cell.detailTextLabel.text = userModel.createTime;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark - LazyLoad
-(NSMutableArray *)msgListArray{
    if (!_msgListArray) {
        _msgListArray = [[NSMutableArray alloc] init];
        
    }
    return _msgListArray;
}

@end
