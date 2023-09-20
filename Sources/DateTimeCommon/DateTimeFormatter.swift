//
//  DateTimeFormatter.swift
//  FnB
//
//  Created by Hungxt on 15/09/2023.
//  Copyright © 2023 Citigo. All rights reserved.
//

import Foundation

// MARK: - Formatter
public enum DateTimeFormat: String {
    /// dd/MM/yyyy HH:mm
    case ddMMyyyy_HHmm = "dd/MM/yyyy HH:mm"
    /// dd/MM/yyyy
    case ddMMyyyy = "dd/MM/yyyy"
    /// yyyy-MM-dd
    case yyyyMMdd = "yyyy-MM-dd"
    /// HH:mm:ss
    case HHmmss = "HH:mm:ss"
    /// HH:mm
    case HHmm = "HH:mm"
    /// yyyy-MM-dd'T'HH:mm:ss.SSSSSSS
    case yyyyMMdd_T_HHmmssSSSSSSS = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
    /// yyyy-MM-dd'T'HH:mm:ss.SSS
    case yyyyMMdd_T_HHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    /// yyyy-MM-dd'T'HH:mm:ssZZZZZ
    case yyyyMMdd_T_HHmmssZZZZZ = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    /// E MMM dd yyyy HH:mm:ss 'GMT'z '(Indochina Time)'
    case ictFull = "E MMM dd yyyy HH:mm:ss 'GMT'z '(Indochina Time)'"
    /// yyyy-MM-dd'T'HH:mm:ss.SSSxxx
    case yyyyMMdd_T_HHmmssSSSxxx = "yyyy-MM-dd'T'HH:mm:ss.SSSxxx"
    /// yyyy-MM-dd'T'HH:mm:ss.SSSXXX
    case yyyyMMdd_T_HHmmssSSSXXX = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
    /// yyyy-MM-dd'T'HH:mm:ssZ
    case yyyyMMdd_T_HHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    /// yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSSSZZ
    case yyyyMMdd_T_HHmmssSSSSSSSSSSXXX = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSSSXXX"
}
