//
//  DailyViewController.m
//  TP-LottoGame
//
//  Created by Langston Duncanson on 10/12/17.
//  Copyright © 2017 Langston Duncanson. All rights reserved.
//

#import "DailyViewController.h"

@interface DailyViewController ()
{
    int inputLength;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmGameSelector;
@property (weak, nonatomic) IBOutlet UITextField *inputOne;
@property (weak, nonatomic) IBOutlet UITextField *inputTwo;
@property (weak, nonatomic) IBOutlet UITextField *inputThree;
@property (weak, nonatomic) IBOutlet UITextField *inputFour;
@property (weak, nonatomic) IBOutlet UITextField *inputFive;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inputOneState;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inputTwoState;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inputThreeState;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inputFourState;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inputFiveState;
@property (weak, nonatomic) IBOutlet UIButton *sumitBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmDrawings;
@property (weak, nonatomic) IBOutlet UIButton *winnerBtn;
@property (weak, nonatomic) IBOutlet UIImageView *gameImageView;

@end

@implementation DailyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideInputs];
    [self hideInputStateChangers];
    [self updateVisuals];
    _inputOne.delegate = self;
    _inputTwo.delegate = self;
    _inputThree.delegate = self;
    _inputFour.delegate = self;
    _inputFive.delegate = self;
    _inputOne.tag = 1;
    _inputTwo.tag = 2;
    _inputThree.tag = 3;
    _inputFour.tag = 4;
    _inputFive.tag = 5;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if(_sgmGameSelector.selectedSegmentIndex==4)
        [self validateInputBoxes];
    return !([newString length] > inputLength) ;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)sgmGameChange:(id)sender {
    [self resetValues];
    [self hideInputs];
    [self hideInputStateChangers];
    [self changeEnables];
    [self toggleDrawingsSgm];
    [self updateVisuals];
}
-(void)toggleDrawingsSgm{
    if(_sgmGameSelector.selectedSegmentIndex == 4)
        _sgmDrawings.hidden = YES;
    else
        _sgmDrawings.hidden = NO;

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
-(void)updateVisuals{
    NSString * image;
    UIColor * color;
    switch (_sgmGameSelector.selectedSegmentIndex) {
        case 0:
            image= [NSString stringWithFormat:@"p2"];
            color = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1];
            break;
        case 1:
            image= [NSString stringWithFormat:@"p3"];
            color = [UIColor colorWithRed:1.0 green:0.64 blue:0.0 alpha:1];            break;
        case 2:
            image= [NSString stringWithFormat:@"p4"];
            color = [UIColor colorWithRed:0.0 green:1.0 blue:0.54 alpha:1];
            break;
        case 3:
            image= [NSString stringWithFormat:@"p5"];
            color = [UIColor colorWithRed:0.0 green:0.74 blue:1.0 alpha:1];
            break;
        case 4:
            image= [NSString stringWithFormat:@"fan5"];
            color = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1];
            break;
    }
    image = [NSString stringWithFormat:@"%@.jpg",image];
    self.gameImageView.image = [UIImage imageNamed:image];
    self.view.backgroundColor = color;
}
-(void)hideInputStateChangers{
    if(_inputOne.hidden == YES)
        [_inputOneState setHidden:YES];
    else
        [_inputOneState setHidden:NO];
  
    if(_inputTwo.hidden == YES)
        [_inputTwoState setHidden:YES];
    else
        [_inputTwoState setHidden:NO];
    
    if(_inputThree.hidden == YES)
        [_inputThreeState setHidden:YES];
    else
        [_inputThreeState setHidden:NO];
  
    if(_inputFour.hidden == YES)
        [_inputFourState setHidden:YES];
    else
        [_inputFourState setHidden:NO];
  
    if(_inputFive.hidden == YES)
        [_inputFiveState setHidden:YES];
    else
        [_inputFiveState setHidden:NO];
}

