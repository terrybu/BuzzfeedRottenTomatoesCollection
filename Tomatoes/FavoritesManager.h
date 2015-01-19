//
//  FavoritesManager.h
//  Tomatoes
//
//  Created by Terry Bu on 1/16/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTMovie.h"

@interface FavoritesManager : NSObject

@property (nonatomic, strong) NSMutableOrderedSet *favorites;

- (void) saveToFavorites: (RTMovie *) movie;

@end
