//
//  TimeZoneExt.swift
//  FnB
//

import Foundation

public extension TimeZone {
    // MARK: - Instance
    static let vn: TimeZone? = TimeZone(identifier: "Asia/Ho_Chi_Minh")
    /// Lấy ra timezone của current branch
    static var currentBranchTimeZone: TimeZone? {
        if let timezoneBranchIdentifier = UserDefaultsUtils.branchTimezoneIdentifier,
           UserDefaultsUtils.isUsingMultiTimezone,
           isAvailable(timezoneBranchIdentifier) {
            return TimeZone(identifier: timezoneBranchIdentifier)
        } else if let timezoneBranchIdentifier = UserDefaultsUtils.retailerTimezoneIdentifier,
                  UserDefaultsUtils.isUsingMultiTimezone,
                  isAvailable(timezoneBranchIdentifier) {
            return TimeZone(identifier: timezoneBranchIdentifier)
        } else {
            return TimeZone.vn
        }
    }
    
//    /// Lấy ra timezone của retailer
//    static var retailerTimeZone: TimeZone? {
//        if let timezoneRetailerIdentifier = Defaults.retailerTimezoneIdentifier, isAvailable(timezoneRetailerIdentifier) {
//            return TimeZone(identifier: timezoneRetailerIdentifier)
//        } else {
//            return TimeZone.vn
//        }
//    }
    
    // MARK: - Utils
    /// Check timezone identifier hiện tại, hệ thống có hay không
    /// - Parameter identifier: identifier muốn check
    /// - Returns: true -> có, false -> không
    static func isAvailable(_ identifier: String) -> Bool {
        if TimeZone.knownTimeZoneIdentifiers.contains(identifier) {
            return true
        } else {
            return false
        }
    }
    
    /// Sử dụng để check offset của 2 timezone có đang giống nhau
    /// - Parameter timeZone: Timezone muốn check
    /// - Returns: Giống nhau thì sẽ là true
    func isSameOffset(_ timeZone: TimeZone) -> Bool {
        return self.secondsFromGMT() == timeZone.secondsFromGMT()
    }
}
