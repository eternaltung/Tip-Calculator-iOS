//
//  ViewController.m
//  TipCalculator
//
//  Created by Shih-Ming Tung on 6/6/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "ViewController.h"
#import "SettingViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *BillTextField;
@property (weak, nonatomic) IBOutlet UILabel *TipLabel;
@property (weak, nonatomic) IBOutlet UILabel *TotalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *TipSegmented;
@property NSUserDefaults *defaults;
@property NSArray *tiparray;

- (IBAction)OnTap:(UITapGestureRecognizer *)sender;
//- (void) UpdateValues;
//- (void) GoToSetting;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [self RestoreDefaultTip];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tip Calculator";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"setting" style:UIBarButtonItemStylePlain target:self action:@selector(GoToSetting)];
    self.tiparray = @[@"0.05",@"0.1",@"0.15"];
    //self.view.tintColor = [UIColor greenColor];
}

- (void) RestoreDefaultTip{
    self.defaults = [NSUserDefaults standardUserDefaults];
    if ([self.defaults objectForKey:@"Tip"] != nil){
        self.TipSegmented.selectedSegmentIndex = [self.tiparray indexOfObject:[self.defaults objectForKey:@"Tip"]];
    }
    if ([self.defaults objectForKey:@"Theme"] != nil){
        NSArray *colors = @[@"Grey",@"White",@"Pink"];
        switch ([colors indexOfObject:[self.defaults objectForKey:@"Theme"]]) {
            case 0:
                self.view.backgroundColor = [UIColor grayColor];
                break;
            case 2:
                self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.667 blue:0.800 alpha:1.0];
                break;
            default:
                self.view.backgroundColor = [UIColor whiteColor];
                break;
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)OnTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self UpdateValues];
}

- (void)UpdateValues{
    float billamount = [self.BillTextField.text floatValue];
    float tip = billamount * [self.tiparray[self.TipSegmented.selectedSegmentIndex] floatValue];
    
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setNumberStyle:NSNumberFormatterCurrencyStyle];
    [format setLocale:[NSLocale currentLocale]];
    [format setAlwaysShowsDecimalSeparator:YES];
    self.TotalLabel.text = [format stringFromNumber:[NSNumber numberWithFloat:(tip+billamount)]];
    self.TipLabel.text = [format stringFromNumber:[NSNumber numberWithFloat:tip]];
}

-(void) GoToSetting{
    [self.navigationController pushViewController:[[SettingViewController alloc] init] animated:YES];
}
@end
