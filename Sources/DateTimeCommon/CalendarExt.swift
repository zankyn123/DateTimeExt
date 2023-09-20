//
//  CalendarExt.swift
//  FnB
//
//  Created by Hungxt on 18/09/2023.
//  Copyright © 2023 Citigo. All rights reserved.
//

import Foundation

public extension Calendar {
    static var currentCalendarSetting: Calendar {
        var calendar = Calendar.current
        if UserDefaultsUtils.isUsingMultiTimezone,
           let timezone = TimeZone.currentBranchTimeZone {
            calendar.timeZone = timezone
            return calendar
        } else {
            return calendar
        }
    }
    
    static var timezoneVNCalendarSetting: Calendar {
        var calendar = Calendar.current
        if UserDefaultsUtils.isUsingMultiTimezone,
           let timezone = TimeZone.vn {
            calendar.timeZone = timezone
            return calendar
        } else {
            return calendar
        }
    }
}
