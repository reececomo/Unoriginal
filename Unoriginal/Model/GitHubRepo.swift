//
//  GitHubRepo.swift
//  Unoriginal
//
//  Created by Reece Como on 11/8/18.
//  Copyright © 2018 Hubrio. All rights reserved.
//

import Mapper

/// GitHub Repo
final class GitHubRepo: Repo, Mappable {
    
    // MARK: - Properties
    
    /// Host
    let host = "GitHub"
    
    /// Display name e.g. "RxSwift"
    let name: String
    
    /// Full name e.g. "ReactiveX/RxSwift"
    let fullName: String
    
    /// Description of the repo
    let description: String
    
    /// URL of repository
    let url: String
    
    /// Date created at
    let createdAt: Date
    
    // MARK: - Methods
    
    /// Init
    init(map: Mapper) throws {
        name = try map.from("name")
        fullName = try map.from("full_name")
        url = try map.from("html_url")
        description = try map.from("description")
        createdAt = GitHubRepo.parseDate(from: try map.from("created_at"))
    }
    
    /// Date formatter
    static func parseDate(from timestamp: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let date = formatter.date(from: timestamp) else {
            fatalError("Unable to parse date from timestamp: \(timestamp)")
        }
        
        return date
    }
    
}
