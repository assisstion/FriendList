//
//  ListIterator.m
//  FriendList
//
//  Created by Markus Feng on 10/20/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import "ListIterator.h"

@implementation ListIterator{
    LinkedList * listReference;
    
    ListNode * stackNext;
    ListNode * stackPrevious;
    bool forward;
}

-(NSObject<ListIteratorProtocol> *)goToObject:(NSObject *)object{
    return [listReference iteratorAtObject:object];
}

-(NSObject<ListIteratorProtocol> *)goToObject:(NSObject *)object atOccurance: (int) occurance fromBeginning: (bool) beginning{
    return [listReference iteratorAtObject:object atOccurance:occurance fromBeginning:beginning];
}

-(ListIterator *)initWithList: (LinkedList *)list startFromFront: (bool)fromFront{
    self = [super init];
    if(self){
        listReference = list;
        forward = fromFront;
        [self reset];
    }
    return self;
}

-(void)reset{
    if(forward){
        stackNext = listReference.first;
        stackPrevious = nil;
    }
    else{
        stackNext = listReference.last;
        stackPrevious = nil;
    }
}

-(bool)hasNext{
    return stackNext != nil;
}

-(NSObject *)next{
    ListNode * temp = stackNext;
    if(forward){
        if(stackNext == nil){
            stackPrevious = listReference.last;
        }
        else{
            stackPrevious = stackNext.previous;
        }
        stackNext = stackNext.next;
    }
    else{
        if(stackNext == nil){
            stackPrevious = listReference.first;
        }
        else{
            stackPrevious = stackNext.next;
        }
        stackNext = stackNext.previous;
    }
    return temp.object;
}

-(bool)hasPrevious{
    return stackPrevious != nil;
}

-(NSObject *)previous{
    ListNode * temp = stackPrevious;
    if(forward){
        if(stackPrevious == nil){
            stackNext = listReference.first;
        }
        else{
            stackNext = stackPrevious.next;
        }
        stackPrevious = stackPrevious.previous;
    }
    else{
        if(stackPrevious == nil){
            stackNext = listReference.last;
        }
        else{
            stackNext = stackPrevious.previous;
        }
        stackPrevious = stackPrevious.next;
    }
    return temp.object;
}

-(int)currentIndex{
    if((!forward ^ (stackNext == nil)) && (forward ^ (stackPrevious == nil))){
        return [listReference size];
    }
    else{
        return [listReference indexOfObject:stackNext.object];
    }
}
@end
