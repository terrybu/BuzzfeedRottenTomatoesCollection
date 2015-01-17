//
//  RTCast.h
//  Tomatoes
//
//  Created by Terry Bu on 1/17/15.
//  Copyright (c) 2015 Matt Greenwell. All rights reserved.
//

@interface RTCast : NSObject

@property (nonatomic, strong) NSMutableArray *names;

+ (NSArray *)castFromCastJSON:(NSDictionary *)json;

@end
