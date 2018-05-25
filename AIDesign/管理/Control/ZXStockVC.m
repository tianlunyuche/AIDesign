//
//  ZXStockVC.m
//  AIDesign
//
//  Created by xinying on 2018/3/7.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXStockVC.h"
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>
#import "ZXUserModel.h"
#import "ZXOrders.h"
#import "ZXPageController.h"
#import "ZXStockPageVC.h"
#import "ZXGoodsCell02.h"
#import "ZXDetailCollectionViewCell.h"
#import "ZXMenuCell.h"
#import "ZXGoodsSourceModel.h"

#define ZXGoodsCell @"ZXGoodsCell02"
#define ZXMENUCELL @"ZXMenuCell"
#define BGColor    [UIColor colorWithRed:25/250 green:202/250 blue:200/250 alpha:1]

@interface ZXStockVC ()<SFSpeechRecognizerDelegate,UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>

@property(nonatomic,strong) SFSpeechRecognizer *speechRecognizer;
@property(nonatomic,strong) AVAudioEngine *audioEngine;
@property(nonatomic,strong) SFSpeechRecognitionTask *recognitionTask;
@property(nonatomic,strong) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
//@property (weak, nonatomic) IBOutlet UILabel *resultlabel;
@property (weak, nonatomic) IBOutlet UIButton *speechBtn;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *ordersArray;
@property(nonatomic,strong) ZXStockPageVC *pageVC;

@property(nonatomic,strong) UIView *sectionHeaderV;
@property(nonatomic,strong) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *menuView;
@property (weak, nonatomic) IBOutlet UIButton *inventory;

@property(nonatomic,strong) NSMutableArray *menuArray;
@property(nonatomic,strong) UIView *lineView;
@property(nonatomic,strong) NSMutableArray *goodsArray;
@property(nonatomic,strong) NSMutableArray *goodsSigleArray;
@property(nonatomic,strong) NSMutableArray *searchArray;

@property(nonatomic,strong) NSString *currentPhone;
@property(nonatomic,strong) NSMutableDictionary<NSString *, NSMutableArray *> *allCartGoodsDic;
@property(nonatomic,strong) NSMutableDictionary<NSString *, NSMutableArray *> *allGoodsDic;


@end

@implementation ZXStockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self speechAuthorization];
    [self.speechBtn addTarget:self action:@selector(speechClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView registerNib:[UINib nibWithNibName:ZXGoodsCell bundle:nil] forCellReuseIdentifier:ZXGoodsCell];
    
    self.currentPhone = [kUserDefaults objectForKey:UserNameKey];
    ZXUserModel *userModel = CurrentUserModel;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"Service" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.menuArray = dic[@"menu"][@"records"];

//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
//    [array addObjectsFromArray:goodSourceModel.goodsArray];
//    for (int i=0; i < self.menuArray.count; i++) {
//        [array addObjectsFromArray:self.goodsArray[i]];
//    }
//    goodSourceModel.goodsArray = array;
    
    [self.tableView registerNib:[UINib nibWithNibName:ZXGoodsCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ZXGoodsCell];
    [self.menuView registerNib:[UINib nibWithNibName:ZXMENUCELL bundle:nil] forCellReuseIdentifier:ZXMENUCELL];
    self.searchBar.delegate = self;
//    for (NSString *key in self.allGoodsDic.allKeys) {
//        NSMutableArray *array = [self.allGoodsDic objectForKey:key];
//        NSMutableArray *goodsArray = [NSMutableArray array];
//        for (ZXGoodsModel *model in array) {
//            if (model.num >0) {
//                [goodsArray addObject:model];
//            }
//        }
//        [self.allCartGoodsDic setObject:goodsArray forKey:key];
//    }
//    [self getGoodSourcesWithParam:@"0"];
    // 添加通知监听见键盘弹出/退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSArray *phones = [kUserDefaults objectForKey:AllPhones];
    NSString *currentPhone = [kUserDefaults objectForKey:UserNameKey];
    ZXUserModel *userModel = CurrentUserModel;
    
    ZXGoodsArrayModel *goodSourceModel = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:[NSString stringWithFormat:@"%@%@",CurrentStock ,userModel.mobile]]];
    if (!goodSourceModel) {
        goodSourceModel = [ZXGoodsArrayModel new];
    }
    if (!goodSourceModel.goodsArray) {
        goodSourceModel.goodsArray = [[NSArray alloc] init];
    }
    [self.goodsArray removeAllObjects];
    [self.goodsArray addObjectsFromArray:goodSourceModel.goodsArray];
    [self.menuView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    self.menuView.tag = 1010;
    self.menuView.delegate = self;
    self.menuView.dataSource = self;
    self.tableView.tag = 1011;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.menuView reloadData];
    [self.tableView reloadData];
