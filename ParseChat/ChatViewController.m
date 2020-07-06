//
//  ChatViewController.m
//  ParseChat
//
//  Created by laurentsai on 7/6/20.
//  Copyright © 2020 laurentsai. All rights reserved.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>
#import "ChatCell.h"
@interface ChatViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshOnTimer) userInfo:nil repeats:true];

}
- (IBAction)didTapSend:(id)sender {
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_fbu2019"];
    chatMessage[@"text"] = self.chatTextField.text;
    chatMessage[@"user"]= PFUser.currentUser;
    
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
         if (succeeded) {
               NSLog(@"Success saving chat!");
             [self.chatTextField setText:@""];
           } else {
               NSLog(@"Problem saving chat: %@", error.localizedDescription);
           }
    }];

}
-(void) refreshOnTimer{
    PFQuery *chatQuery= [PFQuery queryWithClassName:@"Message_fbu2019"];
    [chatQuery orderByDescending:@"createdAt"];
    [chatQuery includeKey:@"user"];
    [chatQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable chats, NSError * _Nullable error) {
        if(chats)
        {
            NSLog(@"Success getting chats");
            self.chatMessages=chats;
            [self.tableView reloadData];

        }
        else{
            NSLog(@"Error getting chats: %@", error.localizedDescription);
        }
    }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ChatCell *currentCell= [self.tableView dequeueReusableCellWithIdentifier:@"ChatCell" forIndexPath:indexPath];
    PFObject *chatMessage= self.chatMessages[indexPath.row];
    
    PFUser *user = chatMessage[@"user"];
    if (user != nil) {
        currentCell.usernameLabel.text=user.username;
    } else {
        currentCell.usernameLabel.text = @"anon";
    }
    
    currentCell.chatLabel.text= chatMessage[@"text"];
    return currentCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chatMessages.count;
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
