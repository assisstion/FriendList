//
//  World.m
//  FriendList
//
//  Created by Markus Feng on 10/23/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import "World.h"

@implementation World


-(id)init{
    self = [super init];
    if(self) {
        self.people = [[LinkedList alloc] init];
    }
    return self;
}

-(void)update{
    [self.view update];
}


@end
