//
//  LoginViewController.m
//  ParseChat
//
//  Created by laurentsai on 7/6/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)didTapLogin:(id)sender {
    NSString *username= self.usernameField.text;
    NSString *password= self.passwordField.text;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error Logging In"
           message:@"Usernamne or password cannot be empty."
    preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //nothing
    }];
    [alert addAction:okAction];
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil)
        {
            [alert setMessage:[NSString stringWithFormat: @"%@", error.description]];
            [self presentViewController:alert animated:YES completion:^{
                //nobthing
            }];
            NSLog(@"User log in failed: %@", error.localizedDescription);
        }
        else
        {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}
- (IBAction)didTapSignUp:(id)sender {
    PFUser *newUser= [PFUser user];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error Signing In"
           message:@"Usernamne or password cannot be empty."
    preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //nothing
    }];
    [alert addAction:okAction];
    
    if([self.usernameField.text isEqualToString:@""])//if username empty
        [self presentViewController:alert animated:YES completion:^{
            //nobthing
        }];
    else
    {
        newUser.username= self.usernameField.text;
        newUser.password= self.passwordField.text;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if(error!=nil)//if error occured
            {
                [alert setMessage:[NSString stringWithFormat: @"%@", error.description]];
                [self presentViewController:alert animated:YES completion:^{
                    //nobthing
                }];
                NSLog(@"Error signing up: %@", error.description);
            }
            else
                NSLog(@"User successfully created");
        }];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
