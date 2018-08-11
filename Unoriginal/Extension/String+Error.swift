//
//  String+Error.swift
//  Unoriginal
//
//  Created by Reece Como on 11/8/18.
//  Copyright © 2018 Hubrio. All rights reserved.
//

import Foundation

extension String: LocalizedError {
    
    // MARK: - LocalizedError
    
    /// Allow strings to be used directly in `throw` blocks
    public var errorDescription: String? { return self }
    
}
