//
//  RTPageRootController.m
//  Tomatoes
//
//  Created by Terry Bu on 1/17/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.


//Main problem was that i forgot to remove observer for the notifications

//Another Ryan and Matt's problem with this was that I used Notifications for navbar items instead of doing nav-bar actions right on the view controllers. It may have been better if i used "compound classes"




#import "RTRootContainerController.h"
#import "RTSearchViewController.h"
#import "RTFavCollectionViewController.h"

@interface RTRootContainerController () {
    int pageIndicatorFlag;
}

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UINavigationController *firstVC;
@property (nonatomic, strong) UINavigationController *secondVC;
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
    
    [self initializePageViewControllerSetUp];
    
    RTSearchViewController *search = (RTSearchViewController *) self.firstVC.topViewController;
    RTFavCollectionViewController *fav = (RTFavCollectionViewController *) self.secondVC.topViewController;
    search.favManager = fav.favManager = self.favManager;
    
    //Registering for notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(favStarWasPressed) name:@"favStarPressed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchBarButtonWasPressed)     name:@"searchButtonPressed" object:nil];
}

- (void) viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"favStarPressed" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"searchButtonPressed" object:nil];
}


- (void) initializePageViewControllerSetUp {
    UINavigationController *first = [self.storyboard instantiateViewControllerWithIdentifier:@"firstNav"];
    UINavigationController *second = [self.storyboard instantiateViewControllerWithIdentifier:@"secondNav"];

    self.firstVC = first;
    self.secondVC = second;
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    self.viewControllers = @[self.firstVC];
    [self.pageViewController setViewControllers:self.viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.pageViewController willMoveToParentViewController:self];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

    //this variable is used to keep page control indicator consistent when using bar buttons to navigate instead of scrolling side to side
    pageIndicatorFlag = 0;
}


#pragma mark - Notifications Related
- (void)addUniqueObserver:(id)observer selector:(SEL)selector name:(NSString *)name object:(id)object {
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:name object:object];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:object];
}

- (void) favStarWasPressed {
    pageIndicatorFlag = 1;
    [self.pageViewController setViewControllers:@[self.secondVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}
- (void) searchBarButtonWasPressed {
    pageIndicatorFlag = 0;
    [self.pageViewController setViewControllers:@[self.firstVC] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}




#pragma mark - PageViewController Related
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


#pragma mark - Page Control methods
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
   return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{   if (pageIndicatorFlag == 0 || !pageIndicatorFlag)
        return 0;
    else if (pageIndicatorFlag == 1)
        return 1;
    
    return 0;
}

//this particular viewWillLayoutSubviews is needed to remove small bug using pageviewcontrollers where there's a weird scrollview inset that doesn't go away when orientation changes
- (void)viewWillLayoutSubviews
{
    void (^pvcSetViewControllers)(UINavigationController *vc) = ^(UINavigationController *vc) {
        [self.pageViewController setViewControllers:@[vc]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:NO
                                         completion:nil];
    };
    
    if (self.pageViewController.viewControllers[0] == self.firstVC)
        pvcSetViewControllers(self.firstVC);
    else if (self.pageViewController.viewControllers[0] == self.secondVC)
        pvcSetViewControllers(self.secondVC);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"favStarPressed" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"searchButtonPressed" object:nil];
}

@end
