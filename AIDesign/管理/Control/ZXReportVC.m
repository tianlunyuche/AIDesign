//
//  ZXReportVC.m
//  AIDesign
//
//  Created by xinying on 2018/4/22.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXReportVC.h"
#import "AIDesign-Bridging-Header.h"
#import "JHGridView.h"
#import "TestObject.h"

@interface ZXReportVC ()<ChartViewDelegate,JHGridViewDelegate>

@property(nonatomic,strong) BarChartView *barChartView;
@property(nonatomic,strong) BarChartData *data;
@property (nonatomic, strong) PieChartView *chartView;

@property(nonatomic,strong) NSArray *parties;
@property(nonatomic,strong) JHGridView *gridView;
@property(nonatomic,strong) UIButton *selectBtn;
@end

@implementation ZXReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupPieChartView:self.chartView];
    self.title  = self.name;
    self.chartView.delegate = self;

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
    switch (self.row) {
        case 0:
            self.parties = @[
                             @"1月份", @"2月份",@"3月份",@"4月份",
                             @"5月份", @"6月份",@"7月份",@"8月份",
                             @"9月份", @"10月份",@"11月份",@"12月份"
                             ];
            break;
        case 1:
            self.parties = @[
                             @"第一季度", @"第二季度",@"第三季度",@"第四季度"
                             ];
            break;
        case 2:
            self.parties = @[
                             @"2014年", @"2015年",@"2016年",@"2017年"
                             ];
            break;
        default:
            self.parties = @[
                             @"2014年", @"2015年",@"2016年",@"2017年"
                             ];
            break;
    }

    [_chartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
    
    ///--------
    NSArray *array = @[[[TestObject alloc] initWithName:@"一月份" Sex:@"500" Number:@"19%" Address:@"sdfabfsakjbakf" Birthday:@"1996-06-14"],
                       [[TestObject alloc] initWithName:@"二月份" Sex:@"403" Number:@"16%" Address:@"sdfabfsakjbakf" Birthday:@"1996-06-14"],
                       [[TestObject alloc] initWithName:@"三月份" Sex:@"302" Number:@"13%" Address:@"sdfabfsakjbakf" Birthday:@"1996-06-14"],
                       [[TestObject alloc] initWithName:@"四月份" Sex:@"207" Number:@"6%" Address:@"sdfabfsakjbakf" Birthday:@"1996-06-14"],
                       [[TestObject alloc] initWithName:@"五月份" Sex:@"133" Number:@"4%" Address:@"sdfabfsakjbakf" Birthday:@"1996-06-14"],
                       [[TestObject alloc] initWithName:@"六月份" Sex:@"345" Number:@"15%" Address:@"sdfabfsakjbakf" Birthday:@"1996-06-14"],
                       [[TestObject alloc] initWithName:@"七月份" Sex:@"232" Number:@"7%" Address:@"sdfabfsakjbakf" Birthday:@"1996-06-14"],
                       [[TestObject alloc] initWithName:@"八月份" Sex:@"121" Number:@"3%" Address:@"sdfabfsakjbakf" Birthday:@"1996-06-14"],
                       [[TestObject alloc] initWithName:@"九月份" Sex:@"323" Number:@"14%" Address:@"sdfabfsakjbakf" Birthday:@"1996-06-14"],
                       [[TestObject alloc] initWithName:@"十月份" Sex:@"322" Number:@"14%" Address:@"sdfabfsakjbakf" Birthday:@"1996-06-14"],
                       [[TestObject alloc] initWithName:@"十一月份" Sex:@"232" Number:@"7%" Address:@"sdfabfsakjbakf" Birthday:@"1996-06-14"],
                       [[TestObject alloc] initWithName:@"十二月份" Sex:@"593" Number:@"23%" Address:@"sdfabfsakjbakf" Birthday:@"1996-06-14"]];
    [self.gridView setTitles:@[@"月份",
                          @"销售量",
                          @"百分比"]
             andObjects:array withTags:@[@"name",@"sex",@"number"]];
    
    self.gridView.hidden = YES;
    [self.selectBtn addTarget:self action:@selector(selectBtn2) forControlEvents:UIControlEventTouchUpInside];
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
    switch (self.row) {
        case 0:
            [self setDataCount:12.0 range:100];
            break;
        case 1:
            [self setDataCount:4.0 range:100];
            break;
        default:
            [self setDataCount:4.0 range:100];
            break;
    }
}

