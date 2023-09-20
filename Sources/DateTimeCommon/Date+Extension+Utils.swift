//
//  DateHelpers.swift
//  FnB
//

import Foundation
// MARK: - Extensions
public extension Date {
    struct CalendarHolder {
        static var calendar: Calendar = .currentCalendarSetting
    }
    
    var calendar: Calendar {
        get {
            return CalendarHolder.calendar
        }
        set {
            CalendarHolder.calendar = newValue
        }
    }
    
    /// SwifterSwift: Day name format.
    ///
    /// - threeLetters: 3 letter day abbreviation of day name.
    /// - oneLetter: 1 letter day abbreviation of day name.
    /// - full: Full day name.
    enum DayNameStyle {
        case threeLetters
        case oneLetter
        case full
    }
    
    /// SwifterSwift: Month name format.
    ///
    /// - threeLetters: 3 letter month abbreviation of month name.
    /// - oneLetter: 1 letter month abbreviation of month name.
    /// - full: Full month name.
    enum MonthNameStyle {
        case threeLetters
        case oneLetter
        case full
    }
    
    // MARK: - Init
    /// SwifterSwift: Create date object from ISO8601 string.
    ///
    ///     let date = Date(iso8601String: "2017-01-12T16:48:00.959Z") // "Jan 12, 2017, 7:48 PM"
    ///
    /// - Parameter iso8601String: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSSZ).
    init?(iso8601String: String) {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        
        if UserDefaultsUtils.isUsingMultiTimezone {
            if let date = iso8601String.toDate(withFormat: .yyyyMMdd_T_HHmmssSSSXXX,
                                               timeZone: TimeZone.currentBranchTimeZone) {
                self = date
            } else if let date = iso8601String.toDate(withFormat: .yyyyMMdd_T_HHmmssZ,
                                                      timeZone: TimeZone.currentBranchTimeZone) {
                self = date
            } else {
                return nil
            }
        } else {
            if let date = iso8601String.toDate(withFormat: .yyyyMMdd_T_HHmmssSSSXXX,
                                               timeZone: TimeZone(secondsFromGMT: 0)!) {
                self = date
            } else if let date = iso8601String.toDate(withFormat: .yyyyMMdd_T_HHmmssZ,
                                                      timeZone: TimeZone(secondsFromGMT: 0)!) {
                self = date
            } else {
                return nil
            }
        }
    }
    
    /// SwifterSwift: Create new date object from UNIX timestamp.
    ///
    ///     let date = Date(unixTimestamp: 1484239783.922743) // "Jan 12, 2017, 7:49 PM"
    ///
    /// - Parameter unixTimestamp: UNIX timestamp.
    init(unixTimestamp: Double) {
        self.init(timeIntervalSince1970: unixTimestamp)
    }
    
