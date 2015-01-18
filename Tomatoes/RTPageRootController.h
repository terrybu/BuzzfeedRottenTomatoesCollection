//
//  RTPageRootController.h
//  Tomatoes
//
//  Created by Terry Bu on 1/17/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoritesManager.h"

@interface RTPageRootController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>


@property (nonatomic, strong) FavoritesManager *favManager;
@property (nonatomic, strong) UIPageControl *pageControl;


@end
