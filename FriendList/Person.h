//
//  Person.h
//  FriendList
//
//  Created by Markus Feng on 10/23/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinkedList.h"

@interface Person : NSObject

//LinkedList of people
@property LinkedList * friends;
@property NSString * name;

-(Person *)initWithName: (NSString *)name;

@end
