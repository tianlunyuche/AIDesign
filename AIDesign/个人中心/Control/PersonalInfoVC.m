//
//  PersonalInfoVC.m
//  paohon_v1_0
//
//  Created by xinying on 2017/1/17.
//  Copyright © 2017年 paohon. All rights reserved.
//

#import "PersonalInfoVC.h"
#import "ASBirthSelectSheet.h"
#import "ZXPhoto.h"
#import "ZXUserModel.h"

@interface PersonalInfoVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource ,UITextFieldDelegate>
{
    int sex;
    //keychain
    KeyChain *keychain;
}

@property(nonatomic, strong) NSData *fileData;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong)ZXUserModel *user;
@property(nonatomic, strong)ZXPhoto *photoOperate;

@end

@implementation PersonalInfoVC

- (void)viewDidLoad {
    self.title=@"修改个人信息";
    [super viewDidLoad];
    self.view.backgroundColor =kbackgdColor;
   
    [self.view addSubview:self.personView];
    [self.personView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.personView.userInteractionEnabled =YES;
    
    self.personView.qqfld.delegate =self;
    self.personView.mailfld.delegate =self;
    self.personView.heighfld.delegate =self;
    self.personView.weighfld.delegate =self;
    
    [self.personView.postBtn addTarget:self action:@selector(postPersonInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [self.photoOperate removeItemwithPath:[self.photoOperate filePath:@"selfTemporPhoto.png"]];
    
    [self.personView Sexselected:0];
    
    [kNotificationCenter addObserver:self selector:@selector(takePictureClick:) name:@"takePicture" object:nil];
    [kNotificationCenter addObserver:self selector:@selector(ChooseSex:) name:@"manNotificate" object:nil];
    [kNotificationCenter addObserver:self selector:@selector(ChooseSex:) name:@"womanNotificate" object:nil];
    [kNotificationCenter addObserver:self selector:@selector(birthClk) name:@"birthNotificate" object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    //将coredata储存的用户数据 显示到界面
    NSArray *userArray;
//    NSArray *userArray =[[CoreDataManager sharedCoreDataManager] fentchEntityName:@"ZXUserModel" predicate:[NSPredicate predicateWithFormat:@"uid = %@",[KeyChain account]] orderby:nil];
//    if (userArray !=nil) {
//        for (ZXUserModel *userOjc in userArray) {
//
//             self.user =userOjc;
//        }
//
//        self.personView.usern.text =self.user.nickname;
//        self.personView.trueName.text =self.user.compellation;
//
//        if([self.user.sex isEqual: @0]){
//            [kNotificationCenter postNotificationName:@"manNotificate" object:nil];
//        }else if([self.user.sex isEqual: @1]){
//            [kNotificationCenter postNotificationName:@"womanNotificate" object:nil];
//        }
    
//        self.personView.weighfld.text =self.user.weight;
//        self.personView.heighfld.text =self.user.height;
        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateStyle:NSDateFormatterMediumStyle];
//        [formatter setTimeStyle:NSDateFormatterShortStyle];
//        [formatter setDateFormat:@"YYYY-MM-dd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//        //      时间戳转时间的方法:
//        if (self.user.birthday !=nil) {
//
//            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:
//                                     [self.user.birthday longValue]/1000];
//            NSLog(@"createTime =%@",confromTimesp);
//            NSString *timespStr = [formatter stringFromDate:confromTimesp];
//            NSArray *array = [timespStr componentsSeparatedByString:@" "];
//
//            self.personView.birthlabel.text =[array objectAtIndex:0];
//
//            self.personView.qqfld.text =self.user.qq;
//            self.personView.mailfld.text =self.user.email;
//            self.personView.pholabel.text =self.user.mobile;
//        }
//    }
}


- (void)disMsg{
    
//    usrMsg =[kUserDefaults objectForKey:@"usrMsg"];
////    - (void)deleteData:(NSString *)entityName byattr:(NSString *)attr andValue:(NSString *)value
////    getStatusByAttr
//    self.personView.usern.text =[usrMsg objectForKey:@"nickname"];
//    self.personView.trueName.text =[usrMsg objectForKey:@"compellation"];
//
//    if([[usrMsg objectForKey:@"sex"]  isEqual: @0]){
////        [self Chooseman];
//    }else if([[usrMsg objectForKey:@"sex"]  isEqual: @1]){
////        [self Choosewoman];
//    }

}

#pragma mark - 提交
- (void)postPersonInfo{
    
    
    //基础数据类型转成对象
    NSNumber* height =[[NSNumber alloc]initWithFloat:self.personView.heighfld.text.floatValue];
    NSNumber* weight =[[NSNumber alloc]initWithFloat:self.personView.weighfld.text.floatValue];
    NSNumber* sexnum =[[NSNumber alloc] initWithInt:sex];
    //提交 用户基本信息

//    [self.reqObj correctUserMsgwithview:self.view birth:self.personView.birthlabel.text email:self.personView.mailfld.text height:height nickname:self.personView.usern.text qq:self.personView.qqfld.text sex:sexnum compellation:self.personView.trueName.text weight:weight success:^(id result) {
//
//        NSLog(@"result =%@",[NSThread currentThread]);
//        if ([result isEqual:@"success"]) {
//
//            [self performSelector:@selector(dismissController) withObject:nil afterDelay:1];
//        }
//    }];
    
//  是否选中了其他图片
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self.photoOperate filePath:@"selfTemporPhoto.png"]]) {
        //分表单提交用户头像
//        [self.reqObj correctUsrportrait:self.view];
    }
}

