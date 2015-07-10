//
//  ViewController.m
//  simple_signin
//
//  Created by Rob Cornacchia on 7/9/15.
//  Copyright (c) 2015 Blackbird. All rights reserved.
//

#import "ViewController.h"
#import "JSONDictionaryExtensions.h"
#import "greetingViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginEmail;
@property(nonatomic) NSString *name;
@property(nonatomic) BOOL hidden;
@property(nonatomic) BOOL registering;
@property (weak, nonatomic) IBOutlet UITextField *regName;
@property (weak, nonatomic) IBOutlet UITextField *regEmail;
@property(nonatomic) NSString *rName;



@end

@implementation ViewController

@synthesize loginEmail, name, hidden, regName, regEmail, rName, registering;

- (IBAction)signIn:(id)sender {
    ServiceConnector *serviceConnector = [[ServiceConnector alloc] init];
    serviceConnector.delegate = self;

    NSLog(@"sss");
    NSString *email = loginEmail.text;
    NSLog(@"%@", email);
    [serviceConnector authenticate:email];
}

- (IBAction)register:(id)sender {
    
    registering = true;
    
    ServiceConnector *serviceConnector = [[ServiceConnector alloc] init];
    serviceConnector.delegate = self;

    rName = regName.text;
    NSString *email = regEmail.text;
    [serviceConnector register:email withName:rName];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    registering = false;
    hidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestReturnedData:(NSData *)data{ //activated when data is returned
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithJSONData:data];
    NSLog(@"%@", dictionary);
    name = [dictionary objectForKey:@"value1"];
    NSLog(@"%@", name);
    hidden = false;
    if(registering == false) {
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"loginSegue"]){
        greetingViewController *controller = (greetingViewController *)segue.destinationViewController;
        
        
        if(hidden == true) {
            // haven't received data yet, hide the string
            controller.name = @"One second, just checking";
        }else {
            NSLog(@"blue");
            NSLog(@"%@", name);
            controller.name = name;
        }
//        controller.greeting.text = controller.name;
    }
}


@end
