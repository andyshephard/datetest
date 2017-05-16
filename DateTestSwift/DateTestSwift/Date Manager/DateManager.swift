//
//  DateManager.swift
//  DateTestSwift
//
//  Created by Andy Shephard on 15/05/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import Foundation

let kOneDayInSeconds = 86400

let kISO8601DateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
let kDayFormat = "EEEE"

let kKeyISO8601Date = "ISO8601Date"
let kKeyDayName = "DayName"
let kKeyDifference = "Difference"

public class DateManager {
	
	let dateFormatter: DateFormatter
	let dayFormatter: DateFormatter
	
	let now: Date
	let today: String
	
	static let sharedInstance = DateManager()
	
	private init() {
		// Set |dateFormatter| to be ISO8601 compliant.
		dateFormatter = DateFormatter.init()
		let enUSPosixLocale = NSLocale(localeIdentifier: "en_US_POSIX")
		dateFormatter.locale = enUSPosixLocale as Locale!
		dateFormatter.dateFormat = kISO8601DateFormat
		
		// Set |dayFormatter| to return the Day Name.
		dayFormatter = DateFormatter.init()
		dayFormatter.dateFormat = kDayFormat
		
		// Set |today| as today's date (right now).
		now = Date.init()
		today = dateFormatter.string(from: now)
	}
	
	func calculateValuesFromSelectedDate(_ date: Date, completion: (_ result: [String:String]) -> Void) {
	
		// 1. Selected date in String.
		let iso8601String: String = dateFormatter.string(from: date)
		
		// 2. Day name in String.
		let dayNameString: String = dayFormatter.string(from: date)
		
		// 3. Difference from selected date to today's date in String.
		let difference: String = daysBetweenSelectedDateAndNow(date)
		
		// Add all values into a Dictionary object and return them via the
		// completion handler.
		let resultsDict:[String:String] = [kKeyISO8601Date:iso8601String, kKeyDayName:dayNameString, kKeyDifference:difference]
		
		completion(resultsDict)
	}
	
	func daysBetweenSelectedDateAndNow(_ date: Date) -> String {
		
		// Get timestamp difference between |now| and
		// the selected date.
		let selectedDateInSeconds: TimeInterval = date.timeIntervalSince(now)
		
		// Calculate difference in days (integer).
		let timeIntervalInteger: Double = Double(selectedDateInSeconds)
		let difference: Int = roundToDays(x: timeIntervalInteger) / kOneDayInSeconds
		
		// Return the Int value as a String.
		return String(difference)
	}
	
	func roundToDays(x : Double) -> Int {
		return kOneDayInSeconds * Int(round(x / Double(kOneDayInSeconds)))
	}

}

extension Double {
	func roundToDays() -> Int{
		return 86400 * Int(Darwin.round(self / 86400.0))
	}
}
