//
//  JCTLineChartViewController.m
//  Jawbone Chart Test
//
//  Created by アンディット ヘリスティヨ on 2014/08/22.
//  Copyright (c) 2014年 Digital Garage. All rights reserved.
//

#import "JCTLineChartViewController.h"

// Numerics
NSInteger const numOfDots = 42;
NSInteger const minLineHeight = 5;
NSInteger const maxLineHeight = 10;

@interface JCTLineChartViewController () <JBLineChartViewDelegate, JBLineChartViewDataSource>

@property (nonatomic, strong) JBLineChartView *lineChartView;
@property (nonatomic, strong) NSArray *chartData;
@property (nonatomic, strong) NSArray *monthlySymbols;

- (void)initFakeData;

@end

@implementation JCTLineChartViewController

-(void)initFakeData
{
    NSMutableArray *mutableChartData = [NSMutableArray array];

    // Weather API
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/history/city?q=Tokyo,jp"]];
    NSError *error;
    NSMutableDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSArray *dataArray = parsedData[@"list"];
    
    for (int j=0; j<numOfDots; j++)
    {
        NSNumber *temp = (NSNumber *)dataArray[j][@"main"][@"temp"];
        [mutableChartData addObject:[NSNumber numberWithFloat:([temp floatValue] - 272.15)]];
    }
    
    _chartData = [NSArray arrayWithArray:mutableChartData];
    _monthlySymbols = [[[NSDateFormatter alloc] init] shortMonthSymbols];}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initFakeData];
    
    self.lineChartView = [[JBLineChartView alloc] init];
    self.lineChartView.frame = CGRectMake(10.0, 10.0, self.view.bounds.size.width - (20.0), 250.0);
    self.lineChartView.delegate = self;
    self.lineChartView.dataSource = self;
    self.lineChartView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.lineChartView];
    
    
    
    //NSLog(@"%@", self.chartData);
    //NSLog(@"%@", self.monthlySymbols);
    [self.lineChartView reloadData];
    //NSLog(@"%@", self.chartData);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JBLineChartViewDataSource

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView
{
    return 1;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    return [self.chartData count];
    //return [self.chartData objectAtIndex:lineIndex];
}

#pragma mark - Delegate

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    return [[self.chartData objectAtIndex:horizontalIndex] floatValue];
}

#pragma mark - Override

- (JBChartView *)chartView
{
    return self.lineChartView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
