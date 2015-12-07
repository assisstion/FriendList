//
//  ListIteratorProtocol.h
//  FriendList
//
//  Created by Markus Feng on 10/21/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ListIteratorProtocol <NSObject>

-(bool)hasNext;
-(NSObject *)next;
-(bool)hasPrevious;
-(NSObject *)previous;

-(int)currentIndex;

@end
