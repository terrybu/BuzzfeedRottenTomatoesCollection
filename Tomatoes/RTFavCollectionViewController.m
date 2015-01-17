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
#import "RTFavCollectionViewCell.h"
#import "RTMovieDetailViewController.h"
#import <UIImageView+AFNetworking.h>

@interface RTFavCollectionViewController ()

@end

@implementation RTFavCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.favManager.favorites.count;
}

- (RTFavCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RTFavCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    RTMovie *movie = [self.favManager.favorites objectAtIndex:indexPath.row];
    
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:movie.thumbnailURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    [cell.imageView setImageWithURLRequest:imageRequest placeholderImage:nil success:nil failure:nil];

    return cell;
}


@end
