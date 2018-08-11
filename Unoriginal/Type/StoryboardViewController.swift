//
//  StoryboardViewController.swift
//  Unoriginal
//
//  Created by Reece Como on 11/8/18.
//  Copyright © 2018 Hubrio. All rights reserved.
//

import UIKit

/// ViewController that is mapped to a storyboaerd
protocol StoryboardViewController { }

extension StoryboardViewController where Self: UIViewController {
    
    // MARK: - Default implementation
    
    /// Get a storyboard from a name
    static func fromStoryboard(named name: String) -> Self {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        
        if let viewController = storyboard.instantiateInitialViewController() as? Self {
            return viewController
        } else {
            fatalError("Could not initialise \(name).storyboard (Not found)")
        }
    }
    
}
