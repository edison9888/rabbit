//
//  MainMapViewController.m
//  rabbitSister
//
//  Created by Jahnny on 13-11-7.
//  Copyright (c) 2013年 ownerblood. All rights reserved.
//

#import "MainMapViewController.h"
#import "MapViewController.h"

#define MainViewControllerTitle @"高德地图API-2D"

@interface MainMapViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *classNames;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;

@end

@implementation MainMapViewController
@synthesize titles      = _titles;
@synthesize classNames  = _classNames;
@synthesize tableView   = _tableView;

@synthesize mapView     = _mapView;
@synthesize search      = _search;

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titles[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 0 ? @"MAMapKit" : @"AMapSearchKit";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mainCellIdentifier = @"mainCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.titles[indexPath.section][indexPath.row];
    
    cell.detailTextLabel.text = self.classNames[indexPath.section][indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = self.classNames[indexPath.section][indexPath.row];
    
    MapViewController *subViewController = [[NSClassFromString(className) alloc] init];
    
    subViewController.title   = self.titles[indexPath.section][indexPath.row];
    subViewController.mapView = self.mapView;
    subViewController.search  = self.search;
    
    [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
}

#pragma mark - Initialization

- (void)initTitles
{
    NSArray *mapTitles = @[@"类型",
                           @"交通",
                           @"手势",
                           @"Overlay",
                           @"自定义Overlay",
                           @"Annotation",
                           @"自定义Annotation",
                           @"定位",
                           @"截屏"];
    
    NSArray *searchTitles = @[@"POI",
                              @"导航",
                              @"地理编码+输入提示",
                              @"逆地理编码",
                              @"公交路线",
                              @"公交站"];
    
    self.titles = [NSArray arrayWithObjects:mapTitles, searchTitles, nil];
    
}

- (void)initClassNames
{
    NSArray *mapClassNames = @[@"MapTypeViewController",
                               @"TrafficViewController",
                               @"GestureAttributesViewController",
                               @"OverlayViewController",
                               @"CustomOverlayViewController",
                               @"AnnotationViewController",
                               @"CustomAnnotationViewController",
                               @"UserLocationViewController",
                               @"ScreenshotViewController"];
    
    NSArray *searchClassNames = @[@"PoiViewController",
                                  @"NavigationViewController",
                                  @"GeoViewController",
                                  @"InvertGeoViewController",
                                  @"BusLineViewController",
                                  @"BusStopViewController"];
    
    self.classNames = [NSArray arrayWithObjects:mapClassNames, searchClassNames, nil];
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
}

/* 初始化search. */
- (void)initSearch
{
    self.search = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
}

#pragma mark - Life Cycle

- (id)init
{
    if (self = [super init])
    {
        self.title = MainViewControllerTitle;
        
        /* 初始化search. */
        [self initSearch];
        
        [self initTitles];
        
        [self initClassNames];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTableView];
    
    [self initMapView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle    = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController setToolbarHidden:YES animated:animated];
}

@end
