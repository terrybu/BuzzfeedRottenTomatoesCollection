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

@end
