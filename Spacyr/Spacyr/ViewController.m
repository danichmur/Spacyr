//
//  ViewController.m
//  Spacyr
//
//  Created by Daniel Muraveyko on 26/05/2017.
//  Copyright © 2017 Daniel Muraveyko. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)btPressed:(id)sender {
    [self performSegueWithIdentifier:@"ShowMap" sender:self];
}
- (IBAction)secondBtPressed:(id)sender {
    [self performSegueWithIdentifier:@"ShowEvents" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
