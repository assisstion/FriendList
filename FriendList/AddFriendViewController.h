//
//  PopupViewController.h
//  FriendList
//
//  Created by Markus Feng on 10/29/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "World.h"

//Using popup view tutorial from: http://bit.ly/1WkCKqG
@interface AddFriendViewController : UIViewController <UITableViewDataSource, UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *popUpView;

@property World * world;

-(void)showInView:(UIView *)aView animated:(bool)animated;

@end
