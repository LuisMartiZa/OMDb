//
//  SearchViewController.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, SearchView {
    
    // MARK: - Variables
    var presenter: SearchPresenter!
    let searchController = UISearchController(searchResultsController: nil)
    var dispatchWorkItem: DispatchWorkItem? = nil
    let typeInterval: TimeInterval = 1.0
    
    var lastSearchString: String = ""
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Set visible as initial
        searchController.isActive = true
    }
    
    // MARK: - SearchView Delegate Protocol
    func reloadData() {
        tableView.reloadData()
    }
    
    func displayError(_ error: String) {
        reloadData()
        showAlert(title: "ERROR", body: error)
    }
    
    // MARK: - Other methods
    private func setupView() {
        title = "OMDb Search Engine"
        tableView.register(UINib(nibName: SearchTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: SearchTableViewCell.reuseIdenfier)
        setupSearchController()
    }
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func handleTyping(_ text: String) {
        dispatchWorkItem?.cancel()
        
        dispatchWorkItem = DispatchWorkItem(block: { [weak self] in
            guard let self = self else { return }
            self.lastSearchString = text
            self.presenter?.search(text)
        })
        
        if let typingWorkItem = dispatchWorkItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + typeInterval, execute: typingWorkItem)
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 3 {
            if text != lastSearchString {
                handleTyping(text)
            }
        } else {
            presenter?.cleanSearch()
        }
    }
}

// MARK: - UITableViewControllerDelegate
extension SearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelect(row: indexPath.row, section: indexPath.section)
    }
}

// MARK: - UITableViewControllerDataSource
extension SearchViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = presenter.numberOfRows(section: section)
        
        if numberOfRows == 0 {
            tableView.setEmptyMessage("Search...Search 😁")
        } else {
            tableView.restore()
        }
        
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = presenter?.searchItem(forRow: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdenfier)
        
        if let searchTableCell = cell as? SearchTableViewCell {
            searchTableCell.setData(from: data!)
        }

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
}
