//
//  RTViewController.h
//  Tomatoes
//
//  Created by Matt Greenwell on 1/3/14.
//  Copyright (c) 2014 Matt Greenwell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTSearchViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>


@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;

@end
