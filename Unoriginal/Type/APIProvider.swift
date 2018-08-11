//
//  File.swift
//  Unoriginal
//
//  Created by Reece Como on 11/8/18.
//  Copyright © 2018 Hubrio. All rights reserved.
//

import RxSwift
import Moya
import Mapper
import Moya_ModelMapper

///
/// Protocol for testable API providers
///
protocol TestableAPIProvider {
    
    /// For TargetTypes
    associatedtype Target: TargetType
    
    /// The associated Moya Provider
    var provider: MoyaProvider<Target> { get }
    
    /// Make basic requests
    func request(_ request: Target, errorMessage: String?) -> Single<Response>
    
    /// Request multiple objects
    func requestObjects<ObjectType: Mappable>(_ requestToken: Target, type: [ObjectType].Type, keyPath: String?) -> Single<[ObjectType]>
}

///
/// A wrapper around MoyaProvider
///
class APIProvider<Target: TargetType>: TestableAPIProvider {
    
    // MARK: - Logging
    
    /// Error logging
    let logger = Logger(for: .apiServices)
    
    // MARK: - Default Implementation
    
    ///
    /// Provider -- Returns a test service provider in debug builds
    ///
    lazy var provider: MoyaProvider<Target> = {
        #if DEBUG
        return MoyaProvider<Target>(stubClosure: MoyaProvider.immediatelyStub)
        #else
        return MoyaProvider<Target>()
        #endif
    }()
    
    ///
    /// Make a basic API request
    ///
    func request(_ request: Target, errorMessage: String? = nil) -> Single<Response> {
        return provider.rx
            .request(request)
            .flatMap({ response -> Single<Response> in
                switch response.statusCode {
                case 200...299:
                    // Success
                    return .just(response)
                    
                case 401:
                    // Authentication -- likely that we hit the request limit
                    return .error(errorMessage ?? "Too many requests")
                    
                default:
                    // Error -- unable to complete
                    self.logger.error("Unable to complete an API Request")
                    return .error(errorMessage ?? "Unable to complete the request")
                }
            })
    }
    
    ///
    /// Handle API request for a specific resource
    ///
    func requestObject<ObjectType: Mappable>(_ requestToken: Target, type: ObjectType.Type, keyPath: String? = nil) -> Single<ObjectType> {
        let displayError = "Unable to fetch \(type.self)"
        logger.info("Requesting \(type.self) objects")
        
        // Make a request, and handle the object mapping
        return request(requestToken, errorMessage: displayError)
            .flatMap({ response -> Single<ObjectType> in
                if let object = try? response.map(to: ObjectType.self, keyPath: keyPath) {
                    return .just(object)
                }
                
                // Unable to unwrap - log error and display default error to UI
                Logger(for: .apiServices).error("Failed to unwrap \(type.self)")
                throw displayError
            })
    }
    
    ///
    /// Handle API request for a specific resource
    ///
    func requestObjects<ObjectType: Mappable>(_ requestToken: Target, type: [ObjectType].Type, keyPath: String? = nil) -> Single<[ObjectType]> {
        let displayError = "Unable to fetch \(type.self)"
        logger.info("Requesting \(type.self) objects")
        
        // Make a request, and handle the object mapping
        return request(requestToken, errorMessage: displayError)
            .map(to: type, keyPath: keyPath)
    }
    
}
