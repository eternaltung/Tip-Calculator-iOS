//
//  SettingViewController.m
//  TipCalculator
//
//  Created by Shih-Ming Tung on 6/6/15.
//  Copyright (c) 2015 Shih-Ming. All rights reserved.
//

#import "SettingViewController.h"
#import <UIKit/UIKit.h>

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *TipPicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ThemeSegmented;

@property NSArray *tiparray;
@property NSArray *themecolors;
@property NSUserDefaults *defaults;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"setting";
    self.tiparray = @[@"0.05",@"0.1",@"0.15"];
    self.themecolors = @[@"Grey",@"White",@"Pink"];
    self.TipPicker.delegate = self;
    self.TipPicker.dataSource = self;
    self.defaults = [NSUserDefaults standardUserDefaults];
    [self RestoreDefaultTip];
}

- (void) RestoreDefaultTip{
    self.defaults = [NSUserDefaults standardUserDefaults];
    if ([self.defaults objectForKey:@"Tip"] != nil){
        [self.TipPicker selectRow:[self.tiparray indexOfObject:[self.defaults objectForKey:@"Tip"]] inComponent:0 animated:YES];
    }
    if ([self.defaults objectForKey:@"Theme"] != nil){
        self.ThemeSegmented.selectedSegmentIndex = [self.themecolors indexOfObject:[self.defaults objectForKey:@"Theme"]];
        [self ChangeColor];
    }
}

- (void)ChangeColor {
    switch (self.ThemeSegmented.selectedSegmentIndex) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.tiparray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    int text = [self.tiparray[row] floatValue] * 100;
    return [NSString stringWithFormat:@"%d%%",text];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.defaults setObject:self.tiparray[row] forKey:@"Tip"];
    [self.defaults synchronize];
}

- (IBAction)ChangeBGTheme:(UISegmentedControl *)sender {
    //sender.selectedSegmentIndex
    [self.defaults setObject:self.themecolors[sender.selectedSegmentIndex] forKey:@"Theme"];
    [self.defaults synchronize];
    [self ChangeColor];
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
