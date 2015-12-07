//
//  PopupViewController.m
//  FriendList
//
//  Created by Markus Feng on 10/29/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import "AddFriendViewController.h"

@interface AddFriendViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
     self.popUpView.layer.cornerRadius = 5;
     self.popUpView.layer.shadowOpacity = 0.8;
     self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
     [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showInView:(UIView *)aView animated:(bool)animated{
    [aView addSubview:self.view];
    if(animated){
        [self showAnimate];
    }
    [self.table reloadData];
}

-(void)showAnimate{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

-(void)removeAnimate{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int count = 0;
    
    NSObject * final = nil;
    
    NSObject<ListIteratorProtocol> * iter = [self.world.people iterator];
    while([iter hasNext]){
        NSObject * obj = [iter next];
        if(obj != self.world.current && ![self.world.current.friends contains:obj]){
            count++;
            if(count > indexPath.row){
                final = obj;
                break;
            }
        }
    }
    
    [self.world.current.friends add:final];
    [self.world update];
    [self removeAnimate];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView*)view numberOfRowsInSection:(NSInteger)section{
    return self.world.people.size - self.world.current.friends.size - 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    int count = 0;
    
    NSObject * final = nil;
    
    NSObject<ListIteratorProtocol> * iter = [self.world.people iterator];
    while([iter hasNext]){
        NSObject * obj = [iter next];
        if(obj != self.world.current && ![self.world.current.friends contains:obj]){
            count++;
            if(count > indexPath.row){
                final = obj;
                break;
            }
        }
    }
    
    cell.textLabel.text = ((Person*)final).name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (IBAction)closePressed:(id)sender {
    [self removeAnimate];
}

@end
