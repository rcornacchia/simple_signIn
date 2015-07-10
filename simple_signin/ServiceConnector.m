//
//  ServiceConnector.m
//  Service Reader
//
//  Created by Divan Visagie on 2012/08/25.
//  Copyright (c) 2012 Divan Visagie. All rights reserved.
//

#import "ServiceConnector.h"
#import "JSONDictionaryExtensions.h"

@implementation ServiceConnector{
    NSData *receivedData;;
}


-(void)register:(NSString *)email withName:(NSString *)name{
    NSString *useremail = email;
    NSString *username = name;
    NSString *myRequestString = [NSString stringWithFormat:@"&email=%@&name=%@",useremail,username];
    NSData *myRequestData =[myRequestString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[myRequestData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://robraven.com/php/register.php"]];
    
    [request setHTTPMethod: @"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    // Set Request Body
    [request setHTTPBody: myRequestData];
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if(conn)
    {
        NSLog(@"Connection Successful");
    }
    else
    {
        NSLog(@"Connection could not be made");
    }

    

    
}

-(void)authenticate:(NSString *)email{
    NSString *useremail = email;
    NSString *myRequestString = [NSString stringWithFormat:@"&email=%@",useremail];
    NSData *myRequestData =[myRequestString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[myRequestData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://robraven.com/php/x.php"]];
    
    [request setHTTPMethod: @"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    // Set Request Body
    [request setHTTPBody: myRequestData];
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if(conn)
    {
        NSLog(@"Connection Successful");
    }
    else
    {
        NSLog(@"Connection could not be made");
    }

}


#pragma mark - Data connection delegate -

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{ // executed when the connection receives data
    
    receivedData = data;
    /* NOTE: if you are working with large data , it may be better to set recievedData as NSMutableData 
             and use  [receivedData append:Data] here, in this event you should also set recievedData to nil
             when you are done working with it or any new data received could end up just appending to the 
             last message received*/
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{ //executed when the connection fails
    
    NSLog(@"Connection failed with error: %@",error.localizedDescription);
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    
    /*This message is sent when there is an authentication challenge ,our server does not have this requirement so we do not need to handle that here*/
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSLog(@"Request Complete,received %lu bytes of data",(unsigned long)receivedData.length);
    
    [self.delegate requestReturnedData:receivedData];//send the data to the delegate
}

@end