-(void)hideInputs
{
    switch (self.sgmGameSelector.selectedSegmentIndex) {
        case 0:
            _inputFive.enabled = NO;
            [_inputFive setHidden:YES];
            _inputFour.enabled = NO;
            [_inputFour setHidden:YES];
            _inputThree.enabled = NO;
            [_inputThree setHidden:YES];
            _inputTwo.enabled = YES;
            [_inputTwo setHidden:NO];
            _inputOne.enabled = YES;
            [_inputOne setHidden:NO];
            break;
        case 1:
            _inputFive.enabled = NO;
            [_inputFive setHidden:YES];
            _inputFour.enabled = NO;
            [_inputFour setHidden:YES];
            _inputThree.enabled = YES;
            [_inputThree setHidden:NO];
            _inputTwo.enabled = YES;
            [_inputTwo setHidden:NO];
            _inputOne.enabled = YES;
            [_inputOne setHidden:NO];
            break;
        case 2:
            _inputFive.enabled = NO;
            [_inputFive setHidden:YES];
            _inputFour.enabled = YES;
            [_inputFour setHidden:NO];
            _inputThree.enabled = YES;
            [_inputThree setHidden:NO];
            _inputTwo.enabled = YES;
            [_inputTwo setHidden:NO];
            _inputOne.enabled = YES;
            [_inputOne setHidden:NO];
            break;
        case 3:
            _inputFive.enabled = YES;
            [_inputFive setHidden:NO];
            _inputFour.enabled = YES;
            [_inputFour setHidden:NO];
            _inputThree.enabled = YES;
            [_inputThree setHidden:NO];
            _inputTwo.enabled = YES;
            [_inputTwo setHidden:NO];
            _inputOne.enabled = YES;
            [_inputOne setHidden:NO];
            break;
        case 4:
            _inputFive.enabled = YES;
            [_inputFive setHidden:NO];
            _inputFour.enabled = YES;
            [_inputFour setHidden:NO];
            _inputThree.enabled = YES;
            [_inputThree setHidden:NO];
            _inputTwo.enabled = YES;
            [_inputTwo setHidden:NO];
            _inputOne.enabled = YES;
            [_inputOne setHidden:NO];
            break;
    }
    if ([_sgmGameSelector selectedSegmentIndex] == 4)
    {
            inputLength = 2;
    } else {
            inputLength = 1;
    }
}

-(void)changeEnables
{
    if(_inputOneState.selectedSegmentIndex == 1)
        _inputOne.enabled = NO;
    else
        _inputOne.enabled = YES;
    
    if(_inputTwoState.selectedSegmentIndex == 1)
        _inputTwo.enabled = NO;
    else
        _inputTwo.enabled = YES;
    
    if(_inputThreeState.selectedSegmentIndex == 1)
        _inputThree.enabled = NO;
    else
        _inputThree.enabled = YES;
    
    if(_inputFourState.selectedSegmentIndex == 1)
        _inputFour.enabled = NO;
    else
        _inputFour.enabled = YES;
    
    if(_inputFiveState.selectedSegmentIndex == 1)
        _inputFive.enabled = NO;
    else
        _inputFive.enabled = YES;
    [self changeEnablecolor];
}
-(void)changeEnablecolor
{
    UIColor *active,*inactive;
    active = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];;
    inactive = [UIColor colorWithRed:0.97 green:0.97 blue:0.75 alpha:.5];
    
    if(_inputOne.enabled == NO)
        _inputOne.backgroundColor= inactive;
    else
        _inputOne.backgroundColor= active;
    
    if(_inputTwo.enabled == NO)
        _inputTwo.backgroundColor= inactive;
    else
        _inputTwo.backgroundColor= active;
    
    if(_inputThree.enabled == NO)
        _inputThree.backgroundColor= inactive;
    else
        _inputThree.backgroundColor= active;
    
    if(_inputFour.enabled == NO)
        _inputFour.backgroundColor= inactive;
    else
        _inputFour.backgroundColor= active;
    
    if(_inputFive.enabled == NO)
        _inputFive.backgroundColor= inactive;
    else
        _inputFive.backgroundColor= active;
}
-(void)resetValues
{
    _inputOne.text = @"";
    _inputTwo.text = @"";
    _inputThree.text = @"";
    _inputFour.text = @"";
    _inputFive.text = @"";
    
    _inputOneState.selectedSegmentIndex=0;
    _inputTwoState.selectedSegmentIndex=0;
    _inputThreeState.selectedSegmentIndex=0;
    _inputFourState.selectedSegmentIndex=0;
    _inputFiveState.selectedSegmentIndex=0;
    
}
-(int)randomGenerator:(unsigned int)max{
    int result;
    result = arc4random_uniform(max);
    if(max==37)
        if(result==0)
            result=1;
    return result;
}

