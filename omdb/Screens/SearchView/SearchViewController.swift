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
    let searchController = UISearchController(searchResultsController: nil)
    
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
    
    // MARK: - Other methods
    private func setupView() {
        title = "OMDb Search Engine"
        
        setupSearchController()
    }
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Busca aquí..."
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("TEXT: \(searchController.searchBar.text!)")
    }
}

// MARK: - UITableViewControllerDelegate
extension SearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UITableViewControllerDataSource
extension SearchViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
