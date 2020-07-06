//
//  ChatViewController.m
//  ParseChat
//
//  Created by laurentsai on 7/6/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>
@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)didTapSend:(id)sender {
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_fbu2020"];
    chatMessage[@"text"] = self.chatTextField.text;
    
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
         if (succeeded) {
               NSLog(@"Success saving chat!");
             [self.chatTextField setText:@""];
           } else {
               NSLog(@"Problem saving chat: %@", error.localizedDescription);
           }
    }];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
