//
//  DetailCollectionViewCell.swift
//  Design Patterns
//
//  Created by Agil Madinali on 9/23/20.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    static let identifier: String = "DetailCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
