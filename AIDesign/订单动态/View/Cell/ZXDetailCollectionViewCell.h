//
//  ZXDetailCollectionViewCell.h
//  AIDesign
//
//  Created by xinying on 2018/4/7.
//  Copyright © 2018年 habav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXDetailCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *line;
@property(nonatomic,assign) NSInteger cellLocation;
@end
