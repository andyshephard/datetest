//
//  DateManager.h
//  DateTestObjC
//
//  Created by Andy Shephard on 15/05/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *kKeyISO8601Date;
extern NSString *kKeyDayName;
extern NSString *kKeyDifference;

@interface DateManager : NSObject
///@brief The current date.
@property (nonatomic, strong) NSDate *now;

///@brief The current date in String format, compliant to ISO8601.
@property (nonatomic, strong) NSString *today;

///@brief The singleton accessor.
+ (instancetype)sharedManager;

///@brief calculate various date values.
///@param date The selected date from the date picker.
///@return completionBlock containing NSDictionary with all data.
- (void)calculateValuesFromSelectedDate:(NSDate *)date
							 completion:(void (^)(NSDictionary *results))completionBlock;
@end
