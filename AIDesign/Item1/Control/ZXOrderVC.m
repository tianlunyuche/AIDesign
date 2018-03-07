//
//  ZXOrderVC.m
//  AIDesign
//
//  Created by xinying on 2018/1/14.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXOrderVC.h"
#import "ZXGoodsCell01.h"
#import "ZXMenuCell.h"
#import "ZXResultTableVC.h"

#define ZXGoodsCell @"ZXGoodsCell01"
#define ZXMENUCELL @"ZXMenuCell"

const NSString *API_KEY = @"CfGHkaxz5VfDbLkn8gdoKb8v";
const NSString *SECRET_KEY = @"dGqy8gG8iLGayjvbsadSXAfRmg7dbDUY ";
const NSString *APP_ID = @"10605504";

@interface ZXOrderVC ()<UITableViewDelegate ,UITableViewDataSource ,UISearchBarDelegate >

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *menuView;
@property(nonatomic,strong) UISearchController *searchVC;

@property(nonatomic,strong) ZXResultTableVC *resultTableVC;

@property(nonatomic,strong) BDSEventManager *asrEventManager;
@property(nonatomic,strong) BDSEventManager *wakeupEventManager;

@property(nonatomic, assign) BOOL continueToVR;
@property(nonatomic, assign) BOOL longPressFlag;
@property(nonatomic, assign) BOOL touchUpFlag;

@property(nonatomic, assign) BOOL longSpeechFlag;

@property(nonatomic,strong) NSMutableArray *menuArray;
@property(nonatomic,strong) NSMutableArray *goodsArray;

@end

@implementation ZXOrderVC

