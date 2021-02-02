//
//  YMLocationManager.m
//  XMLY
//
//  Created by 于光超 on 2021/2/2.
//

#import "YMLocationManager.h"
#import <CoreLocation/CoreLocation.h>
@interface YMLocationManager () <CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager;
@end
@implementation YMLocationManager
+ (instancetype)sharedInstance
{
    static YMLocationManager *_instance;
    static dispatch_once_t onceDispatch;
    dispatch_once(&onceDispatch, ^{
      _instance = [self new];
    });
    return _instance;
}
#pragma mark - public func
- (void)startLocation
{
    [self.locationManager startUpdatingLocation];
}
- (void)stopLocation
{
    [self.locationManager stopUpdatingLocation];
}
- (BOOL)isOpenLocationServiceSwitch
{
    return [CLLocationManager locationServicesEnabled];
}
- (void)queryLocationAuthority:(void (^)(BOOL isOpenLocationAuth))callback;
{
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    else if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusRestricted ||
             CLLocationManager.authorizationStatus == kCLAuthorizationStatusDenied) {
        callback ? callback(NO) : nil;
    }
    else if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
             CLLocationManager.authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse){
        callback ? callback(YES) : nil;
    }else{
        
    }
}

- (void)queryLocationFullAccuracyAuthority:(void (^)(BOOL isOpenLocationAuth))callback;
{
    if (@available(iOS 14.0, *)) {
        if (self.locationManager.accuracyAuthorization == CLAccuracyAuthorizationFullAccuracy) {
            callback ? callback(YES) : nil;
        }
        else {
            callback ? callback(NO) : nil;
        }
    }
}
- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = ({
            CLLocationManager *manager = [[CLLocationManager alloc] init];
            manager.delegate = self;
            manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
            manager.distanceFilter = 10.f;
            manager;
        });
    }
    return _locationManager;
}
- (MKMapView *)mapView
{
    if (!_mapView) {
        _mapView = ({
            MKMapView *view  = [[MKMapView alloc] init];
            view.mapType = MKMapTypeStandard;
            view.zoomEnabled = YES;
            view.scrollEnabled = YES;
            view.rotateEnabled = YES;
            view.showsUserLocation = YES;
            view.userTrackingMode = MKUserTrackingModeFollowWithHeading;
            view;
        });
    }
    return _mapView;
}
@end
