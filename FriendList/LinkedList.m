
//
//  LinkedList.m
//  FriendList
//
//  Created by Markus Feng on 10/20/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import "LinkedList.h"
#import "ListIterator.h"

@implementation LinkedList


-(ListNode *)endNode: (bool) beginning{
    if(beginning){
        return self.first;
    }
    else{
        return self.last;
    }
}

-(ListNode *)nextNode: (ListNode *) node forwards:(bool) forwards{
    if(forwards){
        return node.next;
    }
    else{
        return node.previous;
    }
}

-(NSObject<ListIteratorProtocol> *)iterator{
    return [[ListIterator alloc] initWithList:self startFromFront:true];
}

-(NSObject<ListIteratorProtocol> *)reverseIterator{
    return [[ListIterator alloc] initWithList:self startFromFront:false];
}

-(void)add: (NSObject *) object fromBeginning: (bool) beginning{
    [self addObject: object atIndex:0 fromBeginning:beginning];
}

-(void)add: (NSObject *) object{
    [self add:object fromBeginning:false];
}

-(void)addObject: object atIndex: (int) index fromBeginning: (bool) beginning{
    if(index == 0){
        ListNode * newNode = [[ListNode alloc] init];
        newNode.object = object;
        if(beginning){
            newNode.next = self.first;
            self.first.previous = newNode;
            if(self.first == nil){
                self.last = newNode;
            }
            self.first = newNode;
        }
        else{
            newNode.previous = self.last;
            self.last.next = newNode;
            if(self.last == nil){
                self.first = newNode;
            }
            self.last = newNode;
        }
        return;
    }
    index = index - 1;
    ListNode * node = [self endNode: beginning];    
    for(int i = 0; i < index; i++){
        node = [self nextNode:node forwards:beginning];
        /*if(node == nil){
            //Something went wrong
            NSLog(@"Warning: Node index %i out of bounds!", index);
            return;
        }*/
    }
    ListNode * newNode = [[ListNode alloc] init];
    newNode.object = object;
    [self addNode:newNode afterNode:node];
}

-(void)addNode: (ListNode*)newNode afterNode: (ListNode*)node{
    newNode.previous = node;
    newNode.next = node.next;
    if(node.next == nil){
        self.last = newNode;
    }
    else{
        node.next.previous = newNode;
    }
    if(node == nil){
        self.first = newNode;
    }
    else{
        node.next = newNode;
    }
}

-(void)removeFromBeginning{
    self.first = self.first.next;
    self.first.previous = nil;
}

-(void)removeFromEnd{
    self.last = self.last.previous;
    self.last.next = nil;
}

//Return true if an object was removed
-(bool)remove: (NSObject *) object{
    return [self remove:object fromBeginning:false];
}

-(bool)remove: (NSObject *) object fromBeginning: (bool) beginning{
    ListNode * node = [self endNode: beginning];
    while(node != nil){
        if(node.object == object){
            [self removeNode:node];
            return true;
        }
        node = [self nextNode:node forwards:beginning];
    }
    return false;
}

-(void)removeAtIndex: (int) index fromBeginning: (bool) beginning{
    ListNode * node = [self endNode: beginning];
    for(int i = 0; i < index; i++){
        node = [self nextNode:node forwards:beginning];
        /*if(node == nil){
            //Something went wrong
            NSLog(@"Warning: Node index %i out of bounds!", index);
            return;
        }*/
    }
    [self removeNode:node];
}

-(void)removeNode:(ListNode *)node{
    if(node.next == nil){
        self.last = node.previous;
    }
    else{
        node.next.previous = node.previous;
    }
    if(node.previous == nil){
        self.first = node.next;
    }
    else{
        node.previous.next = node.next;
    }
}

-(bool)contains: (NSObject *) object{
    NSObject<ListIteratorProtocol> * iterator = [self iterator];
    while([iterator hasNext]){
        NSObject * val = [iterator next];
        if(val == object){
            return true;
        }
    }
    return false;
}

-(void)clear{
    self.first = nil;
    self.last = nil;
}

-(int)size{
    int size = 0;
    NSObject<ListIteratorProtocol> * iterator = [self iterator];
    while([iterator hasNext]){
        [iterator next];
        size++;
    }
    return size;
}


-(NSObject<ListIteratorProtocol> *)iteratorAtObject: (NSObject *)object{
    return [self iteratorAtObject:object atOccurance:0 fromBeginning:true];
}

-(NSObject<ListIteratorProtocol> *)iteratorAtObject: (NSObject *)object atOccurance: (int) occurance fromBeginning: (bool) beginning{
    NSObject<ListIteratorProtocol> * iterator;
    if(beginning){
        iterator = [self iterator];
    }
    else{
        iterator = [self reverseIterator];
    }
    int count;
    while([iterator hasNext]){
        NSObject * obj = [iterator next];
        if(obj == object){
            count++;
            if(count > occurance){
                return iterator;
            }
        }
    }
    return nil;
}

-(NSObject *)objectAtIndex: (int)index{
    int count = 0;
    NSObject<ListIteratorProtocol> * iterator = [self iterator];
    while([iterator hasNext]){
        NSObject * obj = [iterator next];
        count++;
        if(count > index){
            return obj;
        }
    }
    NSLog(@"err");
    return nil;
}

-(NSObject *)firstObject{
    return self.first.object;
}

-(NSObject *)lastObject{
    return self.last.object;
}

-(int)indexOfObject:(NSObject *)object{
    int index = 0;
    ListNode * node = [self endNode: true];
    while(node != nil){
        if(node.object == object){
            return index;
        }
        index++;
        node = [self nextNode:node forwards:true];
    }
    return -1;
}

@end
