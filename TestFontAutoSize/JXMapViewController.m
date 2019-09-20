//
//  JXMapViewController.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/5/31.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXMapViewController.h"
#import "GZActionSheet.h"
#import "CLLocation+YCLocation.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
//info.plist
/*
<key>LSApplicationQueriesSchemes</key>
<array>
<string>iosamap</string>
<string>qqmap</string>
<string>comgooglemaps</string>
<string>baidumap</string>
</array>
<key>NSLocationWhenInUseUsageDescription</key>
<string></string>
<key>NSLocationAlwaysUsageDescription</key>
<string></string>
 */
@interface JXMapViewController ()<GZActionSheetDelegate,CLLocationManagerDelegate>

@end

@implementation JXMapViewController{
        double _currentLatitude;
        double _currentLongitute;
        double _targetLatitude;
        double _targetLongitute;
        NSString *_name;
        CLLocationManager *_manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"调用手机导航";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn setTitle:@"指定位置>指定位置" forState:UIControlStateNormal];
    btn.tag=100;
    btn.titleLabel.adjustsFontSizeToFitWidth=YES;
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 250, 100, 50);
    btn1.backgroundColor = [UIColor orangeColor];
    btn1.tag=200;
    [btn1 addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"当前定位位置>指定位置" forState:UIControlStateNormal];
    btn1.titleLabel.adjustsFontSizeToFitWidth=YES;
    btn1.titleLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:btn1];
    
    
    
}
-(void)clicked:(UIButton *)btn{
    NSLog(@"点击出现ACTION");
    if (btn.tag==100) {
        
        [self addressToaddress];
        
    }else{
        [self locationToaddress];
    }
}

#pragma mark --获取地图
+(NSArray *)checkHasOwnApp{
    
    NSArray *mapSchemeArr = @[@"comgooglemaps://",@"iosamap://navi",@"baidumap://map/",@"qqmap://"];
    
    NSMutableArray *appListArr = [[NSMutableArray alloc] initWithObjects:@"苹果原生地图", nil];
    
    for (int i = 0; i < [mapSchemeArr count]; i++) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[mapSchemeArr objectAtIndex:i]]]]) {
            if (i == 0) {
                [appListArr addObject:@"google地图"];
            }else if (i == 1){
                [appListArr addObject:@"高德地图"];
            }else if (i == 2){
                [appListArr addObject:@"百度地图"];
            }else if (i == 3){
                [appListArr addObject:@"腾讯地图"];
            }
        }
    }
    
    return appListArr;
}

