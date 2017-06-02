//
//  ViewController.m
//  Spacyr
//
//  Created by Daniel Muraveyko on 26/05/2017.
//  Copyright © 2017 Daniel Muraveyko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *kind;
@property (strong, nonatomic) IBOutlet UITextView *desr;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *d = [self listOfEvents];
   // NSLog(@"%@", d);
//    int i = [[d valueForKey: @"image_url"][0] intValue];
//    NSLog(@"%d", i);
//    
//    NSLog(@"%@", [d valueForKey: @"image_url"][0]);
//    NSLog(@"%@", [d valueForKey: @"name"][0]);
//    NSLog(@"%@", [d valueForKey: @"description"][0]);
//    NSLog(@"%@", [d valueForKey: @"kind"][0]);
    
    _name.text = [d valueForKey: @"name"][0];
    _desr.text = [d valueForKey:@"description"][0];
    _kind.text = [d valueForKey:@"kind"][0];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [d valueForKey:@"image_url"][0]]];
    _image.image = [UIImage imageWithData: imageData];
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
    float longitude = 2.0, latitude = 2.0;
    NSString *s = [NSString stringWithFormat:@"http://localhost:3000/events/search.json?longitude=%f&latitude=%f", longitude, latitude];
    NSURL *url = [[NSURL alloc] initWithString:s];
    NSData *contents = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *events = [NSJSONSerialization JSONObjectWithData:contents options:NSJSONReadingMutableContainers error:nil];
    return events;
}

@end
