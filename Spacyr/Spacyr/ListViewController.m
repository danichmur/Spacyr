//
//  ListViewController.m
//  Spacyr
//
//  Created by Elena on 03.06.17.
//  Copyright © 2017 Daniel Muraveyko. All rights reserved.
//

#import "ListViewController.h"
#import "CollectionCell.h"

@interface ListViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ListViewController

NSDictionary *events;

- (void)viewDidLoad {
    events = [self listOfEvents];
    [super viewDidLoad];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;	
}

-(NSDictionary*) listOfEvents{
    float lat = 53.905959, lon = 27.554035;
    float dist = 50;
    NSString *s = [NSString stringWithFormat:@"http://localhost:3000/events/search.json?longitude=%f&latitude=%f&dist=%f", lon, lat, dist];
    NSURL *url = [[NSURL alloc] initWithString:s];
    NSData *contents = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *events = [NSJSONSerialization JSONObjectWithData:contents options:NSJSONReadingMutableContainers error:nil];
    return events;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return events.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell"forIndexPath:indexPath];
    cell.titleV.text = [events valueForKey: @"name"][indexPath.row];
    cell.descriptionV.text = @"";
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [events valueForKey:@"image_url"][indexPath.row]]];
    cell.imageV.image = [UIImage imageWithData: imageData];
    //cell.imageV!.image = UIImage(named: item.value(forKey: "image") as! String)
    //cell.titleLabel!.text = item.value(forKey:"title") as? String
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
