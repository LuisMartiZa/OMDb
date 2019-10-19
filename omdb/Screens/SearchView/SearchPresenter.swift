//
//  SearchPresenter.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import Foundation

class SearchPresenter {
    var view: SearchView!
    var searchInteractor: SearchInteractor!
    
    var searchs: [SearchItem] = []
    
    convenience init(view: SearchView, interactor: SearchInteractor) {
        self.init()
        
        self.view = view
        self.searchInteractor = interactor
    }
    
    // MARK: - Data
    func searchItem(forRow row: Int) -> SearchItem? {
        if searchs.indices.contains(row) {
            return searchs[row]
        }
        return nil
    }
    
    // MARK: - Search
    func search(_ text: String) {
    }
    
    func cleanSearch() {
        searchs = []
        view.reloadData()
    }
}
