//
//  YMLocationManager.h
//  XMLY
//
//  Created by 于光超 on 2021/2/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YMLocationManager : NSObject
@property (nonatomic,strong) MKMapView *mapView;
+ (instancetype)sharedInstance;
- (void)startLocation;
- (void)stopLocation;

- (BOOL)isOpenLocationServiceSwitch;

- (void)queryLocationAuthority:(void (^)(BOOL isOpenLocationAuth))callback;

- (void)queryLocationFullAccuracyAuthority:(void (^)(BOOL isOpenLocationAuth))callback;
@end

NS_ASSUME_NONNULL_END