//    if ([currentPhone containsString:@"#"]) {
//        //------商家的 所有订单
//        for (NSString *phone in phones) {
//            ZXOrders *orders = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:[NSString stringWithFormat:@"%@%@",CurrentOrders ,phone]]];
//            if (orders && orders.order && orders.order.count) {
//                if (orders) {
//                    //订单动态
//                    for (ZXOrder *order in orders.order) {
//                        if ([order.state isEqualToString:@"已收货"]) {
//                            [self.ordersArray addObject:order];
//                        }
//                    }
//
//                }
//            }
//        }
//    } else {
//        //------当前用户 的订单
//        ZXOrders *orders = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:[NSString stringWithFormat:@"%@%@",CurrentOrders ,userModel.mobile]]];
//
//        if (orders) {
//            if (self.isAllOrder) {
//                //所有订单
//                [self.ordersArray addObjectsFromArray:orders.order];
//            } else {
//                //订单动态
//                for (ZXOrder *order in orders.order) {
//                    if (![order.state isEqualToString:@"已取消"] && ![order.state isEqualToString:@"已收货"]) {
//                        [self.ordersArray addObject:order];
//                    }
//                }
//            }
//        }
//    }
//
//
//    [self.tableView reloadData];
//    [self.view addSubview:self.pageVC.view];
//    [self.pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.top.mas_equalTo(self.searchBar.mas_bottom);
//        make.bottom.mas_equalTo(self.tabBarController.tabBar.mas_top);
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)speechAuthorization{
    __weak typeof(self) weakSelf = self;
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            switch (status) {
                case SFSpeechRecognizerAuthorizationStatusDenied:
                    weakSelf.speechBtn.enabled = NO;
                    [weakSelf.speechBtn setTitle:@"用户未授权使用语音识别" forState:UIControlStateDisabled];
                    break;
                case SFSpeechRecognizerAuthorizationStatusRestricted:
                    weakSelf.speechBtn.enabled = NO;
                    [weakSelf.speechBtn setTitle:@"音识别在这台设备上受到限制" forState:UIControlStateDisabled];
                    break;
                case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                    weakSelf.speechBtn.enabled = NO;
                    [weakSelf.speechBtn setTitle:@"语音识别未授权" forState:UIControlStateDisabled];
                    break;
                case SFSpeechRecognizerAuthorizationStatusAuthorized:
                    weakSelf.speechBtn.enabled = YES;
                    [weakSelf.speechBtn setTitle:@"语音识别" forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
        });
    }];
}

- (IBAction)speechClick:(id)sender {
    if (self.audioEngine.isRunning) {
        [self.audioEngine stop];
        if (_recognitionRequest) {
            [_recognitionRequest endAudio];
        }
//        self.speechBtn.enabled =;
        [self.speechBtn setTitle:@"正在停止" forState:UIControlStateDisabled];
    }
    else {
        [self startRecording];
        [self.speechBtn setTitle:@"停止识别" forState:UIControlStateNormal];
    }
}

-(void)startRecording{
    if (_recognitionTask) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];

    NSError *error;
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    NSParameterAssert(!error);
    [audioSession setMode:AVAudioSessionModeMeasurement error:&error];
    NSParameterAssert(!error);
    
    _recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    NSAssert(inputNode, @"录入设备没有准备好");
    NSAssert(_recognitionRequest, @"请求初始化失败");
    _recognitionRequest.shouldReportPartialResults = YES;
    
    __weak typeof(self) weakSelf = self;
    _recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:_recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        
        __strong typeof(weakSelf) self = weakSelf;
        BOOL isFinal = NO;
//------------录音结果 打印
        if (result) {
            self.searchBar.text = [NSString stringWithFormat:@"%@", result.bestTranscription.formattedString] ;
            [self searchGoods:@[self.searchBar.text]];
            isFinal = result.isFinal;
        }
        
        if (error || isFinal) {
            [self.audioEngine stop];
            [inputNode removeTapOnBus:0];
            self.recognitionTask = nil;
            self.recognitionRequest = nil;
            self.speechBtn.enabled = YES;
            [self.speechBtn setTitle:@"语音识别" forState:UIControlStateNormal];
        }
    }];
    
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
      //在添加tap之前先移除上一个  不然有可能报"Terminating app due to uncaught exception 'com.apple.coreaudio.avfaudio',"之类的错误
    [inputNode removeTapOnBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        __strong typeof(weakSelf) self = weakSelf;
        if (self.recognitionRequest) {
            [self.recognitionRequest appendAudioPCMBuffer:buffer];
        }
    }];
    
    [self.audioEngine prepare];
    [self.audioEngine startAndReturnError:&error];
    NSParameterAssert(!error);
    self.searchBar.text = @"正在录音";
}

#pragma mark - LazyLoad
-(AVAudioEngine *)audioEngine{
    if (!_audioEngine) {
        _audioEngine = [[AVAudioEngine alloc] init];
    }
    return _audioEngine;
}

-(SFSpeechRecognizer *)speechRecognizer{
    if (!_speechRecognizer) {
        NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:local];
        _speechRecognizer.delegate = self;
    }
    return _speechRecognizer;
}

-(ZXStockPageVC *)pageVC {
    if (!_pageVC) {
        _pageVC = [[ZXStockPageVC alloc] init];
//        _pageVC.isHiddenBar = YES;
    }
    return _pageVC;
}
-(NSMutableArray *)goodsArray {
    if (!_goodsArray) {
        _goodsArray = [[NSMutableArray alloc] init];
    }
    return _goodsArray;
}
#pragma mark - SearchDelegate
//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    [self.tableView reloadData];
//    [self searchGoods:@[searchText]];
//}

