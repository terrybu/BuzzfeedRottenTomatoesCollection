//
//  FavoritesManager.m
//  Tomatoes
//
//  Created by Terry Bu on 1/16/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.
//

#import "FavoritesManager.h"

@implementation FavoritesManager

- (NSMutableOrderedSet *) favorites {

    if (!_favorites) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"favorites"]) {
            NSData *data = [defaults dataForKey:@"favorites"];
            _favorites = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        else {
            _favorites = [[NSMutableOrderedSet alloc]init];
        }
    }
    
    return _favorites;
}

- (void) saveToFavorites: (RTMovie *) movie {
    [self.favorites addObject:movie];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.favorites];
    [defaults setObject:data forKey:@"favorites"];
    [defaults synchronize];

}



@end
