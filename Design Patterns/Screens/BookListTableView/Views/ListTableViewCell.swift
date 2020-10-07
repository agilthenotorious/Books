//
//  ListTableViewCell.swift
//  Design Patterns
//
//  Created by Agil Madinali on 9/22/20.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    static let identifier = "ListTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.itemImageView.layer.cornerRadius = self.itemImageView.frame.height/2
        self.itemImageView.layer.borderWidth = 1.0
        self.itemImageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.subtitleLabel.isHidden = false
    }
    
    func configureCell(using itemInfo: VolumeInfo) {
        self.titleLabel.text = itemInfo.title
        self.subtitleLabel.text = itemInfo.subTitle
        self.subtitleLabel.isHidden = itemInfo.subTitle?.isEmpty ?? true
        
        if let thumbNail = itemInfo.imageLinks?.smallThumbnail,
           let url = URL(string: thumbNail) {
            self.itemImageView.downloadImage(with: url)
        }
    }
}

extension UIImageView {
    
    func downloadImage(with url: URL) {
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            } catch {
                print(error)
            }
        }
    }
}
