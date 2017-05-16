//
//  ViewController.m
//  DateTestObjC
//
//  Created by Andy Shephard on 15/05/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

#import "ViewControllerObjC.h"
#import "DateManager.h"

@interface ViewControllerObjC ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *selectedDateTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectedDateValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectedDayTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectedDayValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *todaysDateTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *todaysDateValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *daysFromSelectedDateTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *daysFromSelectedDateValueLbl;
@end

@implementation ViewControllerObjC

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Set |todaysDateValueLbl| based on the |today| value in |DateManager|.
	_todaysDateValueLbl.text = [[DateManager sharedManager] today];
	
	// Update the values in view also upon launch.
	[self updateValuesInView];
}

- (void)updateValuesInView {
	
	// DateManager will calculate the differences and return the values async (complBlock).
	[[DateManager sharedManager] calculateValuesFromSelectedDate:_datePicker.date completion:^(NSDictionary *results) {
		
		// Then simply populate the labels with their respective values.
		_selectedDateValueLbl.text = results[kKeyISO8601Date];
		_selectedDayValueLbl.text = results[kKeyDayName];
		_daysFromSelectedDateValueLbl.text = results[kKeyDifference];
	}];
}

- (IBAction)datePickerValueDidChange:(id)sender {
	// When the date picker value changes, call [self updateValuesInView]
	[self updateValuesInView];
}

@end
