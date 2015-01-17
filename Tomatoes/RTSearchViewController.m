//
//  RTViewController.m
//  Tomatoes
//
//  Created by Matt Greenwell on 1/3/14.
//  Copyright (c) 2014 Matt Greenwell. All rights reserved.
//

#import "RTSearchViewController.h"
#import "RTRottenTomatoesClient.h"
#import "RTCollectionViewCell.h"
#import "RTMovie.h"
#import <UIImageView+AFNetworking.h>
#import "RTMovieDetailViewController.h"

@interface RTSearchViewController ()

@property (nonatomic, strong) NSArray *movies;
@property (strong, nonatomic) RTRottenTomatoesClient *client;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;

@end

@implementation RTSearchViewController

- (RTRottenTomatoesClient *) client {
    if (_client == nil)
        _client = [RTRottenTomatoesClient sharedInstance];
    
    return _client;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark Search-Bar related methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSString *queryString = searchBar.text;
    [self.client searchMoviesWithQuery:queryString success:^(NSArray *movies) {
        self.movies = movies;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }
       failure:^(NSError *error) {
           NSLog(@"ERROR: %@", error);
       }];
}



#pragma mark Collection view delegate methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (RTCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    RTMovie *movie = [self.movies objectAtIndex:indexPath.row];
    
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:movie.thumbnailURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    [cell.imageView setImageWithURLRequest:imageRequest placeholderImage:nil success:nil failure:nil];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        RTMovieDetailViewController *destViewController = (RTMovieDetailViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        destViewController.movie = [self.movies objectAtIndex:indexPath.row];
    }
}




- (IBAction)refreshCollection:(id)sender {
    self.movies = [[NSArray alloc]init];
    [self.collectionView reloadData];
}


@end
