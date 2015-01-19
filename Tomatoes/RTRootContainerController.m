//
//  RTPageRootController.m
//  Tomatoes
//
//  Created by Terry Bu on 1/17/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.
//

#import "RTRootContainerController.h"
#import "RTSearchViewController.h"
#import "RTFavCollectionViewController.h"

@interface RTRootContainerController ()

@property (nonatomic, strong) NSArray *viewControllers;

@end

@implementation RTRootContainerController

- (FavoritesManager *) favManager {
    if (!_favManager) {
        _favManager = [[FavoritesManager alloc]init];
    }
    return _favManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //Initial Setup
    UINavigationController *first = [self.storyboard instantiateViewControllerWithIdentifier:@"firstNav"];
    UINavigationController *second = [self.storyboard instantiateViewControllerWithIdentifier:@"secondNav"];
    RTSearchViewController *search = (RTSearchViewController *) first.topViewController;
    RTFavCollectionViewController *fav = (RTFavCollectionViewController *) second.topViewController;
    search.favManager = fav.favManager = self.favManager;
    search.rootVC = self;
    self.firstVC = first;
    self.secondVC = second;
    
    //Page View Controller Setup
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    self.viewControllers = @[self.firstVC];
    [self.pageViewController setViewControllers:self.viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}


//this particular viewWillLayoutSubviews is needed to remove small bug using pageviewcontrollers where there's a weird scrollview inset that doesn't go away when orientation changes
- (void)viewWillLayoutSubviews
{
    if (self.pageViewController.viewControllers[0] == self.firstVC) {
        [self.pageViewController setViewControllers:@[self.firstVC]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:false
                      completion:nil];
    }
    else if (self.pageViewController.viewControllers[0] == self.secondVC) {
        [self.pageViewController setViewControllers:@[self.secondVC]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:false
                                         completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) favStarWasPressed {
    [self.pageViewController setViewControllers:@[self.secondVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
}
- (void) searchBarButtonWasPressed {
    [self.pageViewController setViewControllers:@[self.firstVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

#pragma mark - Page View Controller Data Source
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (self.pageViewController.viewControllers[0] == self.secondVC) {
        return self.firstVC;
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (self.pageViewController.viewControllers[0] == self.firstVC) {
        return self.secondVC;
    }
    return nil;
}


#pragma mark - Page Control delegate methods
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
   return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}



@end
