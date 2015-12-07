//
//  World.h
//  FriendList
//
//  Created by Markus Feng on 10/23/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinkedList.h"
#import "ListIteratorProtocol.h"
#import "Person.h"
#import "ViewController.h"

@interface World : NSObject

//LinkedList of people
@property LinkedList * people;
@property NSObject<ListIteratorProtocol> * iterator;
@property Person * current;

@property ViewController * view;

-(void)update;

@end
