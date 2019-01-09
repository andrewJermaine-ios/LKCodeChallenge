//
//  AndrewSmithLKCodeChallengeTests.m
//  AndrewSmithLKCodeChallengeTests
//
//  Created by Andrew on 1/7/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface AndrewSmithLKCodeChallengeTests : XCTestCase
@property MKMapView *mapView;
@property ViewController *polyGeoVC;
@property(nonatomic) MKFeatureDisplayPriority displayPriority;


@end

@implementation AndrewSmithLKCodeChallengeTests
CLLocationCoordinate2D centerPolygon;



- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _polyGeoVC = [[ViewController alloc]init];
    [_polyGeoVC viewDidLoad];

}
- (void) testDecodePayload {
    NSString *base64String;
    NSString *decodedString;
    NSData *decodedData;
    
    base64String = @"ewogICJjb29yZGluYXRlcyI6IFsKICAgIHsKICAgICAgImxhdCI6IDM2LjEyMDYyNCwKICAgICAgImxvbiI6IC0xMTUuMTU3NDg2CiAgICB9LAogICAgewogICAgICAibGF0IjogMzYuMTIxMDE4LAogICAgICAibG9uIjogLTExNS4xNTc0ODQKICAgIH0sCiAgICB7CiAgICAgICJsYXQiOiAzNi4xMjEwMDksCiAgICAgICJsb24iOiAtMTE1LjE1NjAxMgogICAgfSwKICAgIHsKICAgICAgImxhdCI6IDM2LjEyMDUyOCwKICAgICAgImxvbiI6IC0xMTUuMTU2MDIzCiAgICB9LAogICAgewogICAgICAibGF0IjogMzYuMTIwNTI4LAogICAgICAibG9uIjogLTExNS4xNTY5MDgKICAgIH0KICBdCn0=";
    
    decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    if(decodedString == nil)XCTFail(@"Decoded string should not be empty");

}

- (void) testAnnotationIsNotNil {
    centerPolygon.latitude = 25.75;
    centerPolygon.longitude = -116.949;
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    MKPointAnnotation *emptyPoint = [[MKPointAnnotation alloc] init];
    
    point.coordinate = centerPolygon;

    XCTAssertNotEqual(emptyPoint, point, @"These values should not be equal");
    
}

- (void)testDisplayPriority {
    _displayPriority = 1000;
    
    if (_displayPriority < 1000)XCTFail(@"Display priority should be 1000");
}

- (void) testParseJSONForLatKey {
    double lat1;
    double constant;
    NSString *base64String;
    NSString *decodedString;
    NSData *decodedData;
    
    constant = 36.120624;
    
    base64String = @"ewogICJjb29yZGluYXRlcyI6IFsKICAgIHsKICAgICAgImxhdCI6IDM2LjEyMDYyNCwKICAgICAgImxvbiI6IC0xMTUuMTU3NDg2CiAgICB9LAogICAgewogICAgICAibGF0IjogMzYuMTIxMDE4LAogICAgICAibG9uIjogLTExNS4xNTc0ODQKICAgIH0sCiAgICB7CiAgICAgICJsYXQiOiAzNi4xMjEwMDksCiAgICAgICJsb24iOiAtMTE1LjE1NjAxMgogICAgfSwKICAgIHsKICAgICAgImxhdCI6IDM2LjEyMDUyOCwKICAgICAgImxvbiI6IC0xMTUuMTU2MDIzCiAgICB9LAogICAgewogICAgICAibGF0IjogMzYuMTIwNTI4LAogICAgICAibG9uIjogLTExNS4xNTY5MDgKICAgIH0KICBdCn0=";
    
    decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    
    NSData *data = [decodedString dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    lat1 = [[[json valueForKey:@"coordinates"][0] valueForKey:@"lat"] doubleValue];
    
    if (lat1 != constant)XCTFail(@"JSON was not properly parsed");


}

- (void) testParseJSONForLonKey {
    double lon1;
    double constant;
    NSString *base64String;
    NSString *decodedString;
    NSData *decodedData;
    
    constant = -115.157486;
    
    base64String = @"ewogICJjb29yZGluYXRlcyI6IFsKICAgIHsKICAgICAgImxhdCI6IDM2LjEyMDYyNCwKICAgICAgImxvbiI6IC0xMTUuMTU3NDg2CiAgICB9LAogICAgewogICAgICAibGF0IjogMzYuMTIxMDE4LAogICAgICAibG9uIjogLTExNS4xNTc0ODQKICAgIH0sCiAgICB7CiAgICAgICJsYXQiOiAzNi4xMjEwMDksCiAgICAgICJsb24iOiAtMTE1LjE1NjAxMgogICAgfSwKICAgIHsKICAgICAgImxhdCI6IDM2LjEyMDUyOCwKICAgICAgImxvbiI6IC0xMTUuMTU2MDIzCiAgICB9LAogICAgewogICAgICAibGF0IjogMzYuMTIwNTI4LAogICAgICAibG9uIjogLTExNS4xNTY5MDgKICAgIH0KICBdCn0=";
    
    decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    
    NSData *data = [decodedString dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    lon1 = [[[json valueForKey:@"coordinates"][0] valueForKey:@"lon"] doubleValue];
    
    if (lon1 != constant)XCTFail(@"JSON was not properly parsed");
    
    
}



- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
