//
//  TodayViewController.swift
//  DateTodayExt
//
//  Created by Andy Shephard on 15/05/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var selectedDateTitleLbl: UILabel!
	@IBOutlet weak var selectedDateValueLbl: UILabel!
	@IBOutlet weak var selectedDayTitleLbl: UILabel!
	@IBOutlet weak var selectedDayValueLbl: UILabel!
	@IBOutlet weak var todaysDateTitleLbl: UILabel!
	@IBOutlet weak var todaysDateValueLbl: UILabel!
	@IBOutlet weak var daysFromTodayTitleLbl: UILabel!
	@IBOutlet weak var daysFromTodayValueLbl: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
		
		if #available(iOSApplicationExtension 10.0, *) {
			self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
		}
		
		todaysDateValueLbl.text = DateManager.sharedInstance.today
		updateValuesOnWidget()
    }
	
	func updateValuesOnWidget() {
		
		// DateManager will calculate the differences and return the values async (complBlock).
		DateManager.sharedInstance.calculateValuesFromSelectedDate(datePicker.date) { (results) in
			
			// Then simply populate the labels with their respective values.
			selectedDateValueLbl.text = results[kKeyISO8601Date]
			selectedDayValueLbl.text = results[kKeyDayName]
			daysFromTodayValueLbl.text = results[kKeyDifference]
		}
	}
	
	//MARK: Date Picker
	@IBAction func datePickerValueDidChange(_ sender: Any) {
		// When the date picker value changes, call updateValuesOnWidget()
		updateValuesOnWidget()
	}
	
	//MARK: Widget Functions
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
	
	@available(iOS 10.0, *)
	@available(iOSApplicationExtension 10.0, *)
	func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
		if activeDisplayMode == .expanded {
			self.preferredContentSize = CGSize(width: self.view.frame.size.width, height: 350.0)
		}else if activeDisplayMode == .compact{
			self.preferredContentSize = CGSize(width: maxSize.width, height: 110)
		}
	}
}
