//
//  DateManager.m
//  DateTestObjC
//
//  Created by Andy Shephard on 15/05/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

#import "DateManager.h"

static NSInteger kOneDayInSeconds = 86400;
static NSString *kISO8601DateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
static NSString *kDayFormat = @"EEEE";

NSString *kKeyISO8601Date = @"ISO8601Date";
NSString *kKeyDayName = @"DayName";
NSString *kKeyDifference = @"Difference";

@interface DateManager()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@end

@implementation DateManager

+ (instancetype)sharedManager {
	static DateManager *sharedMyManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedMyManager = [[self alloc] init];
	});
	return sharedMyManager;
}

- (id)init {
	if (self = [super init]) {
		// Set |dateFormatter| to be ISO8601 compliant.
		_dateFormatter = [[NSDateFormatter alloc] init];
		NSLocale *enUSPosixLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
		_dateFormatter.locale = enUSPosixLocale;
		_dateFormatter.dateFormat = kISO8601DateFormat;
		
		// Set |dayFormatter| to return the Day Name.
		_dayFormatter = [[NSDateFormatter alloc] init];
		_dayFormatter.dateFormat = kDayFormat;
		
		// Set |today| as today's date (right now).
		_now = [NSDate date];
		_today = [_dateFormatter stringFromDate:_now];
	}
	return self;
}

- (void)calculateValuesFromSelectedDate:(NSDate *)date
							 completion:(void (^)(NSDictionary *results)) completionBlock {
	
	// 1. Selected date in NSString.
	NSString *iso8601String = [_dateFormatter stringFromDate:date];
	
	// 2. Day name in NSString.
	NSString *dayNameString = [_dayFormatter stringFromDate:date];
	
	// 3. Difference from selected date to today's date in NSString.
	NSString *difference = [self daysBetweenSelectedDateAndNow:date];
	
	// Add all values into a NSDictionary object and return them via the
	// completion handler.
	NSDictionary *resultsDict = [[NSDictionary alloc] initWithObjectsAndKeys:iso8601String, kKeyISO8601Date, dayNameString, kKeyDayName, difference, kKeyDifference, nil];
	
	completionBlock(resultsDict);
}

- (NSString *)daysBetweenSelectedDateAndNow:(NSDate *)date {
	
	// Get timestamp difference between |now| and
	// the selected date.
	NSTimeInterval selectedDateInSeconds = [date timeIntervalSinceDate:_now];
	
	// Calculate difference in days (integer).
	double timeIntervalInteger = selectedDateInSeconds;
	NSInteger difference = [self roundToDays:timeIntervalInteger] / kOneDayInSeconds;
	
	// Return the NSInteger value as an NSString.
	return [NSString stringWithFormat:@"%li", (long)difference];
}

- (NSInteger)roundToDays:(double)x {
	
	return kOneDayInSeconds * floor((x / kOneDayInSeconds) + 0.5);
	
//	return kOneDayInSeconds * floor((x / kOneDayInSeconds));
}

@end
