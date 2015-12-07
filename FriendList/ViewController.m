//
//  ViewController.m
//  FriendList
//
//  Created by Markus Feng on 10/20/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import "ViewController.h"
#import "World.h"
#import "AddFriendViewController.h"
#import "AddPersonViewController.h"
#import "InvitationViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property World * world;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property AddFriendViewController * addFriend;
@property AddPersonViewController * addPerson;
@property InvitationViewController * invitation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.world = [[World alloc] init];
    self.world.view = self;
    
    self.addFriend = [[AddFriendViewController alloc] init];
    self.addFriend.world = self.world;
    
    self.addPerson = [[AddPersonViewController alloc] init];
    self.addPerson.world = self.world;
    
    self.invitation = [[InvitationViewController alloc] init];
    self.invitation.world = self.world;
    
    LinkedList * list = self.world.people;

    //Add sample people to the world
    [list add:[[Person alloc] initWithName:@"Markus"]];
    [list add:[[Person alloc] initWithName:@"Jack"]];
    [list add:[[Person alloc] initWithName:@"Will"]];
    [list add:[[Person alloc] initWithName:@"Liam"]];
    [list add:[[Person alloc] initWithName:@"Aditya"]];
    [list add:[[Person alloc] initWithName:@"Bella"]];
    [list add:[[Person alloc] initWithName:@"Kate"]];
    [list add:[[Person alloc] initWithName:@"Anthony"]];
    
    self.world.iterator = [self.world.people iterator];
    
    self.world.current = (Person *)self.world.iterator.next;
    
    self.table.allowsMultipleSelectionDuringEditing = NO;
    
    [self.navigationItem setTitle:@"World"];
    
    [self.world update];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)previousPressed:(id)sender {
    if(self.world.iterator.hasPrevious){
        self.world.current = (Person *)self.world.iterator.previous;
    }
    [self.world update];
    
}

- (IBAction)nextPressed:(id)sender {
    if(self.world.iterator.hasNext){
        self.world.current = (Person *)self.world.iterator.next;
    }
    [self.world update];
}

-(void)update{
    self.nameLabel.text = self.world.current.name;
    [self.table reloadData];
    CGRect frame = self.table.frame;
    frame.size.height = self.table.contentSize.height;
    self.table.frame = frame;
}

- (IBAction)addFriendPressed:(id)sender {
    [self.addFriend showInView:self.view animated:true];
}
- (IBAction)addPersonPressed:(id)sender {
    [self.addPerson showInView:self.view animated:true];
}
- (IBAction)removePersonPressed:(id)sender {
    if(![self.world.iterator hasNext] && ![self.world.iterator hasPrevious]){
        //Can't remove last person from world
        return;
    }
    NSObject<ListIteratorProtocol> * iterator = [self.world.people iterator];
    while([iterator hasNext]){
        Person * current = (Person *)[iterator next];
        [current.friends remove:self.world.current];
    }
    [self.world.people remove:self.world.current];
    NSObject * next;
    if([self.world.iterator hasNext]){
        next = self.world.iterator.next;
    }
    else if([self.world.iterator hasPrevious]){
        next = self.world.iterator.previous;
    }
    else{
        return;
    }
    self.world.current = (Person *)next;
    [self.world update];
}

- (IBAction)inviteFriendsPressed:(id)sender {
    [[self navigationController] pushViewController:self.invitation animated: YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView*)view numberOfRowsInSection:(NSInteger)section{
    return self.world.current.friends.size;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = ((Person*)[self.world.current.friends objectAtIndex:(int)indexPath.row]).name;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (bool)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.world.current.friends removeAtIndex:(int)indexPath.row fromBeginning:true];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
@end