    /// Creates a new instance with specified date components.
    ///
    /// - parameter era:        The era.
    /// - parameter year:       The year.
    /// - parameter month:      The month.
    /// - parameter day:        The day.
    /// - parameter hour:       The hour.
    /// - parameter minute:     The minute.
    /// - parameter second:     The second.
    /// - parameter nanosecond: The nanosecond.
    /// - parameter calendar:   The calendar used to create a new instance.
    ///
    /// - returns: The created `Date` instance.
    init(era: Int?, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int, on calendar: Calendar) {
        let now = Date()
        var dateComponents = calendar.dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .nanosecond], from: now)
        dateComponents.era = era
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        dateComponents.nanosecond = nanosecond
        dateComponents.timeZone = calendar.timeZone
        
        let date = calendar.date(from: dateComponents)
        self.init(timeInterval: 0, since: date!)
    }
    
    /// Creates a new instance with specified date componentns.
    ///
    /// - parameter year:       The year.
    /// - parameter month:      The month.
    /// - parameter day:        The day.
    /// - parameter hour:       The hour.
    /// - parameter minute:     The minute.
    /// - parameter second:     The second.
    /// - parameter nanosecond: The nanosecond. `0` by default.
    ///
    /// - returns: The created `Date` instance.
    init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int = 0) {
        self.init(era: nil, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond, on: Calendar.currentCalendarSetting)
    }

    /// Creates a new Instance with specified date components
    ///
    /// - parameter year:  The year.
    /// - parameter month: The month.
    /// - parameter day:   The day.
    ///
    /// - returns: The created `Date` instance.
    init(year: Int, month: Int, day: Int) {
        self.init(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
    }
    
    static var deviceCalendar: Calendar {
        return Calendar.current
    }
    
    /// SwifterSwift: Era.
    ///
    ///        Date().era -> 1
    ///
    var era: Int {
        return Calendar.currentCalendarSetting.component(.era, from: self)
    }
    
    /// SwifterSwift: Quarter.
    ///
    var quarter: Int {
        return Calendar.currentCalendarSetting.component(.quarter, from: self)
    }
    
    /// SwifterSwift: Week of year.
    ///
    ///        Date().weekOfYear -> 2 // second week in the current year.
    ///
    var weekOfYear: Int {
        return Calendar.currentCalendarSetting.component(.weekOfYear, from: self)
    }
    
    /// SwifterSwift: Week of month.
    ///
    ///        Date().weekOfMonth -> 2 // second week in the current month.
    ///
    var weekOfMonth: Int {
        return Calendar.currentCalendarSetting.component(.weekOfMonth, from: self)
    }
    
    /// SwifterSwift: Year.
    ///
    ///        Date().year -> 2017
    ///
    ///        var someDate = Date()
    ///        someDate.year = 2000 // sets someDate's year to 2000
    ///
    var year: Int {
        get {
            return Calendar.currentCalendarSetting.component(.year, from: self)
        }
        set {
            if let date = Calendar.currentCalendarSetting.date(bySetting: .year, value: newValue, of: self) {
                self = date
            }
        }
    }
    
    /// SwifterSwift: Month.
    ///
    ///     Date().month -> 1
    ///
    ///     var someDate = Date()
    ///     someDate.year = 10 // sets someDate's month to 10.
    var month: Int {
        get {
            return Calendar.currentCalendarSetting.component(.month, from: self)
        }
        set {
            if let date = Calendar.currentCalendarSetting.date(bySetting: .month, value: newValue, of: self) {
                self = date
            }
        }
    }
    
    /// SwifterSwift: Day.
    ///
    ///     Date().day -> 12
    ///
    ///     var someDate = Date()
    ///     someDate.day = 1 // sets someDate's day of month to 1.
    var day: Int {
        get {
            return Calendar.currentCalendarSetting.component(.day, from: self)
        }
        set {
            if let date = Calendar.currentCalendarSetting.date(bySetting: .day, value: newValue, of: self) {
                self = date
            }
        }
    }
        
    /// SwifterSwift: Weekday.
    ///
    ///     Date().weekOfMonth -> 5 // fifth day in the current week.
    var weekday: Int {
        get {
            var calendar = Calendar.currentCalendarSetting
            if UserDefaultsUtils.isUsingMultiTimezone, let timezone = TimeZone.currentBranchTimeZone {
                calendar.timeZone = timezone
                return calendar.component(.weekday, from: self)
            } else {
                return calendar.component(.weekday, from: self)
            }
        }
        set {
            if let date = Calendar.currentCalendarSetting.date(bySetting: .weekday, value: newValue, of: self) {
                self = date
            }
        }
    }
    
    /// SwifterSwift: Weekday.
    ///
    /// The weekday units are the numbers 1 through N (where for the Gregorian calendar N=7 and 1 is Sunday).
    ///
    ///     Date().weekday -> 5 // fifth day in the current week, e.g. Thursday in the Gregorian calendar
    var weekdayCalendar: Int {
        Calendar.currentCalendarSetting.component(.weekday, from: self)
    }
    
    /// SwifterSwift: Hour.
    ///
    ///     Date().hour -> 17 // 5 pm
    ///
    ///     var someDate = Date()
    ///     someDate.day = 13 // sets someDate's hour to 1 pm.
    var hour: Int {
        get {
            return Calendar.currentCalendarSetting.component(.hour, from: self)
        }
        set {
            if let date = Calendar.currentCalendarSetting.date(bySetting: .hour, value: newValue, of: self) {
                self = date
            }
        }
    }
    
    /// SwifterSwift: Minutes.
    ///
    ///     Date().minute -> 39
    ///
    ///     var someDate = Date()
    ///     someDate.minute = 10 // sets someDate's minutes to 10.
    var minute: Int {
        get {
            return Calendar.currentCalendarSetting.component(.minute, from: self)
        }
        set {
            if let date = Calendar.currentCalendarSetting.date(bySetting: .minute, value: newValue, of: self) {
                self = date
            }
        }
    }
    
    /// SwifterSwift: Seconds.
    ///
    ///     Date().second -> 55
    ///
    ///     var someDate = Date()
    ///     someDate. second = 15 // sets someDate's seconds to 15.
    var second: Int {
        get {
            return Calendar.currentCalendarSetting.component(.second, from: self)
        }
        set {
            if let date = Calendar.currentCalendarSetting.date(bySetting: .second, value: newValue, of: self) {
                self = date
            }
        }
    }
    
    /// SwifterSwift: Nanoseconds.
    ///
    ///     Date().nanosecond -> 981379985
    var nanosecond: Int {
        get {
            return Calendar.currentCalendarSetting.component(.nanosecond, from: self)
        }
        set {
            if let date = Calendar.currentCalendarSetting.date(bySetting: .nanosecond, value: newValue, of: self) {
                self = date
            }
        }
    }
    
    var millisecond: Int {
        get {
            return Calendar.currentCalendarSetting.component(.nanosecond, from: self) / 1000000
        }
        set {
            let ns = newValue * 1000000
            if let date = Calendar.currentCalendarSetting.date(bySetting: .nanosecond, value: ns, of: self) {
                self = date
            }
        }
    }
    
    /// SwifterSwift: Check if date is in future.
    ///
    ///     Date(timeInterval: 100, since: Date()).isInFuture -> true
    ///
    var isInFuture: Bool {
        return self > Date()
    }
    
    /// SwifterSwift: Check if date is in past.
    ///
    ///     Date(timeInterval: -100, since: Date()).isInPast -> true
    var isInPast: Bool {
        return self < Date()
    }
    
    /// SwifterSwift: Check if date is in today.
    ///
    ///     Date().isInToday -> true
    var isInToday: Bool {
        return Calendar.currentCalendarSetting.isDateInToday(self)
    }
    
    /// SwifterSwift: Check if date is within yesterday.
    ///
    ///     Date().isInYesterday -> false
    var isInYesterday: Bool {
        return Calendar.currentCalendarSetting.isDateInYesterday(self)
    }
    
    /// SwifterSwift: Check if date is within tomorrow.
    ///
    ///     Date().isInTomorrow -> false
    var isInTomorrow: Bool {
        return Calendar.currentCalendarSetting.isDateInTomorrow(self)
    }
    
    /// SwifterSwift: Check if date is within a weekend period.
    var isInWeekend: Bool {
        return Calendar.currentCalendarSetting.isDateInWeekend(self)
    }
    
    /// SwifterSwift: Check if date is within a weekday period.
    var isInWeekday: Bool {
        return !Calendar.currentCalendarSetting.isDateInWeekend(self)
    }
    
    /// SwifterSwift: Check if date is within the current week.
    var isInThisWeek: Bool {
        return Calendar.currentCalendarSetting.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }
    
    /// SwifterSwift: Check if date is within the current month.
    var isInThisMonth: Bool {
        return Calendar.currentCalendarSetting.isDate(self, equalTo: Date(), toGranularity: .month)
    }
    
    /// SwifterSwift: Check if date is within the current year.
    var isInThisYear: Bool {
        return Calendar.currentCalendarSetting.isDate(self, equalTo: Date(), toGranularity: .year)
    }
    
    /// Get unix timestamp
    ///
    ///        Date().unixTimestamp -> 1484233862.826291
    var unixTimestamp: Double {
        return timeIntervalSince1970
    }
    
    private var dateComponents: DateComponents {
        return Calendar.currentCalendarSetting.dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .nanosecond, .weekday], from: self)
    }
    
    /// - Returns: the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.currentCalendarSetting.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// - Returns: the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.currentCalendarSetting.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// - Returns: the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.currentCalendarSetting.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// - Returns: the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.currentCalendarSetting.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// - Returns: the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.currentCalendarSetting.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// - Returns: the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.currentCalendarSetting.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// - Returns: the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.currentCalendarSetting.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    /// - Returns: the amount of m.seconds from another date
    func mlseconds(from date: Date) -> Int {
        return Int((timeIntervalSince(date).truncatingRemainder(dividingBy: 1)) * 1000)
    }
}

