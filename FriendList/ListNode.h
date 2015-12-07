//
//  ListNode.h
//  FriendList
//
//  Created by Markus Feng on 10/20/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListNode : NSObject

@property NSObject * object;
@property ListNode * next;
@property (weak) ListNode * previous;

@end
