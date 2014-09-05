//
//  JCTViewController.m
//  Jawbone Chart Test
//
//  Created by アンディット ヘリスティヨ on 2014/08/20.
//  Copyright (c) 2014年 Digital Garage. All rights reserved.
//

#import "JCTViewController.h"

// Numerics
CGFloat const kJBBarChartViewControllerChartHeight = 250.0f;
CGFloat const kJBBarChartViewControllerChartPadding = 10.0f;
CGFloat const kJBBarChartViewControllerChartHeaderHeight = 80.0f;
CGFloat const kJBBarChartViewControllerChartHeaderPadding = 10.0f;
CGFloat const kJBBarChartViewControllerChartFooterHeight = 25.0f;
CGFloat const kJBBarChartViewControllerChartFooterPadding = 5.0f;
NSUInteger kJBBarChartViewControllerBarPadding = 1;
NSInteger const kJBBarChartViewControllerNumBars = 12;
NSInteger const kJBBarChartViewControllerMaxBarHeight = 10;
NSInteger const kJBBarChartViewControllerMinBarHeight = 5;
// Strings
NSString * const kJBBarChartViewControllerNavButtonViewKey = @"view";

@interface JCTViewController () <JBBarChartViewDelegate, JBBarChartViewDataSource>

@property (nonatomic, strong) JBBarChartView *barChartView;
@property (nonatomic, strong) NSArray *chartData;
@property (nonatomic, strong) NSArray *monthlySymbols;

- (void)initFakeData;

@end

@implementation JCTViewController

-(void)initFakeData
{
    NSMutableArray *mutableChartData = [NSMutableArray array];
    for (int i=0; i<kJBBarChartViewControllerNumBars; i++)
    {
        NSInteger delta = (kJBBarChartViewControllerNumBars - abs((kJBBarChartViewControllerNumBars - i) - i)) + 2;
        [mutableChartData addObject:[NSNumber numberWithFloat:MAX((delta * kJBBarChartViewControllerMinBarHeight), arc4random() % (delta * kJBBarChartViewControllerMaxBarHeight))]];
    }
    _chartData = [NSArray arrayWithArray:mutableChartData];
    _monthlySymbols = [[[NSDateFormatter alloc] init] shortMonthSymbols];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initFakeData];
    
    // Labels and view stuff
    
    self.leftLabel = [[UILabel alloc] init];
    self.leftLabel.adjustsFontSizeToFitWidth = YES;
    self.leftLabel.textAlignment = NSTextAlignmentLeft;
    self.leftLabel.shadowColor = [UIColor blackColor];
    self.leftLabel.shadowOffset = CGSizeMake(0, 1);
    self.leftLabel.backgroundColor = [UIColor clearColor];
    self.leftLabel.frame = CGRectMake(self.padding, 0, ceil(self.view.bounds.size.width * 0.5) - self.padding, self.view.bounds.size.height);
    self.leftLabel.text = @"Left";
    [self.view addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] init];
    self.rightLabel.adjustsFontSizeToFitWidth = YES;
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    self.rightLabel.shadowColor = [UIColor blackColor];
    self.rightLabel.shadowOffset = CGSizeMake(0, 1);
    self.rightLabel.backgroundColor = [UIColor clearColor];
    self.rightLabel.frame = CGRectMake(CGRectGetMaxX(self.leftLabel.frame), 0, ceil(self.view.bounds.size.width * 0.5) - self.padding, self.view.bounds.size.height);
    self.rightLabel.text = @"Right";
    [self.view addSubview:self.rightLabel];
    
    
    // Logic
    
    self.barChartView = [[JBBarChartView alloc] init];
    self.barChartView.frame = CGRectMake(kJBBarChartViewControllerChartPadding, kJBBarChartViewControllerChartPadding, self.view.bounds.size.width - (kJBBarChartViewControllerChartPadding * 2), kJBBarChartViewControllerChartHeight);
    self.barChartView.delegate = self;
    self.barChartView.dataSource = self;
    self.barChartView.headerPadding = kJBBarChartViewControllerChartHeaderPadding;
    self.barChartView.minimumValue = 0.0f;
    self.barChartView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.barChartView];
    [self.barChartView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.barChartView setState:JBChartViewStateExpanded];
}

#pragma mark - JBBarChartViewDataSource

-(NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
    return kJBBarChartViewControllerNumBars;
}

-(CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index
{
    NSLog(@"%@", [self.chartData objectAtIndex:index]);
    return [[self.chartData objectAtIndex:index] floatValue];
}

-(JBChartView *)chartView
{
    return self.barChartView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end