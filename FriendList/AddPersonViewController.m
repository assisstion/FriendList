//
//  AddPersonViewController.m
//  FriendList
//
//  Created by Markus Feng on 10/30/15.
//  Copyright © 2015 Markus Feng. All rights reserved.
//

#import "AddPersonViewController.h"

@interface AddPersonViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textLabel;

@end

@implementation AddPersonViewController


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
    self.textLabel.text = @"";
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
- (IBAction)addPressed:(id)sender {
    if([self.textLabel.text length] == 0){
        //Prevent adding zero length names
        return;
    }
    [self.world.people addObject:[[Person alloc] initWithName:self.textLabel.text] atIndex:[self.world.iterator currentIndex] fromBeginning:true];
    //Clear list iterator cache
    [self.world.iterator next];
    self.world.current = (Person *)[self.world.iterator previous];
    [self.world update];
    [self removeAnimate];
}
- (IBAction)closePressed:(id)sender {
    [self removeAnimate];
}

@end
