//
//  CollectionCell.h
//  Spacyr
//
//  Created by Elena on 03.06.17.
//  Copyright © 2017 Daniel Muraveyko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleV;
@property (weak, nonatomic) IBOutlet UILabel *descriptionV;

@end
