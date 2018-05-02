//
//  ZXSexChoice.h
//  paohon
//
//  Created by xinying on 2017/4/15.
//  Copyright © 2017年 habav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXSexChoice : NSObject

@property(nonatomic,copy)NSString *label;

@property(nonatomic,copy)NSString *btnImage;

@property(nonatomic,copy)NSString *sexImg;

+ (ZXSexChoice *)sharedman;

+ (ZXSexChoice *)sharedwoman;

- (void)manSelected;

- (void)manDiselected;

- (void)womanSelected;

- (void)womanDiselected;

@end