-(void)loadView{
    [super loadView];
    [self.tableView registerNib:[UINib nibWithNibName:ZXGoodsCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ZXGoodsCell];
    [self.menuView registerNib:[UINib nibWithNibName:ZXMENUCELL bundle:nil] forCellReuseIdentifier:ZXMENUCELL];
    
    self.searchVC.searchBar.placeholder =@"搜索产品";
    //    self.navigationController.navigationBar.prefersLargeTitles = true;
    self.navigationItem.hidesSearchBarWhenScrolling =NO;
    self.definesPresentationContext = YES;
    //    self.navigationItem.searchController =self.searchVC;
    //    self.tableView.tableHeaderView =self.searchVC.searchBar;
    self.navigationItem.titleView =self.searchVC.searchBar;
    self.tabBarController.tabBarItem.image =[[UIImage imageNamed:@"state-restaurant-done"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dealData];
    [self configVoiceRecognitionClient];
}

-(void)dealData{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"Service" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.menuArray = dic[@"menu"][@"records"];
    self.goodsArray = dic[@"Goods"][@"records"];
    
    
    self.menuView.tag = 1010;
    self.menuView.delegate = self;
    self.menuView.dataSource = self;
    self.tableView.tag = 1011;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - 语音识别配置
-(void)configVoiceRecognitionClient{
    //--------------------百度 语音识别
    self.asrEventManager =[BDSEventManager createEventManagerWithName:BDS_ASR_NAME];
    self.wakeupEventManager =[BDSEventManager createEventManagerWithName:BDS_WAKEUP_NAME];
    
    NSLog(@"sdk version:%@", [self.asrEventManager libver]);
#warning - continueToVR 和 Settings
    self.continueToVR = NO;
    [[BDVRSettings getInstance] configBDVRClient];
    
    //设置Debug log级别
    [self.asrEventManager setParameter:@(EVRDebugLogLevelTrace) forKey:BDS_ASR_DEBUG_LOG_LEVEL];
    //配置API_KEY 和 SECRET_KEY 和 APP_ID
    [self.asrEventManager setParameter:@[API_KEY ,SECRET_KEY] forKey:BDS_ASR_API_SECRET_KEYS];
    [self.asrEventManager setParameter:APP_ID forKey:BDS_ASR_OFFLINE_APP_CODE];
    //配置端点检测（二选一）
    [self configModelVAD];
    //    [self configDNNMFE];
    // ---- 语义与标点 -----
    [self enableNLU];
    //    [self enablePunctuation];
}

-(void)configModelVAD{
    NSString *modelVAD_filepath = [[NSBundle mainBundle] pathForResource:@"bds_easr_basic_model" ofType:@"dat"];
    [self.asrEventManager setParameter:modelVAD_filepath forKey:BDS_ASR_MODEL_VAD_DAT_FILE];
    [self.asrEventManager setParameter:@(YES) forKey:BDS_ASR_ENABLE_MODEL_VAD];
}

- (void) enableNLU {
    // ---- 开启语义理解 -----
    [self.asrEventManager setParameter:@(YES) forKey:BDS_ASR_ENABLE_NLU];
    [self.asrEventManager setParameter:@"15361" forKey:BDS_ASR_PRODUCT_ID];
}

#pragma mark - 触发语音识别
-(void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"haode ");
    self.touchUpFlag = NO;
    self.longPressFlag = NO;
    [self cleanLogUI];
    [self.asrEventManager setParameter:@(NO) forKey:BDS_ASR_ENABLE_LONG_SPEECH];
    [self.asrEventManager setParameter:@(NO) forKey:BDS_ASR_NEED_CACHE_AUDIO];
    [self.asrEventManager setParameter:@"" forKey:BDS_ASR_OFFLINE_ENGINE_TRIGGERED_WAKEUP_WORD];
    [self voiceRecogButtonHelper];
    
    if (self.longPressFlag) {
        [self.asrEventManager sendCommand:BDS_ASR_CMD_STOP];
    }
}

- (void)voiceRecogButtonHelper
{
    //    [self configFileHandler];
    [self.asrEventManager setDelegate:self.resultTableVC];
    [self.asrEventManager setParameter:nil forKey:BDS_ASR_AUDIO_FILE_PATH];
    [self.asrEventManager setParameter:nil forKey:BDS_ASR_AUDIO_INPUT_STREAM];
    [self.asrEventManager sendCommand:BDS_ASR_CMD_START];
    [self onInitializing];
}

-(void)onInitializing{
    
}

- (void)cleanLogUI
{
    self.searchVC.searchBar.text =@"";
}

#pragma mark - LazyLoad
-(UISearchController *)searchVC{
    if (!_searchVC) {
        
        _searchVC =[[UISearchController alloc] initWithSearchResultsController:self.resultTableVC];
        _searchVC.searchResultsUpdater =self.resultTableVC;
        //得加上这一句，否则 以 self.navigationItem.titleView =self.searchVC.searchBar;这种方式，会导致 搜索框上移-64 不可见。
        _searchVC.hidesNavigationBarDuringPresentation =NO;
        _searchVC.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchVC.searchBar.showsSearchResultsButton =YES;
        _searchVC.searchBar.delegate = self;

    }
    return _searchVC;
}

-(ZXResultTableVC *)resultTableVC{
    if (!_resultTableVC) {
        _resultTableVC = [[ZXResultTableVC alloc] init];
    }
    return _resultTableVC;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1010) {
        return self.menuArray.count;
    }else
        return self.goodsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1010) {
        ZXMenuCell *cell =[tableView dequeueReusableCellWithIdentifier:ZXMENUCELL];
        NSDictionary *menudic =self.menuArray[indexPath.row];
        cell.name.text =[menudic objectForKey:@"name"];
        
        return cell;
    }else{
        ZXGoodsCell01 *cell = [tableView dequeueReusableCellWithIdentifier:ZXGoodsCell];
        NSDictionary *goodsdic =self.goodsArray[indexPath.row];
        cell.name.text =[goodsdic objectForKey:@"name"];
        cell.code.text =[goodsdic objectForKey:@"default_code"];
        
        NSArray *priceArray =[goodsdic objectForKey:@"uom_id"];
        cell.price.text =[NSString stringWithFormat:@"%@\%@",priceArray[0] ,priceArray[1]];
        
        return cell;
    }
}


@end