- (void)setDataCount:(int)count range:(double)range
{
    double mult = range;
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + mult / 5) label:self.parties[i % self.parties.count] icon: [UIImage imageNamed:@"icon"]]];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@""];
    
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
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.f]];
    [data setValueTextColor:UIColor.blackColor];
    
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
-(void)selectBtn2 {
    if (!self.selectBtn.isSelected) {
        self.gridView.hidden = NO;
        self.chartView.hidden = YES;
    } else {
        self.gridView.hidden = YES;
        self.chartView.hidden = NO;
    }
    self.selectBtn.selected = !self.selectBtn.isSelected;

}

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
    
    NSMutableAttributedString *centerText;
    switch (self.row) {
        case 0:
            centerText = [[NSMutableAttributedString alloc] initWithString:@"12个月的销售总量\n所占一年的百分比"];
            break;
        case 1:
            centerText = [[NSMutableAttributedString alloc] initWithString:@"2017年各个季度的销售总量\n所占一年的百分比"];
            break;
        case 2:
            centerText = [[NSMutableAttributedString alloc] initWithString:@"2014-2017年的销售总量\n所占这个四年总和的百分比"];
            break;
        case 3:
            centerText = [[NSMutableAttributedString alloc] initWithString:@"2014-2017年的销售总额\n所占这个四年总和的百分比"];
            break;
        case 4:
            centerText = [[NSMutableAttributedString alloc] initWithString:@"2014-2017年的采购总额\n所占这个四年总和的百分比"];
            break;
        case 5:
            centerText = [[NSMutableAttributedString alloc] initWithString:@"2014-2017年的年利润\n所占这个四年总和的百分比"];
            break;
        default:
            break;
    }

    
    [centerText setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:13.f],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, centerText.length)];
    [centerText addAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f],
                                NSForegroundColorAttributeName: UIColor.grayColor
                                } range:NSMakeRange(10, centerText.length - 10)];
//    [centerText addAttributes:@{
//                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:11.f],
//                                NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]
//                                } range:NSMakeRange(centerText.length - 19, 19)];
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
            make.top.mas_equalTo(64);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-100);
        }];
    }
    return _chartView;
}

-(JHGridView *)gridView {
    if (!_gridView) {
        _gridView = [[JHGridView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 400)];
        _gridView.delegate = self;
        [self.view addSubview:_gridView];
    }
    return _gridView;
}

-(UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setTitle:@"切换模式" forState:UIControlStateNormal];
        [_selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:_selectBtn];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-80);
            make.size.mas_equalTo(CGSizeMake(100, 50));
        }];
    }
    return _selectBtn;
}

#pragma mark -  gridview
- (void)didSelectRowAtGridIndex:(GridIndex)gridIndex{
    NSLog(@"selected at\ncol:%ld -- row:%ld", gridIndex.col, gridIndex.row);
}

- (BOOL)isTitleFixed {
    return YES;
}

- (CGFloat)widthForColAtIndex:(long)index{
    if (index==3||index==4) {
        return 120;
    }else{
        return 120;
    }
}

- (UIColor *)backgroundColorForTitleAtIndex:(long)index{
    return [UIColor colorWithRed:229/255.0 green:114/255.0 blue:30/255.0 alpha:1];
}

- (UIColor *)backgroundColorForGridAtGridIndex:(GridIndex)gridIndex{
    if (gridIndex.row == 2) {
        return [UIColor cyanColor];
    }else if (gridIndex.col == 4){
        return [UIColor yellowColor];
    }else{
        return [UIColor whiteColor];
    }
}

- (UIColor *)textColorForTitleAtIndex:(long)index{
    if (index==1) {
        return [UIColor whiteColor];
    }else{
        return [UIColor blackColor];
    }
}

- (UIColor *)textColorForGridAtGridIndex:(GridIndex)gridIndex{
    if (gridIndex.col == 1) {
        return [UIColor blueColor];
    }else{
        return [UIColor blackColor];
    }
}

- (UIFont *)fontForTitleAtIndex:(long)index{
    return [UIFont systemFontOfSize:20];
}

//  @[
//@"月销售量", @"Party B", @"Party C", @"Party D", @"Party E", @"Party F",
//@"Party G", @"Party H", @"Party I", @"Party J", @"Party K", @"Party L",
//@"Party M", @"Party N", @"Party O", @"Party P", @"Party Q", @"Party R",
//@"Party S", @"Party T", @"Party U", @"Party V", @"Party W", @"Party X",
//@"Party Y", @"Party Z"
//];

@end
