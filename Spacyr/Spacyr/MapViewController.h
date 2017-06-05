//
//  MapViewController.h
//  Spacyr
//
//  Created by Elena on 03.06.17.
//  Copyright © 2017 Daniel Muraveyko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "_TtC6Spacyr16CustomInfoWindow.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate, GMSMapViewDelegate>

@end
