//
//  RTPageRootController.m
//  Tomatoes
//
//  Created by Terry Bu on 1/17/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.
//

#import "RTPageRootController.h"
#import "RTSearchViewController.h"
#import "RTFavCollectionViewController.h"

@interface RTPageRootController ()

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UINavigationController *firstVC;
@property (nonatomic, strong) UINavigationController *secondVC;
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
    self.pageViewController.backgroundColor = [UIColor blackColor];

    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    self.viewControllers = @[self.firstVC];
    [self.pageViewController setViewControllers:self.viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    //For Page Control
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-15, self.view.frame.size.height-30, 30, 30)];
    self.pageControl.backgroundColor = [UIColor clearColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.pageControl setNumberOfPages:2];
    [self.view addSubview:self.pageControl];
    
    //Registering for notifications
    [self addUniqueObserver:self selector:@selector(favStarWasPressed) name:@"favStarPressed" object:nil];
    [self addUniqueObserver:self selector:@selector(searchBarButtonWasPressed) name:@"searchBarButtonPressed" object:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Notifications Related
- (void)addUniqueObserver:(id)observer selector:(SEL)selector name:(NSString *)name object:(id)object {
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:name object:object];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:object];
}

- (void) favStarWasPressed {
    [self.pageViewController setViewControllers:@[self.secondVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self.pageControl setCurrentPage:1];
}
- (void) searchBarButtonWasPressed {
    [self.pageViewController setViewControllers:@[self.firstVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    [self.pageControl setCurrentPage:0];
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

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UINavigationController *currentNavController = pageViewController.viewControllers[0];
    UIViewController *topVC = currentNavController.topViewController;
    
    if ([topVC isKindOfClass:[RTFavCollectionViewController class]])
        [self.pageControl setCurrentPage:1];
    else if ([topVC isKindOfClass:[RTSearchViewController class]])
        [self.pageControl setCurrentPage:0];
    
}

#pragma mark - Page Control delegate methods
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
   return 2;
}

(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


@end
