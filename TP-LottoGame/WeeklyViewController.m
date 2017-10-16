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
    _inputOne.delegate = self;
    _inputTwo.delegate = self;
    _inputThree.delegate = self;
    _inputFour.delegate = self;
    _inputFive.delegate = self;
    _inputSix.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sgmGameSelectorChange:(id)sender {
    if([sender selectedSegmentIndex]== 1){
        _inputSix.enabled = YES;
        _inputStateSix.enabled = YES;
        _inputSix.hidden = NO;
        _inputStateSix.hidden = NO;
    }else{
        _inputSix.enabled = NO;
        _inputStateSix.enabled = NO;
        _inputSix.hidden = YES;
        _inputStateSix.hidden = YES;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self validateInputBoxes];
    return !([newString length] > 2) ;
}
-(void)validateInputBoxes{
    NSString*game = @"Florida Lotto";
    NSString * inputValue = _inputOne.text;
    NSInteger inputOneValue = [inputValue integerValue];
    
    inputValue = _inputTwo.text;
    NSInteger inputTwoValue = [inputValue integerValue];
    
    inputValue = _inputThree.text;
    NSInteger inputThreeValue = [inputValue integerValue];
    
    inputValue = _inputFour.text;
    NSInteger inputFourValue = [inputValue integerValue];
    
    inputValue = _inputFive.text;
    NSInteger inputFiveValue = [inputValue integerValue];
    
    inputValue = _inputSix.text;
    NSInteger inputSixValue = [inputValue integerValue];
    int min, max = 53, secondMax = 17;
    BOOL change = NO,changeLuckymoney = NO;
    NSString*message;
    if (_sgmGameSelector.selectedSegmentIndex == 0){
        min = 1;
        max = 47;
        secondMax = 17;
        game = @"Lucky Money";
    }
    
    if(!((inputOneValue > 0) && (inputOneValue <= max)))
    {
        _inputOne.text=@"";
        if(!(inputOneValue==0))
            change = YES;
    }
    if(!((inputTwoValue > 0) && (inputTwoValue <= max)))
    {
        _inputTwo.text=@"";
        if(!(inputTwoValue==0))
            change = YES;
    }
    if(!((inputThreeValue > 0) && (inputThreeValue <= max)))
    {
        _inputThree.text=@"";
        if(!(inputThreeValue==0))
            change = YES;
    }
    if(!((inputFourValue > 0) && (inputFourValue <= max)))
    {
        _inputFour.text=@"";
        if(!(inputFourValue==0))
            change = YES;
    }
    if(_sgmGameSelector.selectedSegmentIndex == 0){
    if(!((inputFiveValue > 0) && (inputFiveValue <= secondMax)))
    {
        _inputFive.text=@"";
        if(!(inputFiveValue==0)){
            
            changeLuckymoney = YES;
            change = YES;
            NSLog(@"Lucky Money Ball invalid");
        }
        }};
    if(_sgmGameSelector.selectedSegmentIndex == 1){
        if(!((inputFiveValue > 0) && (inputFiveValue <= secondMax)))
        {
            _inputFive.text=@"";
            if(!(inputFiveValue==0))
                change = YES;
        }
    }
    if(!((inputSixValue > 0) && (inputSixValue <= max)))
    {
        _inputFive.text=@"";
        if(!(inputFiveValue==0))
            change = YES;
    }
    if(changeLuckymoney == YES){
        message = [NSString stringWithFormat:@"%@ valid numbers are between 1 and %d. For the Lucky Ball. Please reenter your choices.", game, secondMax];
    }else{
        message = [NSString stringWithFormat:@"%@ valid numbers are between 1 and %d Please reenter your choices.", game, max];
    }
    if(change==YES)
        [self showMessage:message andTitle:@"Invalid Entry"];
}

-(void)showMessage:(NSString*)message andTitle:(NSString*)title{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    /*UIAlertAction* noButton = [UIAlertAction
     actionWithTitle:@"No, thanks"
     style:UIAlertActionStyleDefault
     handler:^(UIAlertAction * action) {
     //Handle no, thanks button
     }];*/
    
    [alert addAction:yesButton];
    //[alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}@end
