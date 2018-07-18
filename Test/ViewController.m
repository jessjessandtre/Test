//
//  ViewController.m
//  Test
//
//  Created by Jessica Shu on 7/17/18.
//  Copyright © 2018 Jessica Shu. All rights reserved.
//

#import "ViewController.h"
#import "MovieAPIManager.h"
#import "UIImageView+AFNetworking.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *posterView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.\
    //MovieAPIManager *manager = [MovieAPIManager new];
    MovieAPIManager *manager = [MovieAPIManager new];
    [manager fetchNowPlaying:^(NSDictionary *recipes, NSError *error) {
        
        if (error) {
            NSLog(@"ERROR");
        }
        else if (recipes)
        {
            NSString *baseURLString = @"https://spoonacular.com/recipeImages/624788-556x370.jpg";
            NSURL *posterURL  = [NSURL URLWithString:baseURLString];
            [self.posterView setImageWithURL:posterURL];
        }
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
