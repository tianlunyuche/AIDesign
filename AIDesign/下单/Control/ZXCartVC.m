//
//  ZXCartVC.m
//  AIDesign
//
//  Created by xinying on 2018/3/31.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXCartVC.h"
#import "ZXMenuCell.h"
#import "ZXResultTableVC.h"
#import "ZXNetWorkManager.h"
#import "ZXGoodsCell02.h"
#import "ZXDynamicVC.h"
#import "ZXOrderVC.h"

#define ZXGoodsCell @"ZXGoodsCell02"
#define ZXMENUCELL @"ZXMenuCell"


@interface ZXCartVC () <UITableViewDelegate ,UITableViewDataSource ,UISearchBarDelegate, UISearchControllerDelegate, BDSClientASRDelegate >

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *menuView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property(nonatomic,strong) UISearchController *searchVC;

@property(nonatomic,strong) ZXResultTableVC *resultTableVC;

@property(nonatomic,strong) BDSEventManager *asrEventManager;
@property(nonatomic,strong) BDSEventManager *wakeupEventManager;

@property(nonatomic, strong) NSFileHandle *fileHandler;

@property(nonatomic, assign) BOOL continueToVR;
@property(nonatomic, assign) BOOL longPressFlag;
@property(nonatomic, assign) BOOL touchUpFlag;

@property(nonatomic, assign) BOOL longSpeechFlag;
@property(nonatomic,strong) NSMutableDictionary<NSString *, NSMutableArray *> *allCartGoodsDic;

@end

@implementation ZXCartVC

-(void)loadView{
    [super loadView];
    [self.tableView registerNib:[UINib nibWithNibName:ZXGoodsCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ZXGoodsCell];
    [self.menuView registerNib:[UINib nibWithNibName:ZXMENUCELL bundle:nil] forCellReuseIdentifier:ZXMENUCELL];
    //----------------------
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
    // 添加通知监听见键盘弹出/退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    
}

-(void)dealData{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"Service" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.menuArray = dic[@"menu"][@"records"];
    //    self.goodsArray = dic[@"Goods"][@"records"];
    
    self.menuView.tag = 1010;
    self.menuView.delegate = self;
    self.menuView.dataSource = self;
    self.tableView.tag = 1011;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.menuView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    for (NSString *key in self.allGoodsDic.allKeys) {
        NSMutableArray *array = [self.allGoodsDic objectForKey:key];
        NSMutableArray *goodsArray = [NSMutableArray array];
        for (ZXGoodsModel *model in array) {
            if (model.num >0) {
                [goodsArray addObject:model];
            }
        }
        [self.allCartGoodsDic setObject:goodsArray forKey:key];
    }
    [self getGoodSourcesWithParam:@"0"];
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

#pragma mark 触发语音识别
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
    [self.asrEventManager setDelegate:self];
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


#pragma mark - BDSClientASRDelegate ,识别结果

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
                if (resultsArray.count) {
                    self.searchVC.searchBar.text = resultsArray[0];
                    [self searchGoods:resultsArray];
                }
                
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
-(UISearchController *)searchVC{
    if (!_searchVC) {
        
        _searchVC =[[UISearchController alloc] initWithSearchResultsController:self.resultTableVC];
        _searchVC.searchResultsUpdater =self.resultTableVC;
        //得加上这一句，否则 以 self.navigationItem.titleView =self.searchVC.searchBar;这种方式，会导致 搜索框上移-64 不可见。
        _searchVC.hidesNavigationBarDuringPresentation =NO;
        _searchVC.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchVC.searchBar.showsSearchResultsButton =YES;
        _searchVC.searchBar.delegate = self;
        _searchVC.delegate = self;
        
    }
    return _searchVC;
}

-(ZXResultTableVC *)resultTableVC{
    if (!_resultTableVC) {
        _resultTableVC = [[ZXResultTableVC alloc] init];
    }
    return _resultTableVC;
}

-(NSMutableArray *)searchArray{
    if (!_searchArray) {
        _searchArray =[NSMutableArray arrayWithCapacity:1];
    }
    return _searchArray;
}

-(NSMutableDictionary<NSString *, NSMutableArray *> *)allCartGoodsDic{
    if (!_allCartGoodsDic) {
        _allCartGoodsDic = [[NSMutableDictionary alloc] init];
    }
    return _allCartGoodsDic;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1010) {
        return UITableViewAutomaticDimension;
    }else
        return 140;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1010) {
        
        NSString *goods = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        [self getGoodSourcesWithParam:goods];
        
    }else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1010) {
        return self.menuArray.count;
    }else {
        if ([self.searchVC.searchBar.text isEqualToString:@""]) {
            return self.goodsArray.count;
        } else {
            return self.searchArray.count;
        }
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1010) {
        ZXMenuCell *cell =[tableView dequeueReusableCellWithIdentifier:ZXMENUCELL];
        NSDictionary *menudic =self.menuArray[indexPath.row];
        cell.name.text =[menudic objectForKey:@"name"];
        
        return cell;
    }else{
        ZXGoodsCell02 *cell = [tableView dequeueReusableCellWithIdentifier:ZXGoodsCell];
        __block ZXGoodsModel *goodsModel;
        __weak typeof(self) weakSelf = self;
        
        if ([self.searchVC.searchBar.text isEqualToString:@""]) {
            goodsModel = self.goodsArray[indexPath.row];
        } else {
            goodsModel = self.searchArray[indexPath.row];
        }
        
        cell.name.text = goodsModel.title;
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:goodsModel.img] placeholderImage:[UIImage imageNamed:@"default-ico-none"]];
        cell.price.text = [NSString stringWithFormat:@"%@元/%@",goodsModel.currentPrice ,goodsModel.unit];
        cell.unit.text = goodsModel.unit;
        cell.soldOut.text = [NSString stringWithFormat:@"库存：%ld",goodsModel.soldOut];
        cell.numTextField.text = [NSString stringWithFormat:@"%ld",goodsModel.num];
        
        __weak typeof(cell) weakCell = cell;
        [cell.addBtn setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(cell) cell = weakCell;
            if (goodsModel.soldOut > goodsModel.num) {
                goodsModel.num ++;
                cell.numTextField.text = [NSString stringWithFormat:@"%ld",(long)goodsModel.num];
                [cell layoutIfNeeded];
            }
        }];
        
        [cell.reduceBtn setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(cell) cell = weakCell;
            if (goodsModel.num >0) {
                goodsModel.num --;
                cell.numTextField.text = [NSString stringWithFormat:@"%ld",(long)goodsModel.num];
                [cell layoutIfNeeded];
            }
        }];
        
        cell.judgeWhenEndEditing = ^{
            __strong typeof(cell) cell = weakCell;
            if (cell.numTextField.text.integerValue > goodsModel.soldOut) {
                goodsModel.num = goodsModel.soldOut;
            } else {
                goodsModel.num = cell.numTextField.text.integerValue;
            }
            [weakSelf.tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationMiddle];
        };
        //        NSArray *priceArray =[goodsdic objectForKey:@"uom_id"];
        //        cell.price.text =[NSString stringWithFormat:@"%@\%@",priceArray[0] ,priceArray[1]];
        
        return cell;
    }
}

