//
//  RepoProtocol.swift
//  Unoriginal
//
//  Created by Reece Como on 11/8/18.
//  Copyright © 2018 Hubrio. All rights reserved.
//

import Foundation

/// Repo
protocol Repo {
    
    /// Display name e.g. "RxSwift"
    var name: String { get }
    
    /// Full name e.g. "ReactiveX/RxSwift"
    var fullName: String { get }
    
    /// URL of repository
    var url: String { get }
    
    /// Description of the repo
    var description: String { get }
    
    /// Host of repository e.g. "GitHub"
    var host: String { get }
    
    /// Created at date
    var createdAt: Date { get }
    
}
