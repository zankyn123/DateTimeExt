//
//  UserDefaultsUtils.swift
//  KVPromotion
//
//  Created by Hungxt on 15/09/2023.
//  Copyright © 2023 Citigo. All rights reserved.
//

import Foundation

public struct UserDefaultsUtils {
    /// TimeZone
    static var isUsingMultiTimezone: Bool = UserDefaults.standard.bool(forKey: "net.citigo.userdefault.isUsingMultiTimezone")
    static var retailerTimezoneIdentifier: String? = UserDefaults.standard.string(forKey: "net.citigo.userdefault.retailerTimeZoneIdentifier")
    static var branchTimezoneIdentifier: String? = UserDefaults.standard.string(forKey: "net.citigo.userdefault.currentBranchTimezoneIdentifier")
    
    
}