public extension String {
    func isISO8601Format() -> Bool {
        if self.isEmpty {
            return false
        }
        
        // Example expect
        // 2023-23-23T23:23:23.342342342+0200
        // 2023-23-23T23:23:23.342342342+02:00
        // 2023-23-23T23:23:23.342342342Z
        // Group #1: (\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}) --- bắt buộc phải có, dữ liệu có thể trông kiểu như thể này: "2023-23-23T23:23:23"
        // Group #2: ([.]\\d{1,10})? --- 1 hoặc không có cx được, dữ liệu sẽ trông kiểu như thế này ".0" -> ".12345678901"
        // Group #3: (Z|(\+\d{2}:\d{2})|(\+\d{4})) --- bắt buộc phải có, dữ liệu sẽ trông kiểu như thế này: Z || +00:00 || +0000
        
        let dateAndTimeWithUTCiso8601Pattern: String = "(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2})([.]\\d{1,10})?(Z|(\\+\\d{2}:\\d{2})|(\\+\\d{4}))"
        let listISO8601Formats: String = "yyyyMMdd_T_HHmmssSSSSSSSSSSXXX"
        
        // Check có matches thoả mãn regex hay không
        let isPassRegex = self.range(of: dateAndTimeWithUTCiso8601Pattern, options: .regularExpression) != nil
        
        // Check ngày giờ có hợp lệ hay không
        let dateFormatter = DateFormatter()
        dateFormatter.date(from: self)
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = listISO8601Formats
        
        // Pass qua regex và date hợp lệ
        return isPassRegex && dateFormatter.date(from: self) != nil
    }
    
    func iso8601WithCurrentTimeZoneDate() -> Date {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = DateTimeFormat.ddMMyyyy.rawValue
        
        return dateFormatter.date(from: self)!
    }
    
    func dateWithISO8601Format() -> Date? {
        if self.isEmpty {
            return nil
        }
        var iso8601String = self
        // Handle cho trường hợp date format thiếu utc
        if !self.contains("+") && !self.lowercased().contains("z") {
            iso8601String = self + "+07:00"
        }
        if let parseDate = Date(iso8601String: iso8601String) {
            return parseDate
        }
        
        return nil
    }
    
    func dateWithICTString() -> Date? {
        if self.isEmpty {
            return nil
        }
        if let date =  DateFormatter.itcFullFormatInstance.date(from: self) {
            return date
        }
        return nil
    }
    
    /// Convert từ string -> date
    /// - Parameters:
    ///   - format: Format muốn sử dụng, mặc định sẽ là kiêu iso8601
    ///   - timeZone: TimeZone
    /// - Returns: Date
    func toDate(withFormat format: DateTimeFormat = .yyyyMMdd_T_HHmmssSSSXXX, timeZone: TimeZone? = nil) -> Date? {
        if UserDefaultsUtils.isUsingMultiTimezone {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format.rawValue
            dateFormatter.locale = Locale.posix
            dateFormatter.timeZone = timeZone ?? .current
            return dateFormatter.date(from: self)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format.rawValue
            dateFormatter.locale = Locale.posix
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            return dateFormatter.date(from: self)
        }
    }
}

// MARK: - Int Extension
// Clone Timepice library
// ref: https://github.com/naoty/Timepiece
public extension Int {
    var year: DateComponents {
        return DateComponents(year: self)
    }

    var years: DateComponents {
        return year
    }

    var month: DateComponents {
        return DateComponents(month: self)
    }

    var months: DateComponents {
        return month
    }

    var week: DateComponents {
        return DateComponents(day: 7 * self)
    }

    var weeks: DateComponents {
        return week
    }

    var day: DateComponents {
        return DateComponents(day: self)
    }

    var days: DateComponents {
        return day
    }

    var hour: DateComponents {
        return DateComponents(hour: self)
    }

    var hours: DateComponents {
        return hour
    }

    var minute: DateComponents {
        return DateComponents(minute: self)
    }

    var minutes: DateComponents {
        return minute
    }

    var second: DateComponents {
        return DateComponents(second: self)
    }

    var seconds: DateComponents {
        return second
    }

    var nanosecond: DateComponents {
        return DateComponents(nanosecond: self)
    }

    var nanoseconds: DateComponents {
        return nanosecond
    }
}

