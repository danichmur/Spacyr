//
//  MapViewController.m
//  Spacyr
//
//  Created by Elena on 03.06.17.
//  Copyright © 2017 Daniel Muraveyko. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

CLLocationManager *locationManager;

- (void)viewDidLoad {
    locationManager = [[CLLocationManager alloc] init];
    [super viewDidLoad];
    float lat = 53.852417, lon = 27.472478;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat
                                                            longitude:lon
                                                                 zoom:15];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.view = mapView;
    
    NSDictionary *d = [self listOfEventsNearLatitude:lat longitude:lon distance:10.0];
    
    for (int i = 0; i < d.count; i++)
    {
        NSNumber *latD = [d valueForKey:@"latitude"][i];
        float ld = [latD floatValue];
        NSNumber *lonD = [d valueForKey:@"longitude"][i];
        float lg = [lonD floatValue];
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(ld, lg);
        marker.title = @"Sydney";
        marker.snippet = @"Australia";
        marker.map = mapView;
    }
}

-(NSDictionary*) listOfEventsNearLatitude:(float)lat longitude:(float)lon distance:(float)dist{
    NSString *s = [NSString stringWithFormat:@"http://localhost:3000/events/search.json?longitude=%f&latitude=%f&dist=%f", lon, lat, dist];
    NSURL *url = [[NSURL alloc] initWithString:s];
    NSData *contents = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *events = [NSJSONSerialization JSONObjectWithData:contents options:NSJSONReadingMutableContainers error:nil];
    return events;
}

- (void)getCurrentLocatiion{
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager requestWhenInUseAuthorization];
    NSLog(@"Meow");
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to Get Your Location" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [errorAlert addAction:defaultAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
 /*       NSString *s = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&units=metric&APPID=02a8f8d24cadb133ebdb19e924e0f02e",
                       currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
        NSURL *url = [[NSURL alloc] initWithString:s];
        NSData *contents = [[NSData alloc] initWithContentsOfURL:url];
        if (contents == nil)
        {
            [[self cityLabel] setText:@"Can't find such city"];
        }
        else {
            NSDictionary *forcasting = [NSJSONSerialization JSONObjectWithData:contents options:NSJSONReadingMutableContainers error:nil];
            [[self cityLabel] setText:forcasting[@"name"]];
            [self setTemperature:[forcasting[@"main"][@"temp"] doubleValue]];
        }*/
        
    }
    [locationManager stopUpdatingLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
