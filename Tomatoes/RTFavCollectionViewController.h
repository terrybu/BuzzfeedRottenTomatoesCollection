//
//  RTFavCollectionViewController.h
//  Tomatoes
//
//  Created by Aditya Narayan on 1/17/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoritesManager.h"
#import "RTRottenTomatoesClient.h"

@interface RTFavCollectionViewController : UICollectionViewController

@property (nonatomic, strong) FavoritesManager *favManager;
@property (strong, nonatomic) RTRottenTomatoesClient *client;

@end
