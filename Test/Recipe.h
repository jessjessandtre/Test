//
//  Recipe.h
//  Test
//
//  Created by Jessica Shu on 7/18/18.
//  Copyright © 2018 Jessica Shu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Recipe : PFObject <PFSubclassing>
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) PFFile* image;
@property (nonatomic, strong) NSArray* ingredients;
@property (nonatomic, strong) NSString* instructions;
@property (nonatomic, strong) NSNumber *numPosts;
@property (nonatomic, strong) NSString *recipeLink;

@end
