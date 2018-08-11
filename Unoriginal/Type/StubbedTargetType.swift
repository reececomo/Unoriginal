//
//  TargetType+Extension.swift
//  Unoriginal
//
//  Created by Reece Como on 11/8/18.
//  Copyright © 2018 Hubrio. All rights reserved.
//

import Moya

/// Stubbed target type
protocol StubbedTargetType {
    
    /// Get the JSON sample name
    var jsonSampleName: String { get }
    
    /// Sample data (TargetType)
    var sampleData: Data { get }
    
}

extension StubbedTargetType {
    
    // MARK: - Default Implementation
    
    /// Sample data
    var sampleData: Data {
        if let url = Bundle.main.url(forResource: jsonSampleName, withExtension: "json"), let data =  try? Data(contentsOf: url) {
            return data
        }
        
        fatalError("Unable to load sample data: \(jsonSampleName).json")
    }
    
}
