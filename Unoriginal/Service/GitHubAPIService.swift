//
//  GitHubAPIService.swift
//  Unoriginal
//
//  Created by Reece Como on 11/8/18.
//  Copyright © 2018 Hubrio. All rights reserved.
//

import Moya

///
/// GitHub API Service
///

enum GitHubAPIService {
    
    // MARK: - Endpoints
    
    /// Search for repos
    case searchRepositories(query: String, language: String?)
    
}

extension GitHubAPIService: TargetType, StubbedTargetType {
    
    // MARK: - Implementation
    
    /// Base URL
    var baseURL: URL {
        guard let apiURL = URL(string: Settings.githubAPIBaseURL) else {
            fatalError("Unable to load the api")
        }
        
        return apiURL
    }
    
    /// URL Path
    var path: String {
        switch self {
        case .searchRepositories:
            return "/search/repositories"
        }
    }
    
    /// HTTP Method
    var method: Moya.Method {
        return .get
    }
    
    /// Request Task
    var task: Task {
        switch self {
        case .searchRepositories(let query, let language):
            // Add language to query
            // todo: move this
            var query = query
            if let language = language, !query.isEmpty {
                query += "+language:\(language.lowercased())"
            }
            
            // Build request parameters
            return .requestParameters(
                parameters: [
                    "q": query,
                    "sort": "stars",
                    "order": "desc",
                    "page": 1 // Always ask for first page
                ],
                encoding: URLEncoding.default)
        }
    }
    
    /// Headers
    var headers: [String: String]? {
        return nil
    }
    
    /// Name of the JSON sample
    var jsonSampleName: String {
        switch self {
        case .searchRepositories:
            return "github.search-repositories"
        }
    }
    
}
