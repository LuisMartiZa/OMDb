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
    var searchInteractor: SearchInteractorProtocol!
    
    var searchs: [SearchItem] = []
    
    convenience init(view: SearchView, interactor: SearchInteractorProtocol) {
        self.init()
        
        self.view = view
        self.searchInteractor = interactor
    }
    
    // MARK: - Data
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(section: Int) -> Int {
        return searchs.count
    }
    
    func searchItem(forRow row: Int) -> SearchItem? {
        if searchs.indices.contains(row) {
            return searchs[row]
        }
        return nil
    }
    
    func didSelect(row: Int, section: Int) {
        if searchs.indices.contains(row),
            let filmID = searchs[row].imdbID {
            let data = ["filmID": filmID]
            
            Wireframe.shared.pushSearchDetailView(data: data)
        }
    }
    
    // MARK: - Search
    func search(_ text: String) {
        self.searchInteractor.getSearchList(by: text).done { (searchItems) in
            self.searchs = searchItems
            self.view.reloadData()
        }.catch { (error) in
            self.searchs = []
            self.view.displayError(error.localizedDescription)
        }
    }
    
    func cleanSearch() {
        searchs = []
        view.reloadData()
    }
}
