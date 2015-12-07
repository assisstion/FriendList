//
//  InvitationViewController.h
//  FriendList
//
//  Created by Markus Feng on 11/1/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "World.h"

@interface InvitationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property World * world;

-(void)updateInvitations;

@end