#pragma mark --从指定位置到指定位置
-(void)addressToaddress{
    
    
     CLLocation *from = [[CLLocation alloc]initWithLatitude:30.306906 longitude:120.107265];
     CLLocation *fromLoction = [from locationMarsFromEarth];
    //出发地纬度
     _currentLatitude = fromLoction.coordinate.latitude;
    //出发地经度
     _currentLongitute = fromLoction.coordinate.longitude;
    //目的地纬度
     _targetLatitude = 22.488260;
    //目的地经度
     _targetLongitute = 113.915049;
    
    
    [self setActionArrWithAction:YES];
    
}
#pragma mark --从定位当前位置到指定位置
-(void)locationToaddress{
    [self updateLocation];
    //目的地纬度
    _targetLatitude = 22.488260;
    //目的地经度
    _targetLongitute = 113.915049;
    //目的地名字
    _name = @"中海油华英加油站";
    [self setActionArrWithAction:YES];
    
}
#pragma mark --获取当前位置
-(void)updateLocation{
    
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied){
        _manager=[[CLLocationManager alloc]init];
        _manager.delegate=self;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        [_manager requestAlwaysAuthorization];
        _manager.distanceFilter=100;
        [_manager startUpdatingLocation];
    }else{
        UIAlertView *alvertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"需要开启定位服务,请到设置->隐私,打开定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alvertView show];
    }
    //30.306906
   
}
#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    [manager stopUpdatingLocation];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
    //    CLLocation *marLoction = [newLocation locationMarsFromEarth];
    static int i=0;
    i++;
    NSLog(@"%d",i);
    if (i%2==0) {
       
    }
    CLLocation *from = [[CLLocation alloc]initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
    
    CLLocation *fromLoction = [from locationMarsFromEarth];
    _currentLatitude = fromLoction.coordinate.latitude;
    _currentLongitute = fromLoction.coordinate.longitude;
    
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    [self stopLocation];
    
}
-(void)stopLocation
{
    _manager = nil;
}
#pragma mark -- 设置 actionArr
-(void)setActionArrWithAction:(BOOL)action{
      NSArray *appListArr = [JXMapViewController checkHasOwnApp];
    GZActionSheet *sheet = [[GZActionSheet alloc]initWithTitleArray:appListArr andShowCancel:action];
    /** 1. 代理方式 */
    sheet.delegate = self;
    
    /** 2. Block 方式 */
    __weak typeof(self) weakSelf = self;
    sheet.ClickIndex = ^(NSInteger index){
        NSLog(@"Show Index %zi",index);
        NSString *btnTitle= appListArr[index-1];
        if([btnTitle isEqualToString:@"苹果原生地图"]){
            CLLocationCoordinate2D from = CLLocationCoordinate2DMake(_currentLatitude, _currentLongitute);
            MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:from addressDictionary:nil]];
            currentLocation.name = @"我的位置";
            
            //终点
            CLLocationCoordinate2D to = CLLocationCoordinate2DMake(_targetLatitude, _targetLongitute);
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
            NSLog(@"网页google地图:%f,%f",to.latitude,to.longitude);
            toLocation.name = _name;
            NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
            NSDictionary *options = @{
                                      MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                      MKLaunchOptionsMapTypeKey:
                                          [NSNumber numberWithInteger:MKMapTypeStandard],
                                      MKLaunchOptionsShowsTrafficKey:@YES
                                      };
            
            //打开苹果自身地图应用
            [MKMapItem openMapsWithItems:items launchOptions:options];
            
        }
        
        if ([btnTitle isEqualToString:@"google地图"]) {
            NSString *urlStr = [NSString stringWithFormat:@"comgooglemaps://?saddr=%.8f,%.8f&daddr=%.8f,%.8f&directionsmode=transit",_currentLatitude,_currentLongitute,_targetLatitude,_targetLongitute];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        }else if ([btnTitle isEqualToString:@"高德地图"]){
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",_currentLatitude,_currentLongitute,@"我的位置",_targetLatitude,_targetLongitute,_name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *r = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:r];
            //        NSLog(@"%@",_lastAddress);
            
        }else if ([btnTitle isEqualToString:@"腾讯地图"]){
            NSString *urlStr = [NSString stringWithFormat:@"qqmap://map/routeplan?type=drive&fromcoord=%f,%f&tocoord=%f,%f&policy=1",_currentLatitude,_currentLongitute,_targetLatitude,_targetLongitute];
            NSURL *r = [NSURL URLWithString:urlStr];
            [[UIApplication sharedApplication] openURL:r];
        }else if([btnTitle isEqualToString:@"百度地图"]){
            
            CLLocation *from = [[CLLocation alloc]initWithLatitude:_currentLatitude longitude:_currentLongitute];
            CLLocation *fromLoction = [from locationBaiduFromMars];
            CLLocation *to = [[CLLocation alloc]initWithLatitude:_targetLatitude longitude:_targetLongitute];
            CLLocation *toLoction = [to locationBaiduFromMars];
            
            NSString *stringURL = [NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&&mode=driving",fromLoction.coordinate.latitude,fromLoction.coordinate.longitude,toLoction.coordinate.latitude,toLoction.coordinate.longitude];
            NSURL *url = [NSURL URLWithString:stringURL];
            [[UIApplication sharedApplication] openURL:url];
        }
    };
    
    [self.view.window addSubview:sheet];
}
// 显示取消按钮

- (void)actionSheet:(GZActionSheet *)actionSheet clickButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"Show Current Click Index %zi",buttonIndex);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
