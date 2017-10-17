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
    _inputOne.tag = 1;
    _inputTwo.tag = 2;
    _inputThree.tag = 3;
    _inputFour.tag = 4;
    _inputFive.tag = 5;
    _inputSix.tag = 6;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)winnerCheck:(id)sender {
    NSMutableArray * choicesArray = [self generateArray];
    NSMutableArray * winningArray = [self generateWinningNumbers];
    int index = (int)_sgmGameSelector.selectedSegmentIndex;
    //NSLog(@"choices: %@,\n winning: %@",choicesArray,winningArray);
    
    
        choicesArray = [self sortArray:choicesArray];
        winningArray = [self sortArray:winningArray];

    NSString *choiceDesc = [choicesArray componentsJoinedByString:@","];
    NSString *winningDesc = [winningArray componentsJoinedByString:@","];
    int matchCount;
        matchCount = [self checkWinnings:choicesArray andWinning:winningArray exact:YES];
    NSMutableString *winningMessage = [NSMutableString stringWithFormat:@"not"];
    if(index == 0){
        if(matchCount == 5)
            winningMessage = [NSMutableString stringWithFormat:@"a"];
    }else{
        if(matchCount == 6)
            winningMessage = [NSMutableString stringWithFormat:@"a"];
    }
    NSString * winningPrize = [self reportWinnings:matchCount andGameType:index];
    NSString * message = [NSString stringWithFormat:@"Your choice was: %@\n Winning Numbers are: %@ \n You have %d matches. \n You are %@ winner\n Your Prize is:%@",choiceDesc,winningDesc,matchCount,winningMessage, winningPrize];
    [self showMessage:message andTitle:@"Winning Status"];
    [self enableControls:YES];
    _winnerBtn.enabled = NO;
}
-(NSString*)reportWinnings:(int)matchCount andGameType:(int)gameIndex{
    NSString* result = @"";
    switch (gameIndex) {
        case 0:
            if(matchCount == 5)
                result = [NSString stringWithFormat:@"You won $50,000"];
            break;
        case 1:
            if(matchCount == 6)
                result = [NSString stringWithFormat:@"You won $200,000"];
            break;
        default:
            break;
    }
    if([result isEqualToString:@""])
        result = [NSString stringWithFormat:@"You didn't win!"];
    return result;
}
-(int)checkWinnings:(NSMutableArray*)choices andWinning:(NSMutableArray*) winning exact:(BOOL)exactFlag{
    int count = 0;
    BOOL luckymoneyball = NO;
    if(_sgmGameSelector.selectedSegmentIndex == 1)
            for (int i = 0; (!(i == [choices count])); i++){
                for (int j = 0; (!(j == [winning count])); j++){
                    NSLog(@"%@ vs %@", [choices objectAtIndex:i], [winning objectAtIndex:j]);
                    if([choices objectAtIndex:i] == [winning objectAtIndex:j]){
                        NSLog(@"Match Found");
                        count++;
                    }
                    
                }
            }
    if(_sgmGameSelector.selectedSegmentIndex == 0)
    for (int i = 0; (!(i == [choices count])); i++){
        for (int j = 0; (!(j == [winning count])); j++){
            NSLog(@"%@ vs %@", [choices objectAtIndex:i], [winning objectAtIndex:j]);
            if(!((i==4)||(j==4))){
            if([choices objectAtIndex:i] == [winning objectAtIndex:j]){
                NSLog(@"Match Found");
                count++;
            }
            }else{
                if(luckymoneyball == NO)
                if([choices objectAtIndex:4] == [winning objectAtIndex:4]){
                    NSLog(@"Match Found");
                    count++;
                    luckymoneyball = YES;
                }
            }
        }
    }
    return count;
}

