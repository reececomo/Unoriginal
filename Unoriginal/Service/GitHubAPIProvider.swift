//
//  SearchProvider.swift
//  Unoriginal
//
//  Created by Reece Como on 11/8/18.
//  Copyright © 2018 Hubrio. All rights reserved.
//

import RxSwift

/// GitHub API Provider
final class GitHubAPIProvider: APIProvider<GitHubAPIService> {
    
    // MARK: - Methods
    
    /// Search for repositories
    func searchRepositories(query: String, language: String? = nil) -> Single<[GitHubRepo]> {
        return requestObjects(.searchRepositories(query: query, language: language), type: [GitHubRepo].self, keyPath: "items")
    }
    
}
