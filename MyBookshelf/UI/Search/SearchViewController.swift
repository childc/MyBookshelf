//
//  SearchViewController.swift
//  MyBookshelf
//
//  Created by childc on 2021/11/03.
//

import UIKit

class SearchViewController: UIViewController {
    var searchController = UISearchController()
    @IBOutlet weak var tableView: UITableView!
    
    // ViewModel
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Search controller setup
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        // Table view setup
        tableView.delegate = self
        tableView.dataSource = self
        
        // Subscribe ViewModel
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.searchResult.bind { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowDetail":
            if let detailVC = segue.destination as? DetailViewController,
               let selectedRow = tableView.indexPathForSelectedRow?.row {
                detailVC.isbn13 = viewModel.isbn13(index: selectedRow)
            }
            
        default:
            break
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Search Controller

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}


extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            viewModel.search(query: query)
        }

    }
}


extension SearchViewController: UISearchControllerDelegate {
    
}

// MARK: - Table View Controller

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchResult.value?.books.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! BookCell
        cell.titleLabel.text = viewModel.searchResult.value?.books[indexPath.row].title ?? "empty"
        return cell
    }
}