// 键盘监听事件
- (void)keyboardAction:(NSNotification*)sender{
    // 通过通知对象获取键盘frame: [value CGRectValue]
    NSDictionary *useInfo = [sender userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // <注意>具有约束的控件通过改变约束值进行frame的改变处理
    if([sender.name isEqualToString:UIKeyboardWillShowNotification]){
        
        //        self.toBottom.constant = [value CGRectValue].size.height;
    }else{
        //        self.toBottom.constant = 0;
     
    }
}

-(void)dealloc{
    
}


-(void)lpGR:(UIGestureRecognizer *)sender{
    NSLog(@"ok");
}

- (IBAction)headerSelected:(id)sender {
}


-(void)getGoodSourcesWithParam:(NSString *)goods{
    
    self.goodsArray = [self.allCartGoodsDic objectForKey:goods];
    [self.tableView reloadData];
}

- (void)willPresentSearchController:(UISearchController *)searchController{
    self.resultTableVC.goodsArray = self.goodsArray;
    self.resultTableVC.menuArray = self.menuArray;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)willDismissSearchController:(UISearchController *)searchController{
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 工具
-(void)searchGoods:(NSArray *)array{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (ZXGoodsModel *goodsModel in self.goodsArray) {
        if ([goodsModel.title containsString:array[0]]) {
            [mutableArray addObject:goodsModel];
        }
    }
    self.searchArray = mutableArray;
    [self.tableView reloadData];
}

- (IBAction)orderSeclet:(id)sender {
    
    [MBProgressHUD showSuccess:@"下单成功"];
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[ZXOrderVC class]]) {
            ((ZXOrderVC *)vc).isPresent = YES;
        }
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.tableView endEditing:YES];
}

@end
