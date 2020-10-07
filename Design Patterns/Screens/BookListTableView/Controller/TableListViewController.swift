//
//  TableListViewController.swift
//  Design Patterns
//
//  Created by Agil Madinali on 9/18/20.
//

import UIKit

class TableListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.tableFooterView = UIView()
            self.tableView.estimatedRowHeight = 50
            self.tableView.rowHeight = UITableView.automaticDimension
        }
    }
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var dataSource = [ItemInfo]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Table"
        self.activityIndicatorView.startAnimating()
        self.getDataFromServer()
    }
    
    func getDataFromServer() {
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=coding") else { return }
        ServiceManager.manager.request(withUrl: url) { data, error in
            guard let dataObj = data as? Data else {
                return
            }
            
            do {
                let responseObj = try JSONDecoder().decode(ApiResponse.self, from: dataObj)
                self.dataSource.append(contentsOf: responseObj.items ?? [])
                self.activityIndicatorView.stopAnimating()
            } catch {
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? TableDetailViewController else { return }
        
        if let index = tableView.indexPathForSelectedRow {
            detailVC.bookInfo = dataSource[index.row].volumeInfo ?? VolumeInfo()
        }
    }
}

extension TableListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TableListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell,
            let volumeInfo = item.volumeInfo else { fatalError("Unable to dequeue cell") }
        
        cell.configureCell(using: volumeInfo)
        return cell
    }
}
