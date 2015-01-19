//
//  RTViewController.h
//  Tomatoes
//
//  Created by Matt Greenwell on 1/3/14.
//  Copyright (c) 2014 Matt Greenwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoritesManager.h"
#import "RTRootContainerController.h"

@interface RTSearchViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) FavoritesManager *favManager;
@property int pageIndex;

- (IBAction)refreshCollection:(id)sender;
- (IBAction)favStarPressed:(id)sender;

@end