// MARK: - Utils
public extension Date {
    /// Đưa về thành giờ UTC
    func toStringUTC(withFormat format: DateTimeFormat? = nil) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.posix
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = format?.rawValue ?? DateTimeFormat.yyyyMMdd_T_HHmmssSSSXXX.rawValue
        return dateFormatter.string(from: self)
    }
    
    /// Convert date to string với format + timezone
    /// - Parameters:
    ///   - format: Format muốn convert thành, default sẽ là iso8601
    ///   - timeZone: Timezone khu vực muốn sử dụng
    /// - Returns: Thời gian theo format ở dạng string
    func toString(withFormat format: DateTimeFormat? = nil, timeZone: TimeZone?) -> String? {
        if UserDefaultsUtils.isUsingMultiTimezone {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.posix
            dateFormatter.timeZone = timeZone ?? .current
            dateFormatter.dateFormat = format?.rawValue ?? DateTimeFormat.yyyyMMdd_T_HHmmssSSSXXX.rawValue
            return dateFormatter.string(from: self)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.posix
            dateFormatter.timeZone = timeZone ?? .current
            dateFormatter.dateFormat = format?.rawValue ?? DateTimeFormat.yyyyMMdd_T_HHmmssSSSXXX.rawValue
            return dateFormatter.string(from: self)
        }
    }
    
    /// Convert date to date: switch to other `timezone`
    /// - Parameters:
    ///   - format: Format muốn convert thành, default sẽ là iso8601
    ///   - timeZone: Timezone khu vực muốn sử dụng
    /// - Returns: `newDate` với Thời gian theo `format` `timezone`
    func toDate(withFormat format: DateTimeFormat? = nil, fromTimezone: TimeZone?, toTimeZone: TimeZone?) -> Date? {
        if UserDefaultsUtils.isUsingMultiTimezone {
            let fromDateFormatter = DateFormatter()
            fromDateFormatter.locale = Locale.posix
            fromDateFormatter.timeZone = fromTimezone ?? .current
            fromDateFormatter.dateFormat = format?.rawValue ?? DateTimeFormat.yyyyMMdd_T_HHmmssSSSXXX.rawValue
            var fromDateInString = fromDateFormatter.string(from: self)
            
            let toDateFormatter = DateFormatter()
            toDateFormatter.locale = Locale.posix
            toDateFormatter.timeZone = toTimeZone ?? .current
            toDateFormatter.dateFormat = format?.rawValue ?? DateTimeFormat.yyyyMMdd_T_HHmmssSSSXXX.rawValue
            
            return toDateFormatter.date(from: fromDateInString)
        } else {
            let fromDateFormatter = DateFormatter()
            fromDateFormatter.locale = Locale.posix
            fromDateFormatter.timeZone = fromTimezone ?? .current
            fromDateFormatter.dateFormat = format?.rawValue ?? DateTimeFormat.yyyyMMdd_T_HHmmssSSSXXX.rawValue
            var fromDateInString = fromDateFormatter.string(from: self)
            
            let toDateFormatter = DateFormatter()
            toDateFormatter.locale = Locale.posix
            toDateFormatter.timeZone = toTimeZone ?? .current
            toDateFormatter.dateFormat = format?.rawValue ?? DateTimeFormat.yyyyMMdd_T_HHmmssSSSXXX.rawValue
            
            return toDateFormatter.date(from: fromDateInString)
        }
    }

    
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    /// So sánh 2 date ở dạng UTC
    /// - Parameter date: Second date
    /// - Returns: True if equal
    func isSameDateUTC(with date: Date) -> Bool {
        if #available(iOS 15, *) {
            if #available(macOS 12.0, *) {
                return self.ISO8601Format() == date.ISO8601Format()
            } else {
                return false
            }
        } else {
            guard let leftDateStr = self.toStringUTC(),
                  let rightDateStr = date.toStringUTC(),
                  !leftDateStr.isEmpty,
                  !rightDateStr.isEmpty else {
                return false
            }
            
            return leftDateStr == rightDateStr
        }
    }

    func birthDayString() -> String {
        return DateFormatter.dateFormatInstance.string(from: self)
    }

    func dateString() -> String {
        if let timeZone = TimeZone.currentBranchTimeZone, UserDefaultsUtils.isUsingMultiTimezone {
            let formater = DateFormatter()
            formater.dateFormat = DateTimeFormat.ddMMyyyy_HHmm.rawValue
            formater.timeZone = timeZone
            return formater.string(from: self)
        } else {
            let formater = DateFormatter()
            formater.dateFormat = DateTimeFormat.ddMMyyyy_HHmm.rawValue
            return formater.string(from: self)
        }
    }
    
    func simpleDateString() -> String {
        if let timeZone = TimeZone.currentBranchTimeZone, UserDefaultsUtils.isUsingMultiTimezone {
            let formater = DateFormatter()
            formater.timeZone = timeZone
            formater.dateFormat = DateTimeFormat.ddMMyyyy.rawValue
            return formater.string(from: self)
        } else {
            let formater = DateFormatter()
            formater.dateFormat = DateTimeFormat.ddMMyyyy.rawValue
            return formater.string(from: self)
        }
    }
    
    func dateFilterDisplay(calendarTimezone: TimeZone) -> String {
        let formater = DateFormatter()
        formater.timeZone = calendarTimezone
        formater.dateFormat = DateTimeFormat.ddMMyyyy.rawValue
        return formater.string(from: self)
    }

    func timeString() -> String {
        if let timeZone = TimeZone.currentBranchTimeZone, UserDefaultsUtils.isUsingMultiTimezone {
            let formater = DateFormatter()
            formater.dateFormat = DateTimeFormat.HHmm.rawValue
            formater.timeZone = timeZone
            return formater.string(from: self)
        } else {
            let formater = DateFormatter()
            formater.dateFormat = DateTimeFormat.HHmm.rawValue
            return formater.string(from: self)
        }
    }

    func timeAgoString() -> String {
        let date = Date()
        let calendar = Calendar.currentCalendarSetting
        var earliest = self
        var latest = (earliest == self) ? date : self
        let timeFormatter = DateFormatter()
//        if let timeZone = TimeZone.currentBranchTimeZone, Defaults.isUsingMultiTimezone {
//            timeFormatter.timeZone = timeZone
//        }
        timeFormatter.dateFormat = DateTimeFormat.HHmm.rawValue
        var difference = calendar.dateComponents([.second, .minute, .hour], from: earliest, to: date)
        // if timeAgo < 24h => compare DateTime else compare Date only
        if difference.hour! < 24 && earliest.day == latest.day {
            if difference.hour! >= 1 {
                return "\(difference.hour!) giờ trước"
            } else if difference.minute! >= 1 {
                return "\(difference.minute!) phút trước"
            } else {
                return "vài giây trước"
            }
        } else if latest.day - earliest.day == 1 {
            return "Hôm qua lúc \(timeFormatter.string(from: self))"
        } else {
            let units: Set<Calendar.Component> = [.timeZone, .day, .year]
            var components = calendar.dateComponents(units, from: earliest)
            earliest = calendar.date(from: components)!
            components = calendar.dateComponents(units, from: latest)
            latest = calendar.date(from: components)!
            difference = calendar.dateComponents(units, from: earliest, to: latest)
            if difference.day! >= 7 || difference.day! < 0 {
                return "\(day) tháng \(month) lúc \(timeFormatter.string(from: self))"
            } else {
                // difference time < 7 day
                var weekdayString = ""
                switch weekday {
                case 1:
                    weekdayString = "Chủ nhật"
                case 2:
                    weekdayString = "Thứ Hai"
                case 3:
                    weekdayString = "Thứ Ba"
                case 4:
                    weekdayString = "Thứ Tư"
                case 5:
                    weekdayString = "Thứ Năm"
                case 6:
                    weekdayString = "Thứ Sáu"
                case 7:
                    weekdayString = "Thứ Bảy"
                default:
                    break
                }
                return "\(weekdayString) lúc \(self.timeString())"
            }
        }
    }
    
    /// SwifterSwift: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSS) from date.
    ///
    ///     Date().iso8601String -> "2017-01-12T14:51:29.574Z"
    ///
    var iso8601String: String {
        if UserDefaultsUtils.isUsingMultiTimezone,
           let timezone = TimeZone.currentBranchTimeZone {
            print("============ Đang sử dụng timezone của chi nhánh")
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.posix
            dateFormatter.timeZone = timezone
            dateFormatter.dateFormat = DateTimeFormat.yyyyMMdd_T_HHmmssSSSXXX.rawValue
            
            return dateFormatter.string(from: self)
        } else {
            print("============ Đang sử dụng timezone của thiết bị")
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.posix
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            dateFormatter.dateFormat = DateTimeFormat.yyyyMMdd_T_HHmmssSSS.rawValue
            
            return dateFormatter.string(from: self).appending("Z")
        }
    }
    
    var iso8601WithCurrentTimeZoneString: String {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = DateTimeFormat.yyyyMMdd_T_HHmmssSSS.rawValue
        
        return dateFormatter.string(from: self).appending("Z")
    }
    
    /// Trường này để request API với timezone offset +7
    var iso8601RequestAPI: String {
        if UserDefaultsUtils.isUsingMultiTimezone,
           let timezone = TimeZone.vn {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.posix
            dateFormatter.timeZone = timezone
            dateFormatter.dateFormat = DateTimeFormat.yyyyMMdd_T_HHmmssSSSXXX.rawValue
            
            return dateFormatter.string(from: self)
        } else {
            print("============ Đang sử dụng timezone của thiết bị")
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.posix
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            dateFormatter.dateFormat = DateTimeFormat.yyyyMMdd_T_HHmmssSSS.rawValue
            
            return dateFormatter.string(from: self).appending("Z")
        }
    }
    
    /// SwifterSwift: Nearest five minutes to date.
    ///
    ///     var date = Date() // "5:54 PM"
    ///     date.minute = 32 // "5:32 PM"
    ///     date.nearestFiveMinutes // "5:30 PM"
    ///
    ///     date.minute = 44 // "5:44 PM"
    ///     date.nearestFiveMinutes // "5:45 PM"
    ///
    var nearestFiveMinutes: Date {
        var components = Calendar.currentCalendarSetting.dateComponents([.year, .month , .day , .hour , .minute], from: self)
        let min = components.minute!
        components.minute! = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
        components.second = 0
        return Calendar.currentCalendarSetting.date(from: components)!
    }
    
    /// SwifterSwift: Nearest ten minutes to date.
    ///
    ///     var date = Date() // "5:57 PM"
    ///     date.minute = 34 // "5:34 PM"
    ///     date.nearestTenMinutes // "5:30 PM"
    ///
    ///     date.minute = 48 // "5:48 PM"
    ///     date.nearestTenMinutes // "5:50 PM"
    ///
    var nearestTenMinutes: Date {
        var components = Calendar.currentCalendarSetting.dateComponents([.year, .month , .day , .hour , .minute], from: self)
        let min = components.minute!
        components.minute? = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
        components.second = 0
        return Calendar.currentCalendarSetting.date(from: components)!
    }
    
    /// SwifterSwift: Nearest quarter hour to date.
    ///
    ///     var date = Date() // "5:57 PM"
    ///     date.minute = 34 // "5:34 PM"
    ///     date.nearestQuarterHour // "5:30 PM"
    ///
    ///     date.minute = 40 // "5:40 PM"
    ///     date.nearestQuarterHour // "5:45 PM"
    ///
    var nearestQuarterHour: Date {
        var components = Calendar.currentCalendarSetting.dateComponents([.year, .month , .day , .hour , .minute], from: self)
        let min = components.minute!
        components.minute! = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
        components.second = 0
        return Calendar.currentCalendarSetting.date(from: components)!
    }
    
    /// SwifterSwift: Nearest half hour to date.
    ///
    ///     var date = Date() // "6:07 PM"
    ///     date.minute = 41 // "6:41 PM"
    ///     date.nearestHalfHour // "6:30 PM"
    ///
    ///     date.minute = 51 // "6:51 PM"
    ///     date.nearestHalfHour // "7:00 PM"
    ///
    var nearestHalfHour: Date {
        var components = Calendar.currentCalendarSetting.dateComponents([.year, .month , .day , .hour , .minute], from: self)
        let min = components.minute!
        components.minute! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
        components.second = 0
        return Calendar.currentCalendarSetting.date(from: components)!
    }
    
    /// SwifterSwift: Nearest hour to date.
    ///
    ///     var date = Date() // "6:17 PM"
    ///     date.nearestHour // "6:00 PM"
    ///
    ///     date.minute = 36 // "6:36 PM"
    ///     date.nearestHour // "7:00 PM"
    ///
    var nearestHour: Date {
        if minute >= 30 {
            return beginning(of: .hour)!.adding(.hour, value: 1)
        }
        return beginning(of: .hour)!
    }
    
    var weekDayString: String {
        return ["Chủ nhật", "Thứ hai", "Thứ ba", "Thứ tư", "Thứ năm", "Thứ sáu", "Thứ bảy"][self.weekday - 1];
    }
    
    var weakDayFormatedString: String {
        var daystring = ""
        let datestring = DateFormatter.dateFormatInstance.string(from: self)
        if self.isInToday {
            daystring = "Hôm nay"
        } else if self.isInYesterday {
            daystring = "Hôm qua"
        } else {
            daystring = weekDayString
        }
        return "\(daystring), \(datestring)"
    }
    
    var totalWeekInMonth: Int {
        let firstDay = Date(year: self.year, month: self.month, day: 1)
        guard let weekRange = Calendar.currentCalendarSetting.range(of: .weekOfMonth, in: .month, for: firstDay) else {
            return 0
        }
        return weekRange.count
    }
    
    /// Thiết lập KM theo tuần thứ mấy trong tháng
    var weekOfMonthforPromotion: Int {

        if isInFirstWeekday {
            return 1
        }
        
        if isInLastWeekday {
            return 6
        }
        
        return weekOfMonthStartWithMonday
    }
    
    var weekOfMonthStartWithMonday: Int {
        if UserDefaultsUtils.isUsingMultiTimezone, let timeZone = TimeZone.currentBranchTimeZone {
            var calendar = Calendar(identifier: .gregorian)
//            calendar.timeZone = timeZone
            calendar.firstWeekday = 2
            return calendar.component(.weekOfMonth, from: self)
        } else {
            var calendar = Calendar(identifier: .gregorian)
            calendar.firstWeekday = 2
            return calendar.component(.weekOfMonth, from: self)
        }
    }
    
    var time24hString: String {
        if UserDefaultsUtils.isUsingMultiTimezone, let timeZone = TimeZone.currentBranchTimeZone {
            let formater = DateFormatter()
            formater.timeZone = timeZone
            formater.dateFormat = DateTimeFormat.HHmm.rawValue
            return formater.string(from: self)
        } else {
            let formater = DateFormatter()
            formater.dateFormat = DateTimeFormat.HHmm.rawValue
            return formater.string(from: self)
        }
    }
    
    var time24hStringWithDate: String {
        if UserDefaultsUtils.isUsingMultiTimezone, let timeZone = TimeZone.currentBranchTimeZone {
            let formater = DateFormatter()
            formater.dateFormat = DateTimeFormat.ddMMyyyy_HHmm.rawValue
            formater.timeZone = timeZone
            return formater.string(from: self)
        } else {
            let formater = DateFormatter()
            formater.dateFormat = DateTimeFormat.ddMMyyyy_HHmm.rawValue
            return formater.string(from: self)
        }
    }
    
    var dayAfter: Date {
        return Calendar.currentCalendarSetting.date(byAdding: .day, value: 1, to: self)!
    }
    
    var dayBefore: Date {
        return Calendar.currentCalendarSetting.date(byAdding: .day, value: -1, to: self)!
    }
    
    var timeStringGMT: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.posix
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSxxx"
        return dateFormatter.string(from: self)
    }
    
    /// Creates a new instance representing today.
    ///
    /// - returns: The created `Date` instance representing today.
    static func today() -> Date {
        let now = Date()
        return Date(year: now.year, month: now.month, day: now.day)
    }

    /// Creates a new instance representing yesterday
    ///
    /// - returns: The created `Date` instance representing yesterday.
    static func yesterday() -> Date {
        return (today() - 1.day ?? Date())
    }

    /// Creates a new instance representing tomorrow
    ///
    /// - returns: The created `Date` instance representing tomorrow.
    static func tomorrow() -> Date {
        return (today() + 1.day ?? Date())
    }

    /// Creates a new instance added a `DateComponents`
    ///
    /// - parameter left:  The date.
    /// - parameter right: The date components.
    ///
    /// - returns: The created `Date` instance.
    static func + (left: Date, right: DateComponents) -> Date? {
        return Calendar.currentCalendarSetting.date(byAdding: right, to: left)
    }

    /// Creates a new instance subtracted a `DateComponents`
    ///
    /// - parameter left:  The date.
    /// - parameter right: The date components.
    ///
    /// - returns: The created `Date` instance.
    static func - (left: Date, right: DateComponents) -> Date? {
        return Calendar.currentCalendarSetting.date(byAdding: -right, to: left)
    }

    /// Creates a new instance by changing the date components
    ///
    /// - Parameters:
    ///   - year: The year.
    ///   - month: The month.
    ///   - day: The day.
    ///   - hour: The hour.
    ///   - minute: The minute.
    ///   - second: The second.
    ///   - nanosecond: The nanosecond.
    /// - Returns: The created `Date` instnace.
    func changed(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil) -> Date? {
        var dateComponents = self.dateComponents
        dateComponents.year = year ?? self.year
        dateComponents.month = month ?? self.month
        dateComponents.day = day ?? self.day
        dateComponents.hour = hour ?? self.hour
        dateComponents.minute = minute ?? self.minute
        dateComponents.second = second ?? self.second
        dateComponents.nanosecond = nanosecond ?? self.nanosecond

        return Calendar.currentCalendarSetting.date(from: dateComponents)
    }

    /// Creates a new instance by changing the year.
    ///
    /// - Parameter year: The year.
    /// - Returns: The created `Date` instance.
    func changed(year: Int) -> Date? {
        return changed(year: year, month: nil, day: nil, hour: nil, minute: nil, second: nil, nanosecond: nil)
    }

    /// Creates a new instance by changing the month.
    ///
    /// - Parameter month: The month.
    /// - Returns: The created `Date` instance.
    func changed(month: Int) -> Date? {
        return changed(year: nil, month: month, day: nil, hour: nil, minute: nil, second: nil, nanosecond: nil)
    }

    /// Creates a new instance by changing the day.
    ///
    /// - Parameter day: The day.
    /// - Returns: The created `Date` instance.
    func changed(day: Int) -> Date? {
        return changed(year: nil, month: nil, day: day, hour: nil, minute: nil, second: nil, nanosecond: nil)
    }

    /// Creates a new instance by changing the hour.
    ///
    /// - Parameter hour: The hour.
    /// - Returns: The created `Date` instance.
    func changed(hour: Int) -> Date? {
        return changed(year: nil, month: nil, day: nil, hour: hour, minute: nil, second: nil, nanosecond: nil)
    }

    /// Creates a new instance by changing the minute.
    ///
    /// - Parameter minute: The minute.
    /// - Returns: The created `Date` instance.
    func changed(minute: Int) -> Date? {
        return changed(year: nil, month: nil, day: nil, hour: nil, minute: minute, second: nil, nanosecond: nil)
    }

    /// Creates a new instance by changing the second.
    ///
    /// - Parameter second: The second.
    /// - Returns: The created `Date` instance.
    func changed(second: Int) -> Date? {
        return changed(year: nil, month: nil, day: nil, hour: nil, minute: nil, second: second, nanosecond: nil)
    }

    /// Creates a new instance by changing the nanosecond.
    ///
    /// - Parameter nanosecond: The nanosecond.
    /// - Returns: The created `Date` instance.
    func changed(nanosecond: Int) -> Date? {
        return changed(year: nil, month: nil, day: nil, hour: nil, minute: nil, second: nil, nanosecond: nanosecond)
    }

    /// Creates a new instance by changing the weekday.
    ///
    /// - Parameter weekday: The weekday.
    /// - Returns: The created `Date` instance.
    func changed(weekday: Int) -> Date? {
        return self - (self.weekday - weekday).days
    }

    /// Creates a new instance by truncating the components
    ///
    /// - Parameter components: The components to be truncated.
    /// - Returns: The created `Date` instance.
    func truncated(_ components: [Calendar.Component]) -> Date? {
        var dateComponents = self.dateComponents

        for component in components {
            switch component {
            case .month:
                dateComponents.month = 1
            case .day:
                dateComponents.day = 1
            case .hour:
                dateComponents.hour = 0
            case .minute:
                dateComponents.minute = 0
            case .second:
                dateComponents.second = 0
            case .nanosecond:
                dateComponents.nanosecond = 0
            default:
                continue
            }
        }
        
        return Calendar.current.date(from: dateComponents)
    }

    /// Creates a new instance by truncating the components
    ///
    /// - Parameter component: The component to be truncated from.
    /// - Returns: The created `Date` instance.
    func truncated(from component: Calendar.Component) -> Date? {
        switch component {
        case .month:
            return truncated([.month, .day, .hour, .minute, .second, .nanosecond])
        case .day:
            return truncated([.day, .hour, .minute, .second, .nanosecond])
        case .hour:
            return truncated([.hour, .minute, .second, .nanosecond])
        case .minute:
            return truncated([.minute, .second, .nanosecond])
        case .second:
            return truncated([.second, .nanosecond])
        case .nanosecond:
            return truncated([.nanosecond])
        default:
            return self
        }
    }

    /// Creates a new `String` instance representing the receiver formatted in given date style and time style.
    ///
    /// - parameter dateStyle: The date style.
    /// - parameter timeStyle: The time style.
    ///
    /// - returns: The created `String` instance.
    func stringIn(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        if let timeZone = TimeZone.currentBranchTimeZone, UserDefaultsUtils.isUsingMultiTimezone {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = dateStyle
            dateFormatter.timeStyle = timeStyle
            dateFormatter.timeZone = timeZone
            
            return dateFormatter.string(from: self)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = dateStyle
            dateFormatter.timeStyle = timeStyle
            
            return dateFormatter.string(from: self)
        }
    }

    @available(*, unavailable, renamed: "stringIn(dateStyle:timeStyle:)")
    func string(inDateStyle dateStyle: DateFormatter.Style, andTimeStyle timeStyle: DateFormatter.Style) -> String {
        return stringIn(dateStyle: dateStyle, timeStyle: timeStyle)
    }

    /// Creates a new `String` instance representing the date of the receiver formatted in given date style.
    ///
    /// - parameter dateStyle: The date style.
    ///
    /// - returns: The created `String` instance.
    func dateString(in dateStyle: DateFormatter.Style) -> String {
        return stringIn(dateStyle: dateStyle, timeStyle: .none)
    }

    /// Creates a new `String` instance representing the time of the receiver formatted in given time style.
    ///
    /// - parameter timeStyle: The time style.
    ///
    /// - returns: The created `String` instance.
    func timeString(in timeStyle: DateFormatter.Style) -> String {
        return stringIn(dateStyle: .none, timeStyle: timeStyle)
    }
    
    /// SwifterSwift: Date by adding multiples of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     let date2 = date.adding(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    ///     let date3 = date.adding(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    ///     let date4 = date.adding(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    ///     let date5 = date.adding(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of components to add.
    /// - Returns: original date + multiples of component added.
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return Calendar.currentCalendarSetting.date(byAdding: component, value: value, to: self)!
    }
    
    /// SwifterSwift: Add calendar component to date.
    ///
    ///     var date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     date.add(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    ///     date.add(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    ///     date.add(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    ///     date.add(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of compnenet to add.
    mutating func add(_ component: Calendar.Component, value: Int) {
        self = adding(component, value: value)
    }
    
    /// SwifterSwift: Date by changing value of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     let date2 = date.changing(.minute, value: 10) // "Jan 12, 2017, 6:10 PM"
    ///     let date3 = date.changing(.day, value: 4) // "Jan 4, 2017, 7:07 PM"
    ///     let date4 = date.changing(.month, value: 2) // "Feb 12, 2017, 7:07 PM"
    ///     let date5 = date.changing(.year, value: 2000) // "Jan 12, 2000, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: new value of compnenet to change.
    /// - Returns: original date after changing given component to given value.
    func changing(_ component: Calendar.Component, value: Int) -> Date? {
        return Calendar.currentCalendarSetting.date(bySetting: component, value: value, of: self)
    }
    
    /// SwifterSwift: Data at the beginning of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:14 PM"
    ///     let date2 = date.beginning(of: .hour) // "Jan 12, 2017, 7:00 PM"
    ///     let date3 = date.beginning(of: .month) // "Jan 1, 2017, 12:00 AM"
    ///     let date4 = date.beginning(of: .year) // "Jan 1, 2017, 12:00 AM"
    ///
    /// - Parameter component: calendar component to get date at the beginning of.
    /// - Returns: date at the beginning of calendar component (if applicable).
    func beginning(of component: Calendar.Component) -> Date? {
        switch component {
        case .second:
            return Calendar.currentCalendarSetting.date(from:
                Calendar.currentCalendarSetting.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self))
            
        case .minute:
            return Calendar.currentCalendarSetting.date(from:
                Calendar.currentCalendarSetting.dateComponents([.year, .month, .day, .hour, .minute], from: self))
            
        case .hour:
            return Calendar.currentCalendarSetting.date(from:
                Calendar.currentCalendarSetting.dateComponents([.year, .month, .day, .hour], from: self))
            
        case .day:
            return Calendar.currentCalendarSetting.startOfDay(for: self)
            
        case .weekOfYear, .weekOfMonth:
            return Calendar.currentCalendarSetting.date(from:
                Calendar.currentCalendarSetting.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
            
        case .month:
            return Calendar.currentCalendarSetting.date(from:
                Calendar.currentCalendarSetting.dateComponents([.year, .month], from: self))
            
        case .year:
            return Calendar.currentCalendarSetting.date(from:
                Calendar.currentCalendarSetting.dateComponents([.year], from: self))
            
        default:
            return nil
        }
    }
    
    /// SwifterSwift: Date at the end of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:27 PM"
    ///     let date2 = date.end(of: .day) // "Jan 12, 2017, 11:59 PM"
    ///     let date3 = date.end(of: .month) // "Jan 31, 2017, 11:59 PM"
    ///     let date4 = date.end(of: .year) // "Dec 31, 2017, 11:59 PM"
    ///
    /// - Parameter component: calendar component to get date at the end of.
    /// - Returns: date at the end of calendar component (if applicable).
    func end(of component: Calendar.Component) -> Date? {
        switch component {
        case .second:
            var date = adding(.second, value: 1)
            date = Calendar.currentCalendarSetting.date(from:
                Calendar.currentCalendarSetting.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))!
            date.add(.second, value: -1)
            return date
            
        case .minute:
            var date = adding(.minute, value: 1)
            let after = Calendar.currentCalendarSetting.date(from:
                Calendar.currentCalendarSetting.dateComponents([.year, .month, .day, .hour, .minute], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        case .hour:
            var date = adding(.hour, value: 1)
            let after = Calendar.currentCalendarSetting.date(from:
                Calendar.currentCalendarSetting.dateComponents([.year, .month, .day, .hour], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        case .day:
            var date = adding(.day, value: 1)
            date = Calendar.currentCalendarSetting.startOfDay(for: date)
            date.add(.second, value: -1)
            return date
            
        case .weekOfYear, .weekOfMonth:
            var date = self
            let beginningOfWeek = Calendar.currentCalendarSetting.date(from:
                Calendar.currentCalendarSetting.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
            date = beginningOfWeek.adding(.day, value: 7).adding(.second, value: -1)
            return date
            
        case .month:
            var date = adding(.month, value: 1)
            let after = Calendar.currentCalendarSetting.date(from:
                Calendar.currentCalendarSetting.dateComponents([.year, .month], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        case .year:
            var date = adding(.year, value: 1)
            let after = Calendar.currentCalendarSetting.date(from:
                Calendar.currentCalendarSetting.dateComponents([.year], from: date))!
            date = after.adding(.second, value: -1)
            return date
            
        default:
            return nil
        }
    }
    
    /// SwifterSwift: Date string from date.
    ///
    ///     Date().dateString(ofStyle: .short) -> "1/12/17"
    ///     Date().dateString(ofStyle: .medium) -> "Jan 12, 2017"
    ///     Date().dateString(ofStyle: .long) -> "January 12, 2017"
    ///     Date().dateString(ofStyle: .full) -> "Thursday, January 12, 2017"
    ///
    /// - Parameter style: DateFormatter style (default is .medium).
    /// - Returns: date string.
    func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    /// SwifterSwift: Date and time string from date.
    ///
    ///     Date().dateTimeString(ofStyle: .short) -> "1/12/17, 7:32 PM"
    ///     Date().dateTimeString(ofStyle: .medium) -> "Jan 12, 2017, 7:32:00 PM"
    ///     Date().dateTimeString(ofStyle: .long) -> "January 12, 2017 at 7:32:00 PM GMT+3"
    ///     Date().dateTimeString(ofStyle: .full) -> "Thursday, January 12, 2017 at 7:32:00 PM GMT+03:00"
    ///
    /// - Parameter style: DateFormatter style (default is .medium).
    /// - Returns: date and time string.
    func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    /// SwifterSwift: Check if date is in current given calendar component.
    ///
    ///     Date().isInCurrent(.day) -> true
    ///     Date().isInCurrent(.year) -> true
    ///
    /// - Parameter component: calendar component to check.
    /// - Returns: true if date is in current given calendar component.
    func isInCurrent(_ component: Calendar.Component) -> Bool {
        return Calendar.currentCalendarSetting.isDate(self, equalTo: Date(), toGranularity: component)
    }
    
    /// SwifterSwift: Time string from date
    ///
    ///     Date().timeString(ofStyle: .short) -> "7:37 PM"
    ///     Date().timeString(ofStyle: .medium) -> "7:37:02 PM"
    ///     Date().timeString(ofStyle: .long) -> "7:37:02 PM GMT+3"
    ///     Date().timeString(ofStyle: .full) -> "7:37:02 PM GMT+03:00"
    ///
    /// - Parameter style: DateFormatter style (default is .medium).
    /// - Returns: time string.
    func timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = .none
        return dateFormatter.string(from: self)
    }
    
    /// SwifterSwift: Day name from date.
    ///
    ///     Date().dayName(ofStyle: .oneLetter) -> "T"
    ///     Date().dayName(ofStyle: .threeLetters) -> "Thu"
    ///     Date().dayName(ofStyle: .full) -> "Thursday"
    ///
    /// - Parameter Style: style of day name (default is DayNameStyle.full).
    /// - Returns: day name string (example: W, Wed, Wednesday).
    func dayName(ofStyle style: DayNameStyle = .full) -> String {
        // http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .oneLetter:
                return "EEEEE"
            case .threeLetters:
                return "EEE"
            case .full:
                return "EEEE"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
    
    /// SwifterSwift: Month name from date.
    ///
    ///     Date().monthName(ofStyle: .oneLetter) -> "J"
    ///     Date().monthName(ofStyle: .threeLetters) -> "Jan"
    ///     Date().monthName(ofStyle: .full) -> "January"
    ///
    /// - Parameter Style: style of month name (default is MonthNameStyle.full).
    /// - Returns: month name string (example: D, Dec, December).
    func monthName(ofStyle style: MonthNameStyle = .full) -> String {
        // http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .oneLetter:
                return "MMMMM"
            case .threeLetters:
                return "MMM"
            case .full:
                return "MMMM"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
    
    /// SwifterSwift: get number of seconds between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of seconds between self and given date.
    func secondsSince(_ date: Date) -> Double {
        return self.timeIntervalSince(date)
    }
    
    /// SwifterSwift: get number of minutes between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of minutes between self and given date.
    func minutesSince(_ date: Date) -> Double {
        return self.timeIntervalSince(date)/60
    }
    
    /// SwifterSwift: get number of hours between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of hours between self and given date.
    func hoursSince(_ date: Date) -> Double {
        return self.timeIntervalSince(date)/3600
    }
    
    /// SwifterSwift: get number of days between two date
    ///
    /// - Parameter date: date to compate self to.
    /// - Returns: number of days between self and given date.
    func daysSince(_ date: Date) -> Double {
        return self.timeIntervalSince(date)/(3600*24)
    }
    
    func startOfMonth(in calendar: Calendar = .current) -> Date {
        Calendar.currentCalendarSetting.date(from: Calendar.currentCalendarSetting.dateComponents([.year, .month], from: Calendar.currentCalendarSetting.startOfDay(for: self)))!.startOfDay(in: Calendar.currentCalendarSetting)
    }

    func endOfMonth(in calendar: Calendar = .current) -> Date {
        Calendar.currentCalendarSetting.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth(in: Calendar.currentCalendarSetting))!.endOfDay(in: Calendar.currentCalendarSetting)
    }

    func isInSameDay(in calendar: Calendar = .current, date: Date) -> Bool {
        Calendar.currentCalendarSetting.isDate(self, equalTo: date, toGranularity: .day)
    }

    func isInSameMonth(in calendar: Calendar = .current, date: Date) -> Bool {
        Calendar.currentCalendarSetting.component(.month, from: self) == Calendar.currentCalendarSetting.component(.month, from: date)
    }

    func startOfDay(in calendar: Calendar = .current) -> Date {
        Calendar.currentCalendarSetting.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }

    func endOfDay(in calendar: Calendar = .current) -> Date {
        Calendar.currentCalendarSetting.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }
    
    /// Returns number of days between two date
    func difDays(from date: Date) -> Int {
        let calendar = Calendar.currentCalendarSetting
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: date)
        let date2 = calendar.startOfDay(for: self)
        return calendar.dateComponents([.day], from: date1, to: date2).day ?? 0
    }
    
    var isInFirstWeekday: Bool {
        let previous = adding(.day, value: -7)
        return previous.month != month
    }
    
    var isInLastWeekday: Bool {
        let next = adding(.day, value: 7)
        return next.month != month
    }
}