-(NSMutableArray*)generateWinningNumbers{
    int index = (int)_sgmGameSelector.selectedSegmentIndex;
    NSMutableArray * winningArray = [[NSMutableArray alloc] init];
    if(index == 0){
        while(!([winningArray count] == 5)){
            NSInteger random;
            if (([winningArray count] == 4)){
                random = arc4random_uniform(16) + 1;
            }else{
             random = arc4random_uniform(47) + 1;
            }
            BOOL flag = NO;
            for(id element in winningArray){
                if([element intValue] == random){
                    flag = YES;
                }
            }
            if((flag == NO) || ([winningArray count] == 4)){
                [winningArray addObject:[NSNumber numberWithInt:(int)random]];
            }
        }
    }else{
        while(!([winningArray count] == 5)){
            NSInteger random = arc4random_uniform(53) + 1;
            BOOL flag = NO;
            for(id element in winningArray){
                if([element intValue] == random){
                    flag = YES;
                }
            }
            if(flag == NO){
                [winningArray addObject:[NSNumber numberWithInt:(int)random]];
            }
        }
        
    
    }
return winningArray;
}

-(NSMutableArray*)sortArray:(NSMutableArray*)sortArray{
    NSNumber *holderChoice ;
    if(_sgmGameSelector.selectedSegmentIndex == 0)
    {
        holderChoice = [sortArray objectAtIndex:4];
        [sortArray removeObjectAtIndex:4];
    }
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [sortArray sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    if(_sgmGameSelector.selectedSegmentIndex ==0)
    {
        [sortArray addObject:holderChoice];
    }
    return sortArray;
}
    
-(void)enableControls:(BOOL)state{
    _sgmGameSelector.enabled = state;
    _inputOne.enabled = state;
    _inputStateOne.enabled = state;
    _inputTwo.enabled = state;
    _inputStateTwo.enabled = state;
    _inputThree.enabled = state;
    _inputStateThree.enabled = state;
    _inputFour.enabled = state;
    _inputStateFour.enabled = state;
    _inputFive.enabled = state;
    _inputStateFive.enabled = state;
    _inputSix.enabled = state;
    _inputStateSix.enabled = state;
    _submitTicketBtn.enabled = state;
}

    -(IBAction)submitAction:(id)sender{
        if (_sgmGameSelector.selectedSegmentIndex == 0){
            if(![_inputOne.text  isEqual: @""])
                if(![_inputTwo.text  isEqual: @""])
                    if(![_inputThree.text  isEqual: @""])
                        if(![_inputFour.text  isEqual: @""])
                            if(![_inputFive.text  isEqual: @""]){
                                if([self checkForDuplicateEntry]){
                                    [self showMessage:@"Duplicates are not allowed within Lucky Money." andTitle:@"Duplicates Found"];
                                }else{
                                    [self showMessage:[self buildSubmissionString] andTitle:@"Entry State"];
                                    [self processSubmission];
                                }}
        }
        if (_sgmGameSelector.selectedSegmentIndex == 1){
            if(![_inputOne.text  isEqual: @""])
                if(![_inputTwo.text  isEqual: @""])
                    if(![_inputThree.text  isEqual: @""])
                        if(![_inputFour.text  isEqual: @""])
                            if(![_inputFive.text  isEqual: @""])
                                if(![_inputSix.text  isEqual: @""]){
                                    if([self checkForDuplicateEntry]){
                                        [self showMessage:@"Duplicates are not allowed within Florida Lotto." andTitle:@"Duplicates Found"];
                                    }else{
                                        [self showMessage:[self buildSubmissionString] andTitle:@"Entry State"];
                                        [self processSubmission];
                                    }
                                }
            
        }
    }
-(void)processSubmission{
    [self enableControls:NO];
    _winnerBtn.enabled = YES;
}
-(NSMutableArray*)generateArray{
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
    int index = (int)_sgmGameSelector.selectedSegmentIndex;
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [result addObject:[NSNumber numberWithInt:(int)inputOneValue]];
    [result addObject:[NSNumber numberWithInt:(int)inputTwoValue]];
    [result addObject:[NSNumber numberWithInt:(int)inputThreeValue]];
    [result addObject:[NSNumber numberWithInt:(int)inputFourValue]];
    [result addObject:[NSNumber numberWithInt:(int)inputFiveValue]];
    if(index>0)
        [result addObject:[NSNumber numberWithInt:(int)inputSixValue]];
    return result;
}

-(NSString*)buildSubmissionString{
    NSString* result;
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
    
    int amount;
    int index = (int)_sgmGameSelector.selectedSegmentIndex;
    amount = 1;

    if(index == 0)
    {
        result= [NSString stringWithFormat:@"Your selected numbers are: %d, %d, %d, %d, %d\n Amount due: $%d.00", (int)inputOneValue, (int)inputTwoValue, (int)inputThreeValue, (int) inputFourValue, (int)inputFiveValue, amount];
    }
    
    if(index == 1)
    {
        result= [NSString stringWithFormat:@"Your selected numbers are: %d, %d, %d, %d, %d, %d.\n Amount due: $%d.00", (int)inputOneValue, (int)inputTwoValue, (int)inputThreeValue, (int) inputFourValue, (int)inputFiveValue, (int)inputSixValue, amount];
    }
    return result;
}

-(BOOL)checkForDuplicateEntry{
    NSMutableArray*myArray = [self generateArray];
    NSLog(@"Object at index 4 is: %@",[myArray objectAtIndex:4]);
    for (int i = 0; (i < [myArray count]); i++) {
        for(int j = 0; (j < [myArray count]); j++){
            if (([myArray objectAtIndex:i]) == ([myArray objectAtIndex:j])){
                if(!(i == j))
                    if(_sgmGameSelector.selectedSegmentIndex == 0)
                        if(!((i==4)||(j==4))){
                            return YES;
                        }
                        }
        }
    }
    return NO;
}

- (IBAction)sgmGameSelectorChange:(id)sender {
    [self resetValues];
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
- (IBAction)inputOneChange:(id)sender {
    if([sender selectedSegmentIndex] == 1)
        _inputOne.text = [NSString stringWithFormat:@"%d",[self quickPlay:_inputOne]];
    [self changeEnables];
}
- (IBAction)inputTwoChange:(id)sender {
    if([sender selectedSegmentIndex] == 1)
        _inputTwo.text = [NSString stringWithFormat:@"%d",[self quickPlay:_inputTwo]];
    [self changeEnables];
}
- (IBAction)inputThreeChange:(id)sender {
    if([sender selectedSegmentIndex] == 1)
        _inputThree.text = [NSString stringWithFormat:@"%d",[self quickPlay:_inputThree]];
    [self changeEnables];
}
- (IBAction)inputFourChange:(id)sender {
    if([sender selectedSegmentIndex] == 1)
        _inputFour.text = [NSString stringWithFormat:@"%d",[self quickPlay:_inputFour]];
    [self changeEnables];
}
- (IBAction)inputFiveChange:(id)sender {
    if([sender selectedSegmentIndex] == 1)
        _inputFive.text = [NSString stringWithFormat:@"%d",[self quickPlay:_inputFive]];
    [self changeEnables];
}
- (IBAction)inputSixChange:(id)sender {
    if([sender selectedSegmentIndex] == 1)
        _inputSix.text = [NSString stringWithFormat:@"%d",[self quickPlay:_inputSix]];
    [self changeEnables];
}
-(int)randomGenerator:(unsigned int)max{
    int result;
    result = arc4random_uniform(max);
        if(result==0)
            result=1;
    return result;
}

-(int)quickPlay:(UITextField*)sender{
    unsigned int max = 0;
    if((_sgmGameSelector.selectedSegmentIndex==0) && ([sender tag] == 5))
        max = 18;
    else
        if (_sgmGameSelector.selectedSegmentIndex==0)
            max = 48;
            else
                max = 54;
        int fantasyNumber = [self randomGenerator:max];
        while([self checkForDuplicates: fantasyNumber andSender:sender]){
            fantasyNumber=[self randomGenerator:max];
        }
        return fantasyNumber;
}

-(BOOL)checkForDuplicates:(int)check andSender:(UITextField*)sender{
    
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
    
    if ((sender.tag == _inputOne.tag))
        if(check ==  (int)inputOneValue)
            return NO;
    if ((sender.tag == _inputTwo.tag))
        if(check ==  (int)inputTwoValue)
            return NO;
    if ((sender.tag == _inputThree.tag))
        if(check ==  (int)inputThreeValue)
            return NO;
    if ((sender.tag == _inputFour.tag))
        if(check ==  (int)inputFourValue)
            return NO;
    if ((sender.tag == _inputFive.tag))
        if(check ==  (int)inputFiveValue)
            return NO;
    if ((sender.tag == _inputSix.tag))
        if(check ==  (int)inputSixValue)
            return NO;
    
    if (check == (int)inputOneValue)
        return YES;
    if (check == (int)inputTwoValue)
        return YES;
    if (check == (int)inputThreeValue)
        return YES;
    if (check == (int)inputFourValue)
        return YES;
    if(!(_sgmGameSelector.selectedSegmentIndex==0))
        if (check == (int)inputFiveValue)
            return YES;
    if (check == (int)inputSixValue)
        return YES;
    
    return NO;
}

-(void)changeEnables
{
    if(_inputStateOne.selectedSegmentIndex == 1)
        _inputOne.enabled = NO;
    else
        _inputOne.enabled = YES;
    
    if(_inputStateTwo.selectedSegmentIndex == 1)
        _inputTwo.enabled = NO;
    else
        _inputTwo.enabled = YES;
    
    if(_inputStateThree.selectedSegmentIndex == 1)
        _inputThree.enabled = NO;
    else
        _inputThree.enabled = YES;
    
    if(_inputStateFour.selectedSegmentIndex == 1)
        _inputFour.enabled = NO;
    else
        _inputFour.enabled = YES;
    
    if(_inputStateFive.selectedSegmentIndex == 1)
        _inputFive.enabled = NO;
    else
        _inputFive.enabled = YES;
    
    if(_inputStateSix.selectedSegmentIndex == 1)
        _inputSix.enabled = NO;
    else
        _inputSix.enabled = YES;
    [self changeEnablecolor];
}
-(void)changeEnablecolor
{
    UIColor *active,*inactive;
    active = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];;
    inactive = [UIColor colorWithRed:0.97 green:0.97 blue:0.75 alpha:.5];
    
    if(_inputOne.enabled == NO)
        _inputOne.backgroundColor = inactive;
    else
        _inputOne.backgroundColor = active;
    
    if(_inputTwo.enabled == NO)
        _inputTwo.backgroundColor = inactive;
    else
        _inputTwo.backgroundColor = active;
    
    if(_inputThree.enabled == NO)
        _inputThree.backgroundColor = inactive;
    else
        _inputThree.backgroundColor = active;
    
    if(_inputFour.enabled == NO)
        _inputFour.backgroundColor = inactive;
    else
        _inputFour.backgroundColor = active;
    
    if(_inputFive.enabled == NO)
        _inputFive.backgroundColor = inactive;
    else
        _inputFive.backgroundColor = active;
    
    if(_inputSix.enabled == NO)
        _inputSix.backgroundColor = inactive;
    else
        _inputSix.backgroundColor = active;
}
-(void)resetValues
{
    _inputOne.text = @"";
    _inputTwo.text = @"";
    _inputThree.text = @"";
    _inputFour.text = @"";
    _inputFive.text = @"";
    _inputSix.text=@"";
    
    _inputStateOne.selectedSegmentIndex=0;
    _inputStateTwo.selectedSegmentIndex=0;
    _inputStateThree.selectedSegmentIndex=0;
    _inputStateFour.selectedSegmentIndex=0;
    _inputStateFive.selectedSegmentIndex=0;
    _inputStateSix.selectedSegmentIndex=0;

    [self changeEnables];
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
        }}
    
    if(_sgmGameSelector.selectedSegmentIndex == 1){
        if(!((inputFiveValue > 0) && (inputFiveValue <= max)))
        {
            _inputFive.text=@"";
            if(!(inputFiveValue==0))
                change = YES;
        }
        if(!((inputSixValue > 0) && (inputSixValue <= max)))
        {
            _inputSix.text=@"";
            if(!(inputSixValue==0))
                change = YES;
        }
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
}

@end
