//
//  SearchProvider.swift
//  Unoriginal
//
//  Created by Reece Como on 11/8/18.
//  Copyright © 2018 Hubrio. All rights reserved.
//

import RxSwift

///
/// Search provider
///

final class SearchProvider {
    
    // MARK: - Properties
    
    /// GitHub
    private let githubProvider = GitHubAPIProvider()
    
    // MARK: - Methods
    
    /// Search repositories
    func searchRepositories(query: String, language: String? = nil) -> Single<[GitHubRepo]> {
        return githubProvider.searchRepositories(query: query, language: language)
    }
    
}
