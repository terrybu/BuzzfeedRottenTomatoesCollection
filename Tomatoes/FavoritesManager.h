//
//  FavoritesManager.h
//  Tomatoes
//
//  Created by Aditya Narayan on 1/16/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoritesManager : NSObject

@property (nonatomic, strong) NSMutableOrderedSet *favorites;

@end