//键盘上搜索事件的响应
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"搜索");
    [self.tableView reloadData];
    [self searchGoods:@[searchBar.text]];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

#pragma mark - SFSpeechRecognizerDelegate
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    if (available) {
        self.speechBtn.enabled = YES;
        [self.speechBtn setTitle:@"语音识别" forState:UIControlStateNormal];
    } else {
//        self.speechBtn.enabled = NO;
         [self.speechBtn setTitle:@"语音识别不可用" forState:UIControlStateNormal];
    }
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
//        [self getGoodSourcesWithParam:goods];
        [self.tableView reloadData];
    }else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1010) {
        return self.menuArray.count;
    }else {
        if ([self.searchBar.text isEqualToString:@""]) {
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
        cell.contentView.backgroundColor = [UIColor colorWithHexString:@"19CAC8"];
        
        return cell;
    }else{
        ZXGoodsCell02 *cell = [tableView dequeueReusableCellWithIdentifier:ZXGoodsCell];
        __block ZXGoodsModel *goodsModel;
        __weak typeof(self) weakSelf = self;
        
        if ([self.searchBar.text isEqualToString:@""]) {
            goodsModel = self.goodsArray[indexPath.row];
        } else {
            goodsModel = self.searchArray[indexPath.row];
        }
        cell.code.text = goodsModel.offerId;
        cell.name.text = goodsModel.title;
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:goodsModel.img] placeholderImage:[UIImage imageNamed:@"default-ico-none"]];
        cell.price.text = [NSString stringWithFormat:@"%@元/%@",goodsModel.currentPrice ,goodsModel.unit];
        cell.unit.text = goodsModel.unit;
        cell.soldOut.text = [NSString stringWithFormat:@"库存：%ld",goodsModel.num];
        cell.numTextField.text = [NSString stringWithFormat:@"%ld",goodsModel.num];
        cell.deadTime.hidden = NO;
        
        __weak typeof(cell) weakCell = cell;
        [cell.addBtn setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            __strong typeof(cell) cell = weakCell;
//            if (goodsModel.soldOut > goodsModel.num) {
                goodsModel.num ++;
                cell.numTextField.text = [NSString stringWithFormat:@"%ld",(long)goodsModel.num];
                [cell layoutIfNeeded];
//            }
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


- (void)willDismissSearchController:(UISearchController *)searchController{
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 工具，按钮触发事件
-(void)searchGoods:(NSArray *)array{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (ZXGoodsModel *goodsModel in self.goodsArray) {
        if ([goodsModel.title containsString:array[0]]) {
            [mutableArray addObject:goodsModel];
        }
    }
    NSString *str=  [self transformToPinyin:array[0]];
    self.searchArray = mutableArray;
    [self.tableView reloadData];
}
//------下单按钮
- (IBAction)inventoryPost:(id)sender {
    [MBProgressHUD showSuccess:@"提交盘点成功"];
    //-----将收货订单商品存起来 用于 库存管理
    ZXUserModel *userModel = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:UserModelMsg]];
//
//    ZXGoodsArrayModel *goodSourceModel = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:[NSString stringWithFormat:@"%@%@",CurrentStock ,userModel.mobile]]];
    
    ZXGoodsArrayModel *goodSourceModel;
    if (!goodSourceModel) {
        goodSourceModel = [ZXGoodsArrayModel new];
    }
    if (!goodSourceModel.goodsArray) {
        goodSourceModel.goodsArray = [[NSArray alloc] init];
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
//    [array addObjectsFromArray:goodSourceModel.goodsArray];

    for (ZXGoodsModel *model in self.goodsArray) {
        ///---------只弄了 一组数据
        if (model.num >0) {
            [array addObject:model];
        }
    }
    goodSourceModel.goodsArray = array;
    if (userModel.mobile) {
        NSString *str = [NSString stringWithFormat:@"%@%@",CurrentStock,userModel.mobile];
        [kUserDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:goodSourceModel] forKey:str];
        [kUserDefaults synchronize];
    }
    [self.tableView reloadData];
}

-(float)getTotalGoodsPrice {
    
    float allPrice = 0;
    for (ZXGoodsModel *goodsModel in self.goodsArray) {
        allPrice = allPrice + goodsModel.num * goodsModel.currentPrice.floatValue;
    }
    return allPrice;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.tableView endEditing:YES];
    [self.searchBar resignFirstResponder];
    [self.searchBar endEditing:YES];
}


- (NSString *)transformToPinyin:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    int count = 0;
    
    for (int  i = 0; i < pinyinArray.count; i++)
    {
        
        for(int i = 0; i < pinyinArray.count;i++)
        {
            if (i == count) {
                [allString appendString:@"#"];//区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
            
        }
        [allString appendString:@","];
        count ++;
        
    }
    
    NSMutableString *initialStr = [NSMutableString new];//拼音首字母
    
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    
    return allString;
}

@end
