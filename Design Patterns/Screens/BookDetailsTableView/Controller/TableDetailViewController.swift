//
//  TableDetailViewController.swift
//  Design Patterns
//
//  Created by Agil Madinali on 9/22/20.
//

import SafariServices
import UIKit

class TableDetailViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView! {
        didSet {
            self.detailTableView.delegate = self
            self.detailTableView.dataSource = self
        }
    }
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBAction func webButton(_ sender: UIBarButtonItem) {
        if let urlString = bookInfo.previewLink, let url = URL(string: urlString) {
            self.presentSafariVC(with: url)
        }
    }
    
    var bookInfo = VolumeInfo()
    var keyValueArray = [KeyValueStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Book Details"
        detailTableView.tableFooterView = UIView()
        populate()
        imageLoad()
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
                authorsString += author + "\n"
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

extension TableDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        keyValueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailTableView.dequeueReusableCell(
                withIdentifier: DetailTableViewCell.identifier, for: indexPath)
                as? DetailTableViewCell else { fatalError("Detail cell cannot be dequeued!") }
        
        cell.keyLabel.text = keyValueArray[indexPath.row].key
        cell.valueLabel.text = keyValueArray[indexPath.row].value
        return cell
    }
}

extension TableDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TableDetailViewController: SFSafariViewControllerDelegate {
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true)
    }
}
