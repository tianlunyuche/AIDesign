







#import "ZXProductCell01.h"

@interface ZXProductCell01 ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeTop;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addBtnBottom;

@end

@implementation ZXProductCell01

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    [self initEditControl];
//    [self setState:produictCell003StateNormal];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.row = -1;
//    [self.addBtn addTarget:self action:@selector(onClickAdd) forControlEvents:UIControlEventTouchUpInside];
//    _textFieldNum.delegate = self;

}

//- (void)initEditControl
//{
//    _imageViewEditIcon.userInteractionEnabled = YES;
//    CGRect frame = _imageViewEditIcon.frame;
//    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(-20, 0, 47, 72)];
////    v1.backgroundColor = [UIColor redColor];
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reduce:)];    tapGesture.numberOfTapsRequired = 1;
//    v1.userInteractionEnabled = YES;
//    [v1 addGestureRecognizer:tapGesture];
//    [_imageViewEditIcon addSubview:v1];
//    
//    UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width - 30, 0, 47, 72)];
////    v2.backgroundColor = [UIColor yellowColor];
//    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(add:)];
//    tapGesture.numberOfTapsRequired = 1;
//    v2.userInteractionEnabled = YES;
//    [v2 addGestureRecognizer:tapGesture2];
//    [_imageViewEditIcon addSubview:v2];
//}
//
//- (void)setState:(RWProduictCell003State )state
//{
//    _state = state;
//    if (state == produictCell003StateNormal) {
//        _imageViewEditIcon.hidden = YES;
//        _textFieldNum.hidden = YES;
//        _addBtn.hidden = NO;
//        _unitLabel.hidden = NO;
//       self.nameRight.constant =-61.5;
//    }else{
//        _imageViewEditIcon.hidden = NO;
//        _textFieldNum.hidden = NO;
//        _addBtn.hidden = YES;
//        _unitLabel.hidden = YES;
//        self.nameRight.constant =5;
//    }
//}
//
//#pragma mark - UpdateData
//
//-(void)updateDateWithModel:(RWBasicProductModel *)model andPrice:(double)price andUom:(NSString *)uom{
//    
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@", REQ_HOST, model.image.imageMedium];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    [self.icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRetryFailed];
//    self.code.text = model.defaultCode;
//    self.name.text = model.name;
//    self.unit.text = model.unit;
////    NSLog(@"PID: %d, name: %@", model.productID, model.name);
//    if (model.isTwoUnit) {
//        // 是双单位商品
//        self.price.text = [NSString stringWithFormat:@"¥%.2f/%@", model.settlePrice, model.settleUomId];
////        self.unitLabel.text = model.settleUomId;
//    }else{
//        self.price.text = [NSString stringWithFormat:@"¥%.2f/%@", model.price, model.uom];
////        self.unitLabel.text = model.uom;
//    }
////    NSLog(@"uom = %@",model.uom);
//    self.unitLabel.text = model.uom;
//    if (RWModelServerSinglton.userType == UserTypeVisitor) {
//        self.icon.image = [UIImage imageNamed:model.image.imageMedium];
//        self.price.text = [NSString stringWithFormat:@"%.2f/%@", price, uom];
//    }
//}
//
////- (NSString*)fitLabelText:(NSString*)text
////{
////    if (RWModelServerSinglton.device.screenType == DeviceScreenType4in) {
////        
////    }
////}
//
//-(void)loadDataWithID:(int)basicProductID andPrice:(double)price andUom:(NSString *)uom{
//    [self clearShow];
//    
////    RWBasicProductModel *basicProduct = [[RWBasicProductListVM sharedInstance].basicProductsDic objectForKey:[NSNumber numberWithInt:basicProductID]];
//    RWBasicProductModel *basicProduct;
//    if (RWModelServerSinglton.userType == UserTypeVisitor) {
//        basicProduct = [[RWBasicProductListVM sharedInstance].basicProductsDic objectForKey:[NSNumber numberWithInt:basicProductID]];
//    }else{
//        basicProduct = [RWBasicProductModel findByPK:basicProductID];
//    }
//    
//    if (basicProduct) {
//        [self updateDateWithModel:basicProduct andPrice:price andUom:uom];
//    }else{
//        [RWNetWorkRequestServer getBasicProduct:basicProductID withSuccessBlock:^(RWBasicProductModel *productModel) {
//            [self updateDateWithModel:productModel andPrice:price andUom:uom];
//        } withOdooFail:^(NSString *errorStr, NSString *errorCode) {
//        } withFail:^(NSError *error) {
//        } withGetType:GetDataNet];
//    }
//}
//
//-(void)clearShow{
//    self.icon.image = nil;
//    self.code.text = @"";
//    self.name.text = @"加载中...";
//    self.unit.text = @"";
//    self.price.text = @"0";
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    NSLog(@"textFieldDidEndEditing");//onEndEdit
//    SaleBlock(self.onEndEdit, self.indexPath);
//}
//
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    return YES;
//}
//
//
//
//#pragma mark - Action
//
//-(void)onClickAdd{
//    if (self.row != -1) {
//        [self.delegate addToListIndex:self.row];
//    }
//    SaleBlock(self.onclickAddBtn, self.indexPath);
//}
//
//- (void)reduce:(UITapGestureRecognizer *)gesture
//{
//    NSInteger n = [_textFieldNum.text integerValue];
//    n --;
//    _textFieldNum.text = [NSString stringWithFormat:@"%ld",n];
//    if (n == 0) {
//        self.state = produictCell003StateNormal;
//    }
//    SaleBlock(self.onclickReduce, self.indexPath);
//}
//
//- (void)add:(UITapGestureRecognizer *)gesture
//{
//    NSInteger n = [_textFieldNum.text integerValue];
//    n ++;
//    _textFieldNum.text = [NSString stringWithFormat:@"%ld",n];
//    SaleBlock(self.onclickAdd, self.indexPath);
//}
@end
