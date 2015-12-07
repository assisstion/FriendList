//
//  AddPersonViewController.h
//  FriendList
//
//  Created by Markus Feng on 10/30/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "World.h"

//Using popup view tutorial from: http://bit.ly/1WkCKqG
@interface AddPersonViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;

@property World * world;

-(void)showInView:(UIView *)aView animated:(bool)animated;

@end
