//
//  LinkedList.h
//  FriendList
//
//  Created by Markus Feng on 10/20/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListNode.h"
#import "ListIteratorProtocol.h"

@interface LinkedList : NSObject

@property ListNode * first;
@property (weak) ListNode * last;

-(NSObject<ListIteratorProtocol> *)iterator;
-(NSObject<ListIteratorProtocol> *)reverseIterator;
-(void)add: (NSObject *) object fromBeginning: (bool) beginning;
-(void)add: (NSObject *) object;
//-(void)addAfter: (NSObject *) object atOccurance: (int) occurance fromBeginning: (bool) beginning;
-(void)addObject: object atIndex: (int) index fromBeginning: (bool) beginning;
-(void)removeFromBeginning;
-(void)removeFromEnd;
//Return true if an object was removed
-(bool)remove: (NSObject *) object;
-(bool)remove: (NSObject *) object fromBeginning: (bool) beginning;
//-(bool)removeAtOccurance: (int) occurance fromBeginning: (bool) beginning;
-(void)removeAtIndex: (int) index fromBeginning: (bool) beginning;
-(bool)contains: (NSObject *) object;
-(void)clear;
-(NSObject *)objectAtIndex: (int)index;
-(NSObject *)firstObject;
-(NSObject *)lastObject;

//-(void)addAll: (NSObject<ListIteratorProtocol> *)list;
//-(int)removeAll: (NSObject<ListIteratorProtocol> *)list;
-(int)size;
-(int)indexOfObject: (NSObject *)object;

-(NSObject<ListIteratorProtocol> *)iteratorAtObject: (NSObject *)object;
-(NSObject<ListIteratorProtocol> *)iteratorAtObject: (NSObject *)object atOccurance: (int) occurance fromBeginning: (bool) beginning;

@end
