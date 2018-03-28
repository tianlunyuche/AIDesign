//
//  ZXConversationVC.m
//  AIDesign
//
//  Created by xinying on 2018/3/20.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXConversationVC.h"
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>

@interface ZXConversationVC ()<SFSpeechRecognizerDelegate>
@property(nonatomic,strong) SFSpeechRecognizer *speechRecognizer;
@property(nonatomic,strong) AVAudioEngine *audioEngine;
@property(nonatomic,strong) SFSpeechRecognitionTask *recognitionTask;
@property(nonatomic,strong) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;

@property(nonatomic,assign) BOOL isSpeechRecognizer;
@end

@implementation ZXConversationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self addSureButton];
}

- (void)onBeginRecordEvent {
    
    [self startRecording];
}

-(void)onEndRecordEvent{

    if (self.audioEngine.isRunning) {
        [self.audioEngine stop];
        if (_recognitionRequest) {
            [_recognitionRequest endAudio];
        }
    }
}

-(void)addSureButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btn setTitle:@"确 定"  forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.chatSessionInputBarControl addSubview:btn];
    [self.chatSessionInputBarControl bringSubviewToFront:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.chatSessionInputBarControl.recordButton);

    }];
    //-----------
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
                  
                    break;
                case SFSpeechRecognizerAuthorizationStatusRestricted:
               
                    break;
                case SFSpeechRecognizerAuthorizationStatusNotDetermined:
               
                    break;
                case SFSpeechRecognizerAuthorizationStatusAuthorized:
//                    weakSelf.speechBtn.enabled = YES;
//                    [weakSelf.speechBtn setTitle:@"开始录音" forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
        });
    }];
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
            self.chatSessionInputBarControl.currentBottomBarStatus = KBottomBarKeyboardStatus;
            self.chatSessionInputBarControl.inputTextView.text = [NSString stringWithFormat:@"%@", result.bestTranscription.formattedString] ;
            isFinal = result.isFinal;
        }
        
        if (error || isFinal) {
            [self.audioEngine stop];
            [inputNode removeTapOnBus:0];
            self.recognitionTask = nil;
            self.recognitionRequest = nil;
//            self.speechBtn.enabled = YES;
//            [self.speechBtn setTitle:@"开始录音" forState:UIControlStateNormal];
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
//    self.resultlabel.text = @"正在录音";
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

#pragma mark - SFSpeechRecognizerDelegate
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    if (available) {
//        self.speechBtn.enabled = YES;
//        [self.speechBtn setTitle:@"开始录音" forState:UIControlStateNormal];
    } else {
//        self.speechBtn.enabled = NO;
//        [self.speechBtn setTitle:@"语音识别不可用" forState:UIControlStateNormal];
    }
}
@end
