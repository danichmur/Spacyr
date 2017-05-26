//
//  ViewController.m
//  Spacyr
//
//  Created by Daniel Muraveyko on 26/05/2017.
//  Copyright © 2017 Daniel Muraveyko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@", [self listOfEvents]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSDictionary*) listOfEvents{
    return [self eventsFromServer];
}

-(NSDictionary*) localEvents{
    return nil;
}

-(NSDictionary*) eventsFromServer{
    NSString *s = [NSString stringWithFormat:@"http://localhost:3000/events.json"];
    NSURL *url = [[NSURL alloc] initWithString:s];
    NSData *contents = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *events = [NSJSONSerialization JSONObjectWithData:contents options:NSJSONReadingMutableContainers error:nil];
    return events;
}

@end
