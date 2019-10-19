//
//  SearchInteractor.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import Foundation
import PromiseKit

protocol SearchInteractorProtocol {
    func getSearchList(by text: String) -> Promise<[SearchItem]>
    func getSearchDetail(by id: String) -> Promise<SearchDetailItem>
}

enum SearchInteractorError: Error {
    case getSearchListError
    case getSearchDetailError
}

class SearchInteractor: SearchInteractorProtocol {
    private let repository: SearchRepositoryProtocol!
    
    init(repository: SearchRepositoryProtocol) {
        self.repository = repository
    }
    
    func getSearchList(by text: String) -> Promise<[SearchItem]> {
        return Promise<[SearchItem]> { seal in
            repository.getSearchList(by: text).done({ (json) in
                var searchItemArray: [SearchItem] = []
                for searchItemJSON in json {
                    let searchItem = SearchItem(JSON: searchItemJSON)!
                    searchItemArray.append(searchItem)
                }
                seal.fulfill(searchItemArray)
            }).catch({ (error) in
                seal.reject(SearchInteractorError.getSearchListError)
            })
        }
    }
    
    func getSearchDetail(by id: String) -> Promise<SearchDetailItem> {
        return Promise<SearchDetailItem> { seal in
            repository.getSearchDetail(by: id).done({ (json) in
                if let searchDetailItem = SearchDetailItem(JSON: json) {
                    seal.fulfill(searchDetailItem)
                } else {
                    seal.reject(SearchInteractorError.getSearchDetailError)
                }
            }).catch({ (error) in
                seal.reject(SearchInteractorError.getSearchDetailError)
            })
        }
    }
}
