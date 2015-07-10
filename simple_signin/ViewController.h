//
//  ViewController.h
//  simple_signin
//
//  Created by Rob Cornacchia on 7/9/15.
//  Copyright (c) 2015 Blackbird. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnector.h"

@interface ViewController : UIViewController <ServiceConnectorDelegate>

- (IBAction)signIn:(id)sender;

@end

