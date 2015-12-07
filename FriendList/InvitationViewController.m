//
//  InvitationViewController.m
//  FriendList
//
//  Created by Markus Feng on 11/1/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import "InvitationViewController.h"

@interface InvitationViewController ()

@property LinkedList * invitationList;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UIStepper *distanceStepper;

@end

@implementation InvitationViewController

-(instancetype)init{
    self = [super init];
    if(self){
        self.invitationList = [[LinkedList alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Invited Friends"];
    // Do any additional setup after loading the view from its nib.
    [self updateInvitations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateInvitations{
    int i = (int)self.distanceStepper.value;
    if(i == 0){
        i = 2;
    }
    self.distance.text = [NSString stringWithFormat:@"%i",(int)self.distanceStepper.value];
    [self.invitationList clear];
    [self addFriends:self.world.current.friends layers:(int)(self.distanceStepper.value)];
    [self.table reloadData];
}

- (IBAction)stepperChanged:(id)sender {
    [self updateInvitations];
}

-(void)addFriends:(LinkedList *)list layers:(int)layers{
    if(layers <= 0){
        return;
    }
    else{
        LinkedList * friends = list;
        NSObject<ListIteratorProtocol> * iterator = [friends iterator];
        while([iterator hasNext]){
            NSObject * friend = [iterator next];
            if(friend != self.world.current && ![self.invitationList contains:friend]){
                [self.invitationList add:friend];
                [self addFriends:[(Person*)friend friends] layers:layers-1];
            }
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView*)view numberOfRowsInSection:(NSInteger)section{
    return self.invitationList.size;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = ((Person*)[self.invitationList objectAtIndex:(int)indexPath.row]).name;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

@end