- (void)dismissController{
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0]
                                          animated:YES];
}

#pragma mark - 返回按钮事件触发
- (void)pressBack{
    
    [self.photoOperate removeItemwithPath:[self.photoOperate filePath:@"selfTemporPhoto.png"]];
    //将当前的视图控制器弹出，返回到上一级界面
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 生日事件选择

- (void)birthClk{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
        datesheet.selectDate = self.personView.birthlabel.text;
        
        [self.view addSubview:datesheet];
        
        datesheet.GetSelectDate = ^(NSString *dateStr) {
            NSLog(@"GetSelectDate %@",[NSThread currentThread]);
            self.personView.birthlabel.text = dateStr;
        };

    });
    //创建对话框控制器 ，UIAlertControllerStyleAlert
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择日期" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    
//    //分割线1
//    UIView *line1 = [[UIView alloc] init];
//    [line1 setBackgroundColor:klineColor];
//    [alert.view addSubview:line1];
//    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(alert.view.mas_top).offset(50);
//        make.left.equalTo(alert.view.mas_left).offset(30);
//        make.right.equalTo(alert.view.mas_right).offset(-30);
//        make.height.equalTo(@(1));
//    }];
//    //创建日期
//    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
//    datePicker.datePickerMode = UIDatePickerModeDate;
//    
//    datePicker.center=self.view.center;
//    [alert.view addSubview:datePicker];
//    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(line1.mas_top).offset(10);
//        make.left.equalTo(alert.view.mas_left);
//        make.right.equalTo(alert.view.mas_right);
//        make.height.equalTo(@(200));
//    }];
//    
//    //添加 完成按钮
//    [alert addAction:[UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
//        
//        //实例化一个NSDateFormatter对象
//        [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
//        
//        _birthlabel.text = [dateFormat stringFromDate:datePicker.date];
    
        //求出当天的时间字符串
//        NSLog(@"%@",[dateFormat stringFromDate:datePicker.date]);
//    }]];
//    //添加取消按钮
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//    }]];
//    
//    [self presentViewController:alert animated:YES completion:^{ }];
    
}

#pragma mark - 男女性别选择
- (void)ChooseSex:(NSNotification *)knotifiacate{
    
    if ([knotifiacate.name isEqualToString:@"manNotificate"]) {
        NSLog(@"Chooseman");
        sex =0;
        [self.personView Sexselected:sex];
    }else
        if ([knotifiacate.name isEqualToString:@"womanNotificate"]) {
            
            sex =1;
            [self.personView Sexselected:sex];
        }

}

#pragma mark -  从相册获取图片
-(void)takePictureClick:(UIButton *)sender
{   NSLog(@"takePictureClick =%@",[NSThread currentThread]);
    //    /*注：使用，需要实现以下协议：UIImagePickerControllerDelegate,
    //     UINavigationControllerDelegate
    //     */
    //    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    //    //设置图片源(相簿)
    //    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    //    //设置代理
    //    picker.delegate = self;
    //    //设置可以编辑
    //    picker.allowsEditing = YES;
    //    //打开拾取器界面
    //    [self presentViewController:picker animated:YES completion:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"上传照片"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"拍照",@"从相册中选择",nil];
        [actionSheet showInView:self.view];
    });
}

#pragma mark -  UIActionSheet Delegate 代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0: //照相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1: //从相册中选择
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 头像：UIImagePickerController Delegate代理对象
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        //可编辑的图像
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        //触发事件： 生成缩略图并且保存图片
        self.personView.avatarImgView.clipsToBounds =YES;
        self.personView.avatarImgView.image =[UIImage circleImage:img];
        
        //保存当前选中头像
//        [self.queue addOperationWithBlock:^{
//            NSLog(@"current thread %@",[NSThread currentThread]);
//            [self.photoOperate saveImage:self.personView.avatarImgView.image imageName:@"selfTemporPhoto.png" toImagView:nil];
//        }];
    }
    else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        NSString *videoPath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        self.fileData = [NSData dataWithContentsOfFile:videoPath];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextField 代理方法
//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 316.0);//键盘高度316
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];

}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)dealloc{
    
    [kNotificationCenter removeObserver:self name:@"takePicture" object:nil];
    [kNotificationCenter removeObserver:self name:@"manNotificate" object:nil];
    [kNotificationCenter removeObserver:self name:@"womanNotificate" object:nil];
    [kNotificationCenter removeObserver:self name:@"birthNotificate" object:nil];
}

#pragma mark - LazyLoad

- (ZXUserModel *)user{
    
    if (!_user) {
        _user =[[ZXUserModel alloc] init];
    }
    return _user;
}

- (ZXPhoto *)photoOperate{
    
    if(!_photoOperate){
        _photoOperate=[[ZXPhoto alloc] init];
    }
    return _photoOperate;
}

- (PersonalContent *)personView{
    
    if (!_personView) {
        _personView =[[PersonalContent alloc] init];
        _personView.contentSize = CGSizeMake(kScreenWidth, 700);//滚动条视图内容范围的大小
        _personView.showsHorizontalScrollIndicator = FALSE;//水平滚动条是否显示
        _personView.showsVerticalScrollIndicator = FALSE;//垂直滚动条是否显示
        _personView.delaysContentTouches =YES;
        _personView.canCancelContentTouches =NO;
    }
    return _personView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