-(int)quickPlay:(UITextField*)sender{
    unsigned int max;
    if ([_sgmGameSelector selectedSegmentIndex] == 4)
    {
        max = 37;
    } else {
        max = 10;
    }
    if(max == 37){
        
    
        int fantasyNumber = [self randomGenerator:max];
        while([self checkForDuplicates: fantasyNumber andSender:sender]){
            fantasyNumber=[self randomGenerator:max];
        }
        return fantasyNumber;
    }
    
        return [self randomGenerator:max];
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
    
    if (check == (int)inputOneValue)
        return YES;
    if (check == (int)inputTwoValue)
        return YES;
    if (check == (int)inputThreeValue)
        return YES;
    if (check == (int)inputFourValue)
        return YES;
    if (check == (int)inputFiveValue)
        return YES;
    
    return NO;
}
- (IBAction)sumbitAction:(id)sender {
    if(_sgmGameSelector.selectedSegmentIndex == 0)
        if(![_inputOne.text  isEqual: @""])
            if(![_inputTwo.text  isEqual: @""]){
                //[self showMessage:@"Submission Accepted" andTitle:@"Submission Status"];
                [self showMessage:[self buildSubmissionString] andTitle:@"Entry State"];
                [self processSubmission];
            }
    if(_sgmGameSelector.selectedSegmentIndex == 1)
        if(![_inputOne.text  isEqual: @""])
            if(![_inputTwo.text  isEqual: @""])
                if(![_inputThree.text  isEqual: @""]){
                //[self showMessage:@"Submission Accepted" andTitle:@"Submission Status"];
                    [self showMessage:[self buildSubmissionString] andTitle:@"Entry State"];
                [self processSubmission];
                }
    if(_sgmGameSelector.selectedSegmentIndex == 2)
        if(![_inputOne.text  isEqual: @""])
            if(![_inputTwo.text  isEqual: @""])
                if(![_inputThree.text  isEqual: @""])
                    if(![_inputFour.text  isEqual: @""]){
                        //[self showMessage:@"Submission Accepted" andTitle:@"Submission Status"];
                        [self showMessage:[self buildSubmissionString] andTitle:@"Entry State"];
                    [self processSubmission];
                    }
    if(_sgmGameSelector.selectedSegmentIndex == 3)
        if(![_inputOne.text  isEqual: @""])
            if(![_inputTwo.text  isEqual: @""])
                if(![_inputThree.text  isEqual: @""])
                    if(![_inputFour.text  isEqual: @""])
                        if(![_inputFive.text  isEqual: @""]){
                        //[self showMessage:@"Submission Accepted" andTitle:@"Submission Status"];
                        [self showMessage:[self buildSubmissionString] andTitle:@"Entry State"];
                        [self processSubmission];
                        }
    if(_sgmGameSelector.selectedSegmentIndex == 4)
        if(![_inputOne.text  isEqual: @""])
            if(![_inputTwo.text  isEqual: @""])
                if(![_inputThree.text  isEqual: @""])
                    if(![_inputFour.text  isEqual: @""])
                        if(![_inputFive.text  isEqual: @""]){
                            //[self showMessage:@"Submission Accepted" andTitle:@"Submission Status"];
                            [self showMessage:[self buildSubmissionString] andTitle:@"Entry State"];
                        [self processSubmission];
                        }
}
-(void)processSubmission{
    [self enableControls:NO];
    _winnerBtn.enabled = YES;
}
- (IBAction)winnerCheck:(id)sender {
    NSMutableArray * choicesArray = [self generateArray];
    NSMutableArray * winningArray = [self generateWinningNumbers];
    //SLog(@"choices: %@,\n winning: %@",choicesArray,winningArray);
    if (_sgmGameSelector.selectedSegmentIndex == 4){
        choicesArray = [self sortArray:choicesArray];
        winningArray = [self sortArray:winningArray];
        //NSLog(@"choices: %@,\n winning: %@",choicesArray,winningArray);
    }
    NSString *choiceDesc = [choicesArray componentsJoinedByString:@","];
    NSString *winningDesc = [winningArray componentsJoinedByString:@","];
    int matchCount;
    if(_sgmGameSelector.selectedSegmentIndex == 4)
        matchCount = [self checkWinnings:choicesArray andWinning:winningArray exact:NO];
    else
        matchCount = [self checkWinnings:choicesArray andWinning:winningArray exact:YES];
    NSMutableString *winningMessage = [NSMutableString stringWithFormat:@"not"];
    if(_sgmGameSelector.selectedSegmentIndex == 0){
        if(matchCount > 0)
            winningMessage = [NSMutableString stringWithFormat:@"a"];
    }else{
        if(matchCount > 1)
            winningMessage = [NSMutableString stringWithFormat:@"a"];
    }
    
    NSString * message = [NSString stringWithFormat:@"Your choice was: %@\n Winning Numbers are: %@ \n You have %d matches. \n You are %@ winner",choiceDesc,winningDesc,matchCount,winningMessage];
    [self showMessage:message andTitle:@"Winning Status"];
    [self enableControls:YES];
    _winnerBtn.enabled = NO;
}
-(int)checkWinnings:(NSMutableArray*)choices andWinning:(NSMutableArray*) winning exact:(BOOL)exactFlag{
    int count = 0;
    if(exactFlag == YES){
    for (int i = 0; (!(i == [choices count])); i++){
       NSLog(@"%@ vs %@", [choices objectAtIndex:i], [winning objectAtIndex:i]);
        if([choices objectAtIndex:i] == [winning objectAtIndex:i]){
            NSLog(@"Match Found");
            count++;
        }
    }}else{
        for (int i = 0; (!(i == [choices count])); i++){
            for (int j = 0; (!(j == [winning count])); j++){
                NSLog(@"%@ vs %@", [choices objectAtIndex:i], [winning objectAtIndex:j]);
                if([choices objectAtIndex:i] == [winning objectAtIndex:j]){
                    NSLog(@"Match Found");
                    count++;
                }
                
        }
    }
    
}
    return count;
}

