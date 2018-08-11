//
//  Logger.swift
//  Unoriginal
//
//  Created by Reece Como on 11/8/18.
//  Copyright © 2018 Hubrio. All rights reserved.
//

import Foundation

// MARK: - Logging

///
/// Category for logging
///
enum LogCategory: String {
    
    /// Default log
    case standard
    
    /// API
    case apiServices
    
    // MARK: - Helpers
    
    /// String to prepend to logging output
    var prefix: String {
        switch self {
        case .standard: return "[Standard] "
        case .apiServices: return "[API] "
        }
    }
    
}

///
/// Logging class
///
class Logger {
    
    /// Category
    private let category: LogCategory
    
    /// Init
    init(for category: LogCategory = .standard) {
        self.category = category
    }
    
    // MARK: - Logging
    
    /// Log info
    func info(_ description: String) {
        if Settings.isDebug {
            print(category.prefix + "Info: \(description)")
        } else {
            print(category.prefix + "Info: \(description)")
        }
    }
    
    /// Log a warning
    func warning(_ description: String) {
        if Settings.isDebug {
            print(category.prefix + "Warning: \(description)")
        } else {
            print(category.prefix + "Warning: \(description)")
        }
    }
    
    /// Log an error
    func error(_ description: String) {
        if Settings.isDebug {
            print(category.prefix + "Error: \(description)")
        } else {
            print(category.prefix + "Error: \(description)")
        }
    }

}
