//
//  Person.m
//  FriendList
//
//  Created by Markus Feng on 10/23/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import "Person.h"

@implementation Person

-(Person *)initWithName: (NSString *)name{
    self = [super init];
    if(self){
        self.name = name;
        self.friends = [[LinkedList alloc] init];
    }
    return self;
}


@end
