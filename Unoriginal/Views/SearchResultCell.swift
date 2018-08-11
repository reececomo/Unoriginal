//
//  SearchResultCell.swift
//  Unoriginal
//
//  Created by Reece Como on 11/8/18.
//  Copyright © 2018 Hubrio. All rights reserved.
//

import UIKit

/// Search result cell
final class SearchResultCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    /// Display image
    @IBOutlet weak var imageIcon: UIImageView!
    
    /// Repository title
    @IBOutlet weak var labelTitle: UILabel!
    
    /// Repository name
    @IBOutlet weak var labelFullName: UILabel!
    
    /// Repository host
    @IBOutlet weak var labelSummary: UILabel!
    
}
