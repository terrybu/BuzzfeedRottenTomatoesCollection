//
//  RTMovieDetailViewController.h
//  Tomatoes
//
//  Created by Matt Greenwell on 1/5/14.
//  Copyright (c) 2014 Matt Greenwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTMovie.h"
#import "FavoritesManager.h"

@interface RTMovieDetailViewController : UIViewController

@property (nonatomic, strong) RTMovie *movie;
@property (nonatomic, strong) FavoritesManager *favManager;


@end
