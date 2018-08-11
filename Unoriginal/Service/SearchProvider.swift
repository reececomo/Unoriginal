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
    func searchRepositories(query: String, language: String? = nil) -> Observable<[Repo]> {
        let githubResults = githubProvider.searchRepositories(query: query, language: language)
            .map { repos -> [Repo] in
                return repos as [Repo]
            }
            .asObservable()
        
        return Observable<[Repo]>.merge(githubResults)
    }
    
}
