//
//  RTFavCollectionViewController.m
//  Tomatoes
//
//  Created by Terry Bu on 1/17/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.
//

#import "RTFavCollectionViewController.h"
#import "RTSearchCollectionViewCell.h"
#import "RTMovie.h"
#import <UIImageView+AFNetworking.h>
#import "RTFavCollectionViewCell.h"
#import "RTMovieDetailViewController.h"

@interface RTFavCollectionViewController ()

@end

@implementation RTFavCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RTMovieDetailViewController *movieDetailVC = (RTMovieDetailViewController *)segue.destinationViewController;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    movieDetailVC.movie = [self.favManager.favorites objectAtIndex:indexPath.row];
    movieDetailVC.favManager = self.favManager;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.favManager.favorites.count;
}

- (RTFavCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RTFavCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FavCell" forIndexPath:indexPath];
    
    RTMovie *movie = [self.favManager.favorites objectAtIndex:indexPath.row];
    
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:movie.thumbnailURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    [cell.imageView setImageWithURLRequest:imageRequest placeholderImage:nil success:nil failure:nil];

    
    return cell;
}


@end
