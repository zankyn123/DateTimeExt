//
//  DateFormatter.swift
//  FnB
//

import Foundation

public extension DateFormatter {
    // MARK: - Instance
    static var dateAndTimeFormatInstance: DateFormatter {
        if UserDefaultsUtils.isUsingMultiTimezone,
           let timezone = TimeZone.currentBranchTimeZone {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateTimeFormat.ddMMyyyy_HHmm.rawValue
            dateFormatter.timeZone = timezone
            return dateFormatter
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateTimeFormat.ddMMyyyy_HHmm.rawValue
            return dateFormatter
        }
    }
    
    static var dateFormatInstance: DateFormatter {
        if UserDefaultsUtils.isUsingMultiTimezone,
           let timezone = TimeZone.currentBranchTimeZone {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateTimeFormat.ddMMyyyy.rawValue
            dateFormatter.timeZone = timezone
            return dateFormatter
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateTimeFormat.ddMMyyyy.rawValue
            return dateFormatter
        }
    }
    
    static var timeFormatInstance: DateFormatter {
        if UserDefaultsUtils.isUsingMultiTimezone,
           let timezone = TimeZone.currentBranchTimeZone {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateTimeFormat.HHmmss.rawValue
            dateFormatter.timeZone = timezone
            return dateFormatter
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateTimeFormat.HHmmss.rawValue
            return dateFormatter
        }
    }
    
    static var itcFullFormatInstance: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateTimeFormat.ictFull.rawValue
        return dateFormatter
    }
}
