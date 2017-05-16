//
//  ViewController.swift
//  DateTestSwift
//
//  Created by Andy Shephard on 15/05/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var selectedDateTitleLbl: UILabel!
	@IBOutlet weak var selectedDateValueLbl: UILabel!
	@IBOutlet weak var selectedDayTitleLbl: UILabel!
	@IBOutlet weak var selectedDayValueLbl: UILabel!
	@IBOutlet weak var todaysDateTitleLbl: UILabel!
	@IBOutlet weak var todaysDateValueLbl: UILabel!
	@IBOutlet weak var daysFromSelectedDateTitleLbl: UILabel!
	@IBOutlet weak var daysFromSelectedDateValueLbl: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Set |todaysDateValueLbl| based on the |today| value in |DateManager|.
		todaysDateValueLbl.text = DateManager.sharedInstance.today
		
		// Update the values in view also upon launch.
		updateValuesInView()
	}
	
	func updateValuesInView() {
		
		// DateManager will calculate the differences and return the values async (complBlock).
		DateManager.sharedInstance.calculateValuesFromSelectedDate(datePicker.date) { (results) in
			
			// Then simply populate the labels with their respective values.
			selectedDateValueLbl.text = results[kKeyISO8601Date]
			selectedDayValueLbl.text = results[kKeyDayName]
			daysFromSelectedDateValueLbl.text = results[kKeyDifference]
		}
	}
	
	@IBAction func datePickerValueDidChange(_ sender: Any) {
		// When the date picker value changes, call updateValuesInView()
		updateValuesInView()
	}
}

