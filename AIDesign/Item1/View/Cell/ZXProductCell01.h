





#import <UIKit/UIKit.h>


@protocol ZXProductCell01Delegate <NSObject>

-(void)addToListIndex:(NSUInteger)index;

@end

@interface ZXProductCell01 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *unit;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceTip;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewEditIcon;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNum;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void(^onclickAddBtn)(NSIndexPath *indexPath);
@property (nonatomic, copy) void(^onclickAdd)(NSIndexPath *indexPath);
@property (nonatomic, copy) void(^onclickReduce)(NSIndexPath *indexPath);
@property (nonatomic, copy) void(^onEndEdit)(NSIndexPath *indexPath);

-(void )loadDataWithID:(int)basicProductID andPrice:(double)price andUom:(NSString *)uom;

@property (nonatomic, weak) id<ZXProductCell01Delegate> delegate;
@property (nonatomic, assign) NSInteger row;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameRight;

@end
