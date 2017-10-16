//
//  WeeklyViewController.m
//  TP-LottoGame
//
//  Created by Langston Duncanson on 10/16/17.
//  Copyright © 2017 Langston Duncanson. All rights reserved.
//

#import "WeeklyViewController.h"

@interface WeeklyViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *gameImageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmGameSelector;
@property (weak, nonatomic) IBOutlet UITextField *inputOne;
@property (weak, nonatomic) IBOutlet UITextField *inputTwo;
@property (weak, nonatomic) IBOutlet UITextField *inputThree;
@property (weak, nonatomic) IBOutlet UITextField *inputFour;
@property (weak, nonatomic) IBOutlet UITextField *inputFive;
@property (weak, nonatomic) IBOutlet UITextField *inputSix;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inputStateOne;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inputStateTwo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inputStateThree;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inputStateFour;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inputStateFive;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inputStateSix;
@property (weak, nonatomic) IBOutlet UIButton *submitTicketBtn;
@property (weak, nonatomic) IBOutlet UIButton *winnerBtn;

@end

@implementation WeeklyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
