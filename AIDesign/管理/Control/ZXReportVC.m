//
//  ZXReportVC.m
//  AIDesign
//
//  Created by xinying on 2018/4/22.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXReportVC.h"
#import "AIDesign-Bridging-Header.h"

@interface ZXReportVC ()<ChartViewDelegate>

@property(nonatomic,strong) BarChartView *barChartView;
@property(nonatomic,strong) BarChartData *data;
@property (nonatomic, strong) PieChartView *chartView;

@property(nonatomic,strong) NSArray *parties;
;
@end

@implementation ZXReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPieChartView:self.chartView];
    
    self.chartView.delegate = self;
//
//    ChartLegend *l = _chartView.legend;
//    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
//    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
//    l.orientation = ChartLegendOrientationVertical;
//    l.drawInside = NO;
//    l.xEntrySpace = 7.0;
//    l.yEntrySpace = 0.0;
//    l.yOffset = 0.0;
    
    // entry label styling
    _chartView.entryLabelColor = [UIColor blackColor];
    _chartView.entryLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.f];
    
//    _sliderX.value = 4.0;
//    _sliderY.value = 100.0;
//    [self slidersValueChanged:nil];
    
    self.parties = @[
                @"月销售量", @"Party B", @"Party C", @"Party D", @"Party E", @"Party F",
                @"Party G", @"Party H", @"Party I", @"Party J", @"Party K", @"Party L",
                @"Party M", @"Party N", @"Party O", @"Party P", @"Party Q", @"Party R",
                @"Party S", @"Party T", @"Party U", @"Party V", @"Party W", @"Party X",
                @"Party Y", @"Party Z"
                ];
    
    [_chartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateChartData];
}

- (void)updateChartData
{
//    if (self.shouldHideData)
//    {
//        _chartView.data = nil;
//        return;
//    }
//
    [self setDataCount:4.0 range:100];
}

- (void)setDataCount:(int)count range:(double)range
{
    double mult = range;
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + mult / 5) label:self.parties[i % self.parties.count] icon: [UIImage imageNamed:@"icon"]]];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@"Election Results"];
    
    dataSet.drawIconsEnabled = NO;
    
    dataSet.sliceSpace = 2.0;
    dataSet.iconsOffset = CGPointMake(0, 40);
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    _chartView.data = data;
    [_chartView highlightValues:nil];
}

- (void)optionTapped:(NSString *)key
{
    if ([key isEqualToString:@"toggleXValues"])
    {
        _chartView.drawEntryLabelsEnabled = !_chartView.drawEntryLabelsEnabled;
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"togglePercent"])
    {
        _chartView.usePercentValuesEnabled = !_chartView.isUsePercentValuesEnabled;
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleHole"])
    {
        _chartView.drawHoleEnabled = !_chartView.isDrawHoleEnabled;
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"drawCenter"])
    {
        _chartView.drawCenterTextEnabled = !_chartView.isDrawCenterTextEnabled;
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"animateX"])
    {
        [_chartView animateWithXAxisDuration:1.4];
        return;
    }
    
    if ([key isEqualToString:@"animateY"])
    {
        [_chartView animateWithYAxisDuration:1.4];
        return;
    }
    
    if ([key isEqualToString:@"animateXY"])
    {
        [_chartView animateWithXAxisDuration:1.4 yAxisDuration:1.4];
        return;
    }
    
    if ([key isEqualToString:@"spin"])
    {
        [_chartView spinWithDuration:2.0 fromAngle:_chartView.rotationAngle toAngle:_chartView.rotationAngle + 360.f easingOption:ChartEasingOptionEaseInCubic];
        return;
    }
    
//    [super handleOption:key forChartView:_chartView];
}

#pragma mark - Actions

//- (IBAction)slidersValueChanged:(id)sender
//{
//    _sliderTextX.text = [@((int)_sliderX.value) stringValue];
//    _sliderTextY.text = [@((int)_sliderY.value) stringValue];
//
//    [self updateChartData];
//}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}



#pragma mark - setupPieChartView
- (void)setupPieChartView:(PieChartView *)chartView
{
    chartView.usePercentValuesEnabled = YES;
    chartView.drawSlicesUnderHoleEnabled = NO;
    chartView.holeRadiusPercent = 0.58;
    chartView.transparentCircleRadiusPercent = 0.61;
    chartView.chartDescription.enabled = NO;
    [chartView setExtraOffsetsWithLeft:5.f top:10.f right:5.f bottom:5.f];
    
    chartView.drawCenterTextEnabled = YES;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"Charts\nby Daniel Cohen Gindi"];
    [centerText setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:13.f],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, centerText.length)];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f],
                                NSForegroundColorAttributeName: UIColor.grayColor
                                } range:NSMakeRange(10, centerText.length - 10)];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:11.f],
                                NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]
                                } range:NSMakeRange(centerText.length - 19, 19)];
    chartView.centerAttributedText = centerText;
    
    chartView.drawHoleEnabled = YES;
    chartView.rotationAngle = 0.0;
    chartView.rotationEnabled = YES;
    chartView.highlightPerTapEnabled = YES;
    
    ChartLegend *l = chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationVertical;
    l.drawInside = NO;
    l.xEntrySpace = 7.0;
    l.yEntrySpace = 0.0;
    l.yOffset = 0.0;
}

- (void)setupRadarChartView:(RadarChartView *)chartView
{
    chartView.chartDescription.enabled = NO;
}

- (void)setupBarLineChartView:(BarLineChartViewBase *)chartView
{
    chartView.chartDescription.enabled = NO;
    
    chartView.drawGridBackgroundEnabled = NO;
    
    chartView.dragEnabled = YES;
    [chartView setScaleEnabled:YES];
    chartView.pinchZoomEnabled = NO;
    
    // ChartYAxis *leftAxis = chartView.leftAxis;
    
    ChartXAxis *xAxis = chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    
    chartView.rightAxis.enabled = NO;
}

#pragma mark - LazyLoad

-(PieChartView *)chartView {
    
    if (!_chartView) {
        _chartView = [[PieChartView alloc] init];
        [self.view addSubview:_chartView];
        [_chartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(-100);
        }];
    }
    return _chartView;
}



@end
