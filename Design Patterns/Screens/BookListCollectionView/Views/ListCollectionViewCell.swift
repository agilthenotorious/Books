//
//  ListCollectionViewCell.swift
//  Design Patterns
//
//  Created by Agil Madinali on 9/23/20.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    static let identifier: String = "ListCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.itemImageView.layer.cornerRadius = self.itemImageView.frame.height/2
        self.itemImageView.layer.borderWidth = 1.0
        self.itemImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //self.subtitleLabel.isHidden = false
    }
    
    func configureCell(using itemInfo: VolumeInfo) {
//        self.titleLabel.text = itemInfo.title
//        self.subtitleLabel.text = itemInfo.subTitle
//        self.subtitleLabel.isHidden = itemInfo.subTitle?.isEmpty ?? true
        
        if let thumbNail = itemInfo.imageLinks?.smallThumbnail,
            let url = URL(string: thumbNail) {
            self.itemImageView.downloadImage(with: url)
        }
    }
    
//    static func nib() -> UINib {
//        return UINib(nibName: ListCollectionViewCell.identifier, bundle: nil)
//    }

}
