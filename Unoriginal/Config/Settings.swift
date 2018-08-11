//
//  Settings.swift
//  Unoriginal
//
//  Created by Reece Como on 11/8/18.
//  Copyright © 2018 Hubrio. All rights reserved.
//

import Foundation

/// Application settings
final class Settings {
    
    // MARK: - URLs
    
    /// Github base URL
    static let githubAPIBaseURL: String = "https://api.github.com"
    
    /// Debug build?
    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
