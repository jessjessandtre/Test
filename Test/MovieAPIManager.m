//
//  MovieAPIManager.m
//  Test
//
//  Created by Jessica Shu on 7/17/18.
//  Copyright © 2018 Jessica Shu. All rights reserved.
//


//
//  MovieAPIManager.m
//  Flix
//
//  Created by Jessica Shu on 7/2/18.
//  Copyright © 2018 Jessica Shu. All rights reserved.
//

#import "MovieAPIManager.h"
#import <UNIRest.h>
#import "Recipe.h"
#import <UIKit/UIKit.h>


@implementation MovieAPIManager

- (id)init {
    self = [super init];
    self.session =[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    return self;
}

-(void)fetchNowPlaying:(void(^)(NSArray *recipes, NSError *error))completion {
/*    NSURL *url = [NSURL URLWithString:@"https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?X-Mashape-Key=bDFDdHh6CemshpkK2tehTFhkbAihp1Av2PujsnlUl5k1oLKFvn"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            
            completion(nil, error);
            NSLog(@"error");
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            //self.movies = dataDictionary[@"results"];
            //for (NSDictionary *movie in self.movies){
            //    NSLog(@"%@", movie[@"title"]);
            //}
            completion(dataDictionary, nil);
        }
    }];
    [task resume];
*/
    NSDictionary *headers = @{@"X-Mashape-Key": @"bDFDdHh6CemshpkK2tehTFhkbAihp1Av2PujsnlUl5k1oLKFvn", @"Accept": @"application/json"};
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:@"https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=1"];
        [request setHeaders:headers];
        completion(nil, nil);
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSInteger code = response.code;
        NSDictionary *responseHeaders = response.headers;
        UNIJsonNode *body = response.body;
        NSData *rawBody = response.rawBody;
        
      //  NSLog(@"%@", body.object[@"recipes"]);
        
      //  NSLog(@"%@", [body.object[@"recipes"][0] class]);
/*
        NSLog(@"%@", body.object[@"recipes"][0][@"title"]);
       NSLog(@"%@", body.object[@"recipes"][0][@"image"]);
        NSLog(@"%@", body.object[@"recipes"][0][@"instructions"]);
        for (NSDictionary* d in body.object[@"recipes"][0][@"extendedIngredients"]){
            NSLog(@"%@", d[@"original"]);
        }
 
 
*/
        for (NSDictionary* r in body.object[@"recipes"]){
            Recipe* recipe = [Recipe new];
            recipe.name = r[@"title"];
            NSMutableArray* ma = [[NSMutableArray alloc] init];
            for (NSDictionary* ingredient in r[@"extendedIngredients"] ){
                [ma addObject:ingredient[@"original"]];
            }
            recipe.ingredients = [ma copy];
            recipe.instructions = r[@"instructions"];
            recipe.numPosts = @0;
            NSLog(@"recipe created");
            
            NSURL *imageURL = [NSURL URLWithString:r[@"image"]];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Update the UI
                    recipe.image = [PFFile fileWithName:@"image.png" data:imageData];
                    NSLog(@"image set");
                    [recipe saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                        if (succeeded){
                            NSLog(@"saved!");
                            completion(body.object[@"recipes"], nil);
                        }
                        else {
                            NSLog(@"not saved.");
                        }
                    }];
                });
            });
            
            
            
        }
        
        
        

        
    }];
}
@end



