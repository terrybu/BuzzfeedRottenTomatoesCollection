//
//  RTViewController.h
//  Tomatoes
//
//  Created by Matt Greenwell on 1/3/14.
//  Copyright (c) 2014 Matt Greenwell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTSearchViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
//make sure UISearchDisplay, etc protocols


@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


@end
