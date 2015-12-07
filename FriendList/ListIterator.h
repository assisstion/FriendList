//
//  ListIterator.h
//  FriendList
//
//  Created by Markus Feng on 10/20/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinkedList.h"
#import "ListIteratorProtocol.h"

@interface ListIterator : NSObject <ListIteratorProtocol>

-(ListIterator *)initWithList: (LinkedList *)list startFromFront: (bool)fromFront;
-(void)reset;
-(NSObject<ListIteratorProtocol> *)goToObject:(NSObject *)object;
-(NSObject<ListIteratorProtocol> *)goToObject:(NSObject *)object atOccurance: (int) occurance fromBeginning: (bool) beginning;

@end
