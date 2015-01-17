//
//  RTCast.m
//  Tomatoes
//
//  Created by Aditya Narayan on 1/17/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.
//

#import "RTCast.h"

NSString * const kCastKey = @"abridged_cast";
NSString * const kCastNameKey = @"name";

@implementation RTCast

+ (NSArray *)castFromCastJSON:(NSDictionary *)json {
    //@TODO: Move this into cast objects.
    
    NSArray *castMembersArrayJSON = json[kCastKey];
    
    RTCast *cast = [[RTCast alloc]init];
    if (castMembersArrayJSON != nil) {
        cast.names = [NSMutableArray arrayWithCapacity:[castMembersArrayJSON count]];
        for (NSDictionary *castMember in castMembersArrayJSON) {
            NSString *castName = castMember[kCastNameKey];
            [cast.names addObject:castName];
        }
    }
    return cast.names;
}

@end
