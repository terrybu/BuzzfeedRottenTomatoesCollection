//
//  FavoritesManager.m
//  Tomatoes
//
//  Created by Aditya Narayan on 1/16/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.
//

#import "FavoritesManager.h"

@implementation FavoritesManager

- (NSMutableOrderedSet *) favorites {
    if (!_favorites)
        _favorites = [[NSMutableOrderedSet alloc]init];
    return _favorites;
}

@end
