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
@end

@implementation ZXMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    conversationVC.targetId = @"123456";
    conversationVC.title = @"想显示的会话标题hello";
    [conversationVC.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"more_restaurant_call"] title:@"语音转文字" atIndex:0 tag:3];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    [cell.imageView setImageWithURL:[NSURL URLWithString:@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=552972519,2902321478&fm=58"] placeholder:[UIImage imageNamed:@"allocation_btn_add"]];
    cell.textLabel.text = @"nihaoa";
    cell.detailTextLabel.text = @"nihaoa";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


@end
