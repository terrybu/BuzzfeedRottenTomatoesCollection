//
//  RTMovieDetailViewController.m
//  Tomatoes
//
//  Created by Matt Greenwell on 1/5/14.
//  Copyright (c) 2014 Matt Greenwell. All rights reserved.
//

#import "RTMovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "RTFavCollectionViewController.h"

@interface RTMovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

@end

@implementation RTMovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.movie != nil) {
        [self configureViewWithMovie:self.movie];
    }
    
    if (![self.navigationController.viewControllers[1] isKindOfClass:[RTFavCollectionViewController class]]) {
        UIBarButtonItem *favoriteSaveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                            target:self
                                                                                            action:@selector(addTapped)];
        self.navigationItem.rightBarButtonItem = favoriteSaveButton;
    }

}

- (void)setMovie:(RTMovie *)movie {
    _movie = movie;
    [self configureViewWithMovie:movie];
}

- (void)configureViewWithMovie:(RTMovie *)movie {
    self.titleLabel.text = [NSString stringWithFormat:@"%@ (%@)",movie.title,movie.year];
    self.releaseDateLabel.text = [self releaseDateDisplayStringWithReleaseDates:movie.releaseDates];
    self.ratingLabel.text = [self ratingDisplayStringWithRating:movie.criticScore];
    self.castLabel.text = [self castDisplayStringFromCast:movie.cast];
    [self.posterImageView setImageWithURL:movie.thumbnailURL];
}

- (void)addTapped {
    // @TODO: Add to Favorites!
    [self.favManager.favorites addObject:self.movie];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.favManager.favorites];
    [defaults setObject:data forKey:@"favorites"];
    [defaults synchronize];

    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Helpers

- (NSString *)releaseDateDisplayStringWithReleaseDates:(NSArray *)releaseDates {
    NSMutableString *dateString = [NSMutableString string];
    
    for (NSString *releaseDate in releaseDates) {
        [dateString appendFormat:@"%@\n",releaseDate];
    }
    
    NSString *localizedFormat = NSLocalizedString(@"Movie_Detail_Cast_Format", @"");
    NSString *displayString = [NSString stringWithFormat:localizedFormat,dateString];
    
    return displayString;
}

- (NSString *)ratingDisplayStringWithRating:(NSInteger)rating {
    NSString *localizedFormat = NSLocalizedString(@"Movie_Detail_Rating_Format", @"");
    NSString *displayString = [NSString stringWithFormat:localizedFormat,rating];
    
    return displayString;
}

- (NSString *)castDisplayStringFromCast:(NSArray *)cast {
    NSMutableString *castList = [NSMutableString string];
    
    for (NSString *castMember in cast) {
        [castList appendFormat:@"%@\n",castMember];
    }
    
    NSString *localizedFormat = NSLocalizedString(@"Movie_Detail_Cast_Format", @"");
    NSString *displayString = [NSString stringWithFormat:localizedFormat,castList];
    
    return displayString;
}

@end
