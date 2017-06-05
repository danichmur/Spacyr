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
    mapView.delegate = self;
    
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


- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    _TtC6Spacyr16CustomInfoWindow *infoWindow =  [[[NSBundle mainBundle] loadNibNamed:@"InfoWindow"
            owner:self options:nil] objectAtIndex:0];
    return infoWindow;
}

//InfoWindow *myClassInstance = [MapViewController loadNibNamed:@"InfoWindow"
//                                         ofClass:[InfoWindow class]];
//InfoWindow *v = [[InfoWindow alloc] init];
//view.titleV.text = @"Place Name";
//view.descriptionV.text = @"Place description";
//NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: @"http://res.cloudinary.com/dwnv5pfk5/image/upload/v1496470507/Minsk__10th_city_hospital_og63am.jpg"]];
//view.imageV.image = [UIImage imageWithData: imageData];
// return view;
//InfoWindow* u = [[InfoWindow alloc] init];
//CLLocationCoordinate2D position = CLLocationCoordinate2DMake(51.5, -0.127);
//  GMSMarker *london = [GMSMarker markerWithPosition:position];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    InfoWin *controller = [storyboard instantiateViewControllerWithIdentifier:@"InfoWindow"];
//    [[self navigationController] pushViewController:controller animated:YES];
//    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: @"http://res.cloudinary.com/dwnv5pfk5/image/upload/v1496470507/Minsk__10th_city_hospital_og63am.jpg"]];
//    controller.eventImage.image = [UIImage imageWithData: imageData];
//    controller.eventDescription.text = @"sdgrgrg";
//    controller.title = @"smdlfjrs";

//+ (id)loadNibNamed:(NSString *)nibName ofClass:(Class)objClass {
//    if (nibName && objClass) {
//        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:nibName
//                                                         owner:nil
//                                                       options:nil];
//        for (id currentObject in objects ){
//            if ([currentObject isKindOfClass:objClass])
//                return currentObject;
//        }
//    }
//    
//    return nil;
//}



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
