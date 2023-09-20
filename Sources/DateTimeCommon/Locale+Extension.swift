//
//  Locale+Extension.swift
//  FnB
//
//  Created by Hungxt on 15/09/2023.
//  Copyright © 2023 Citigo. All rights reserved.
//

import Foundation

public extension Locale {
    /// SwifterSwift: UNIX representation of locale usually used for normalizing.
    static var posix: Locale {
        return Locale(identifier: "en_US_POSIX")
    }
}