-(NSMutableArray*)generateWinningNumbers{
    int index = (int)_sgmGameSelector.selectedSegmentIndex;
    NSMutableArray * winningArray = [[NSMutableArray alloc] init];
    if(index == 4){
        while(!([winningArray count] == 5)){
        NSInteger random = arc4random_uniform(36) + 1;
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
    }else{
        
        while(!([winningArray count] == index + 2)){
        NSInteger random = arc4random_uniform(10);
            [winningArray addObject:[NSNumber numberWithInt:(int)random]];
        }
    }
    return winningArray;
    
}
-(NSMutableArray*)sortArray:(NSMutableArray*)sortArray{
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [sortArray sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    return sortArray;
}
-(void)enableControls:(BOOL)state{
    _sgmGameSelector.enabled = state;
    _inputOne.enabled = state;
    _inputOneState.enabled = state;
    _inputTwo.enabled = state;
    _inputTwoState.enabled = state;
    _inputThree.enabled = state;
    _inputThreeState.enabled = state;
    _inputFour.enabled = state;
    _inputFourState.enabled = state;
    _inputFive.enabled = state;
    _inputFiveState.enabled = state;
    _sgmDrawings.enabled = state;
    _sumitBtn.enabled = state;
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
    int index = (int)_sgmGameSelector.selectedSegmentIndex;
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [result addObject:[NSNumber numberWithInt:(int)inputOneValue]];
    [result addObject:[NSNumber numberWithInt:(int)inputTwoValue]];
    if(index > 0)
    [result addObject:[NSNumber numberWithInt:(int)inputThreeValue]];
    if(index > 1)
    [result addObject:[NSNumber numberWithInt:(int)inputFourValue]];
    if(index>2)
    [result addObject:[NSNumber numberWithInt:(int)inputFiveValue]];
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
    
    int amount;
    int index = (int)_sgmGameSelector.selectedSegmentIndex;
    amount = [self calculateAmount:index];
    if(index == 0)
    {
        result= [NSString stringWithFormat:@"Your selected numbers are: %d, %d\n Amount due: $%d.00", (int)inputOneValue, (int)inputTwoValue, amount];
    }
    
    if(index== 1)
    {
        result= [NSString stringWithFormat:@"Your selected numbers are: %d, %d, %d\n Amount due: $%d.00", (int)inputOneValue, (int)inputTwoValue,(int)inputThreeValue, amount];
    }
    
    if(index == 2)
    {
        result= [NSString stringWithFormat:@"Your selected numbers are: %d, %d, %d, %d\n Amount due: $%d.00", (int)inputOneValue, (int)inputTwoValue, (int)inputThreeValue,(int)inputFourValue, amount];
    }
    
    if(index == 3)
    {
        result= [NSString stringWithFormat:@"Your selected numbers are: %d, %d, %d, %d, %d\n Amount due: $%d.00", (int)inputOneValue, (int)inputTwoValue, (int)inputThreeValue, (int) inputFourValue, (int)inputFiveValue, amount];
    }
    
    if(index == 4)
    {
                result= [NSString stringWithFormat:@"Your selected numbers are: %d, %d, %d, %d, %d\n Amount due: $%d.00", (int)inputOneValue, (int)inputTwoValue, (int)inputThreeValue, (int) inputFourValue, (int)inputFiveValue, amount];
    }
    return result;
}
-(int)calculateAmount:(int)gameType{
    switch (gameType) {
        case 0:
        case 1:
        case 2:
        case 3:
            return [self checkGameDrawings];
            break;
        case 4:
            return 1;
            break;
        default:
            return 1;
            break;
    }
}

-(int)checkGameDrawings{
    if(_sgmDrawings.selectedSegmentIndex==2)
        return 2;
    else
        return 1;
}
-(void)validateInputBoxes{
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
    BOOL change = NO;
    
    if(!((inputOneValue > 0) && (inputOneValue <= 36)))
    {
        _inputOne.text=@"";
        if(!(inputOneValue==0))
           change = YES;
    }
    if(!((inputTwoValue > 0) && (inputTwoValue <= 36)))
    {
        _inputTwo.text=@"";
        if(!(inputTwoValue==0))
            change = YES;
    }
    if(!((inputThreeValue > 0) && (inputThreeValue <= 36)))
    {
        _inputThree.text=@"";
        if(!(inputThreeValue==0))
            change = YES;
    }
    if(!((inputFourValue > 0) && (inputFourValue <= 36)))
    {
        _inputFour.text=@"";
        if(!(inputFourValue==0))
            change = YES;
    }
    if(!((inputFiveValue > 0) && (inputFiveValue <= 36)))
    {
        _inputFive.text=@"";
        if(!(inputFiveValue==0))
            change = YES;
    }
    if(change==YES)
        [self showMessage:@"Fantasy 5 valid numbers are between 1 and 36. Please reenter your choices." andTitle:@"Invalid Entry"];
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
