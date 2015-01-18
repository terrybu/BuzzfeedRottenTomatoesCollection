//
//  RTFavCollectionViewController.h
//  Tomatoes
//
//  Created by Terry Bu on 1/17/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoritesManager.h"
#import "RTPageRootController.h"

@interface RTFavCollectionViewController : UICollectionViewController

@property (nonatomic, strong) FavoritesManager *favManager;
@property (nonatomic, weak) RTPageRootController *rootVC;

- (IBAction)searchButtonPressed:(id)sender;

@end
