//
//  MovieAPIManager.h
//  Test
//
//  Created by Jessica Shu on 7/17/18.
//  Copyright © 2018 Jessica Shu. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface MovieAPIManager : NSObject
@property (nonatomic, strong) NSURLSession *session;

-(id) init;

-(void) fetchNowPlaying:(void(^)(NSArray *recipes, NSError *error))completion;

@end
