//
//  JCTViewController.h
//  Jawbone Chart Test
//
//  Created by アンディット ヘリスティヨ on 2014/08/20.
//  Copyright (c) 2014年 Digital Garage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBChartView/JBChartView.h"
#import "JBChartView/JBBarChartView.h"
#import "JBChartView/JBLineChartView.h"

@interface JCTViewController : UIViewController

@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end
