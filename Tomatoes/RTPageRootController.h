//
//  RTPageRootController.h
//  Tomatoes
//
//  Created by Aditya Narayan on 1/17/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTPageRootController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UINavigationController *firstVC;
@property (strong, nonatomic) UINavigationController *secondVC;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
