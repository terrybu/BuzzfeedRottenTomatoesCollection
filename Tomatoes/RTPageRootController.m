//
//  RTPageRootController.m
//  Tomatoes
//
//  Created by Aditya Narayan on 1/17/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.
//

#import "RTPageRootController.h"
#import "RTSearchViewController.h"
#import "RTFavCollectionViewController.h"

@interface RTPageRootController ()

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (strong, nonatomic) UINavigationController *firstVC;
@property (strong, nonatomic) UINavigationController *secondVC;

@end

@implementation RTPageRootController

- (FavoritesManager *) favManager {
    if (!_favManager) {
        _favManager = [[FavoritesManager alloc]init];
    }
    return _favManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationController *first = [self.storyboard instantiateViewControllerWithIdentifier:@"firstNav"];
    UINavigationController *second = [self.storyboard instantiateViewControllerWithIdentifier:@"secondNav"];

    RTSearchViewController *search = (RTSearchViewController *) first.topViewController;
    RTFavCollectionViewController *fav = (RTFavCollectionViewController *) second.topViewController;
    search.favManager = fav.favManager = self.favManager;
    search.rootVC = self;

    self.firstVC = first;
    self.secondVC = second;
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    self.viewControllers = @[self.firstVC];
    [self.pageViewController setViewControllers:self.viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    [self addUniqueObserver:self selector:@selector(favStarPressed) name:@"favStarPressed" object:nil];


}

- (void) favStarPressed {
    [self.pageViewController setViewControllers:@[self.secondVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addUniqueObserver:(id)observer selector:(SEL)selector name:(NSString *)name object:(id)object {
    
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:name object:object];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:object];
    
}

#pragma mark - Page View Controller Data Source
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (self.pageViewController.viewControllers[0] == self.secondVC)
        return self.firstVC;
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (self.pageViewController.viewControllers[0] == self.firstVC)
        return self.secondVC;
    return nil;
}


@end
