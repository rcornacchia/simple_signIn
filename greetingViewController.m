//
//  greetingViewController.m
//  simple_signin
//
//  Created by Rob Cornacchia on 7/9/15.
//  Copyright (c) 2015 Blackbird. All rights reserved.
//

#import "greetingViewController.h"
#import "JSONDictionaryExtensions.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *greeting;
@property(nonatomic) NSString *name;

@end


@implementation greetingViewController

@synthesize name, greeting;



- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)viewWillAppear:(BOOL)animatedd {

    if(!name){
        //user was not found
        name = @"That email has not been registered yet.";
    }
    
    NSString *test = name;
    greeting.text = [NSString stringWithFormat:@"Welcome %@!", name];

    NSLog(@"Testc");
    NSLog(@"%@", test);
}



@end
