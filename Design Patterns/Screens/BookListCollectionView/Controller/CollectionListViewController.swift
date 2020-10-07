//
//  CollectionListViewController.swift
//  Design Patterns
//
//  Created by Agil Madinali on 9/23/20.
//

import UIKit

class CollectionListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            let flowLayout = (self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout)
            flowLayout?.estimatedItemSize = CGSize(width: 225, height: 225)
            flowLayout?.itemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var dataSource = [ItemInfo]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Collection"
        self.getDataFromServer()
    }
    
    func getDataFromServer() {
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=coding") else { return }
        ServiceManager.manager.request(withUrl: url) { data, error in
            guard let dataObj = data as? Data else {
                // display alert to the user
                return
            }
            
            do {
                let responseObj = try JSONDecoder().decode(ApiResponse.self, from: dataObj)
                //self.dataSource = responseObj.items ?? []
                self.dataSource.append(contentsOf: responseObj.items ?? [])
            } catch {
                print(error)
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        guard let detailVC = segue.destination as? TableDetailViewController else { return }
//
//        if let index = collectionView.indexPathsForSelectedItems?.first
//        {
//            detailVC.bookInfo = dataSource[index.row].volumeInfo ?? VolumeInfo()
//        }
//    }
}

extension CollectionListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let detailVC = storyboard?.instantiateViewController(
                identifier: CollectionDetailViewController.identifier) as? CollectionDetailViewController
                else { return }

        detailVC.bookInfo = dataSource[indexPath.row].volumeInfo ?? VolumeInfo()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension CollectionListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.dataSource[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ListCollectionViewCell.identifier,
                for: indexPath) as? ListCollectionViewCell,
            let volumeInfo = item.volumeInfo else { fatalError("Unable to dequeue cell") }
        
        cell.configureCell(using: volumeInfo)
        return cell
    }
}

extension CollectionListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionSize = collectionView.bounds
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let padding = flowLayout.minimumInteritemSpacing +
                flowLayout.sectionInset.left +
                flowLayout.sectionInset.right +
                collectionView.contentInset.left +
                collectionView.contentInset.right
            
            let itemWidth = (collectionSize.width - padding) / 2
            return  CGSize(width: itemWidth, height: itemWidth)
        }
        return CGSize.zero
    }
}
