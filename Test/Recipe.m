//
//  Recipe.m
//  Test
//
//  Created by Jessica Shu on 7/18/18.
//  Copyright © 2018 Jessica Shu. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

@dynamic name, image, ingredients, instructions, numPosts, sourceURL;

+ (nonnull NSString *)parseClassName {
    return @"Recipe";
}

@end
