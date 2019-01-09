//
//  ViewController.m
//  AndrewSmithLKCodeChallenge
//
//  Created by Andrew on 1/5/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(nonatomic) MKFeatureDisplayPriority displayPriority;

@end
NSString *base64String;
NSString *decodedString;
NSData *decodedData;

double lat1;
double lat2;
double lat3;
double lat4;
double lat5;

double lon1;
double lon2;
double lon3;
double lon4;
double lon5;

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self decodePayload];
    [self defineCoordinates];
    [self makeRegionAndAnnotation];
}

-(void)decodePayload {
    base64String = @"ewogICJjb29yZGluYXRlcyI6IFsKICAgIHsKICAgICAgImxhdCI6IDM2LjEyMDYyNCwKICAgICAgImxvbiI6IC0xMTUuMTU3NDg2CiAgICB9LAogICAgewogICAgICAibGF0IjogMzYuMTIxMDE4LAogICAgICAibG9uIjogLTExNS4xNTc0ODQKICAgIH0sCiAgICB7CiAgICAgICJsYXQiOiAzNi4xMjEwMDksCiAgICAgICJsb24iOiAtMTE1LjE1NjAxMgogICAgfSwKICAgIHsKICAgICAgImxhdCI6IDM2LjEyMDUyOCwKICAgICAgImxvbiI6IC0xMTUuMTU2MDIzCiAgICB9LAogICAgewogICAgICAibGF0IjogMzYuMTIwNTI4LAogICAgICAibG9uIjogLTExNS4xNTY5MDgKICAgIH0KICBdCn0=";
    
    decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    NSLog(decodedString);
    NSLog(@"Payload decoded");
    
}

-(void)defineCoordinates {
    //This function turns the decoded string into an NSData value which is then serialized as JSON. Each lat and lon value is retrieved from the JSON value and set as a double. Those doubles are then set in pairs as 5 CLLocationCoordinate2d values (lat and lon in one). Then THOSE values are used to designate the points of the polygon, and finally added as the overlay to the map view. I chose to do it this way because all this data works together immediately so there seems to be no reason to separate its compoents. I could be wrong though.
    
    NSData *data = [decodedString dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    lat1 = [[[json valueForKey:@"coordinates"][0] valueForKey:@"lat"] doubleValue];
    lat2 = [[[json valueForKey:@"coordinates"][1] valueForKey:@"lat"] doubleValue];
    lat3 = [[[json valueForKey:@"coordinates"][2] valueForKey:@"lat"] doubleValue];
    lat4 = [[[json valueForKey:@"coordinates"][3] valueForKey:@"lat"] doubleValue];
    lat5 = [[[json valueForKey:@"coordinates"][4] valueForKey:@"lat"] doubleValue];
    
    lon1 = [[[json valueForKey:@"coordinates"][0] valueForKey:@"lon"] doubleValue];
    lon2 = [[[json valueForKey:@"coordinates"][1] valueForKey:@"lon"] doubleValue];
    lon3 = [[[json valueForKey:@"coordinates"][2] valueForKey:@"lon"] doubleValue];
    lon4 = [[[json valueForKey:@"coordinates"][3] valueForKey:@"lon"] doubleValue];
    lon5 = [[[json valueForKey:@"coordinates"][4] valueForKey:@"lon"] doubleValue];
    
    CLLocationCoordinate2D libComPark[5];
    libComPark[0] = CLLocationCoordinate2DMake(lat1, lon1);
    libComPark[1] = CLLocationCoordinate2DMake(lat2, lon2);
    libComPark[2] = CLLocationCoordinate2DMake(lat3, lon3);
    libComPark[3] = CLLocationCoordinate2DMake(lat4, lon4);
    libComPark[4] = CLLocationCoordinate2DMake(lat5, lon5);
    
    MKPolygon *polLibcomPark = [MKPolygon polygonWithCoordinates:libComPark count:5];
    [self.mapView addOverlay:polLibcomPark];
    
    NSLog(@"Ploygon on map view");
    
}

-(void)makeRegionAndAnnotation {
   
    //Make the coordinate for the annotation
    CLLocationCoordinate2D centerPolygon;
    centerPolygon.latitude = 36.120786;
    centerPolygon.longitude = -115.156709;
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = centerPolygon;
    NSLog(@"Annotation Coordinate: set");
    

   //Add it to the view
    /*Note about annotations: I noticed the annotation comes up EVERY time on a physical device
     and not upon initial launch for simulators every time. So if you run it on a simulator and the annotation
     does not show, run it again it should show up */
    [self.mapView addAnnotation:point];
    NSLog(@"Map view Annotation: set");

    //Create the region
    MKCoordinateRegion region;
    NSLog(@"Region: set");

    //Center
    CLLocationCoordinate2D center;
    center.latitude = centerPolygon.latitude;
    center.longitude = centerPolygon.longitude;
    NSLog(@"Center lat: set");
    NSLog(@"Center lon: set");

    
    
    //Span
    /* Noticed if I leave the span at .002 on iPhone 5SE it cuts the polygon off & .002 felt too close for iPads.
     So I set it further back specifically for iPhone 5SE and zoomed in for iPads*/
    MKCoordinateSpan span;
    
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        
        switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                
            case 1136:
                span.latitudeDelta = .003;
                span.longitudeDelta = .003;
                NSLog(@"Span iPhone5SE: .003");
                break;
                
            default:
                span.latitudeDelta = .002;
                span.longitudeDelta = .002;
                NSLog(@"Default Span: .002");

        }
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        span.latitudeDelta = .001;
        span.longitudeDelta = .001;
        NSLog(@"iPad pro span: .01");
      
        

    }

    
    //Set regions center and span
    region.center = center;
    region.span = span;
    NSLog(@"Regins span: set");
    
    //Set the mapViews region
    [_mapView setRegion:region animated:YES];
    NSLog(@"Map view region: set");
    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
   
    
    if ([overlay isKindOfClass:[MKPolygon class]])
    {
        
        MKPolygonView* polygon = [[MKPolygonView alloc]initWithPolygon:(MKPolygon*)overlay];
        polygon.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.75];
        polygon.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:1.0];
        polygon.lineWidth = 1;
        printf("Polygon visual attributes added");
        return polygon;
    }
    return nil;
}


@end
