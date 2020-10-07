//
//  CollectionDetailViewController.swift
//  Design Patterns
//
//  Created by Agil Madinali on 9/23/20.
//

import SafariServices
import UIKit

class CollectionDetailViewController: UIViewController {

    @IBOutlet weak var detailCollectionView: UICollectionView! {
        didSet {
            self.detailCollectionView.delegate = self
            self.detailCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var detailImageView: UIImageView!
    
    var bookInfo = VolumeInfo()
    var keyValueArray = [KeyValueStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Book Details"
        imageLoad()
        populate()
        viewInSafari()
    }
    
    func imageLoad() {
        if let thumbNail = bookInfo.imageLinks?.smallThumbnail,
           let url = URL(string: thumbNail) {
            self.detailImageView.downloadImage(with: url)
        }
    }
    
    func populate() {
        if let title = bookInfo.title {
            keyValueArray.append(KeyValueStruct(key: "Title", value: title))
        }
        
        if let subtitle = bookInfo.subTitle {
            keyValueArray.append(KeyValueStruct(key: "Subtitle", value: subtitle))
        }
        
        if let authorsArray: [String] = bookInfo.authors {
            var authorsString = String()
            for author in authorsArray {
                authorsString += author
            }
            keyValueArray.append(KeyValueStruct(key: "Authors", value: authorsString))
        }
        
        if let publisher = bookInfo.publisher {
            keyValueArray.append(KeyValueStruct(key: "Publisher", value: publisher))
        }
        
        if let description = bookInfo.description {
            keyValueArray.append(KeyValueStruct(key: "Description", value: description))
        }
        
        if let count = bookInfo.pageCount {
            let pageCount = String(count)
            keyValueArray.append(KeyValueStruct(key: "Page Count", value: pageCount))
        }
    }
}

extension CollectionDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        keyValueArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as? DetailCollectionViewCell else {
            fatalError("Detail cell cannot be dequeued!")
        }
        cell.keyLabel.text = keyValueArray[indexPath.row].key
        cell.valueLabel.text = keyValueArray[indexPath.row].value
        return cell
    }
}

extension CollectionDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        detailCollectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension CollectionDetailViewController: SFSafariViewControllerDelegate {
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true)
    }
    
    @objc func viewOnline() {
        if let urlString = bookInfo.previewLink,
            let url = URL(string: urlString){
            self.presentSafariVC(with: url)
        }
    }
    
    func viewInSafari() {
        let webButton = UIBarButtonItem(title: "Web View", style: .plain, target: self, action: #selector(self.viewOnline))
        self.navigationItem.rightBarButtonItem = webButton
    }
}
