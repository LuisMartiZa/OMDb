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
    case getSearchListError(String)
    case getSearchDetailError(String)
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
                if let jsonResults = json["Search"] as? [[String: Any]] {
                    for searchItemJSON in jsonResults {
                        let searchItem = SearchItem(JSON: searchItemJSON)!
                        searchItemArray.append(searchItem)
                    }
                    seal.fulfill(searchItemArray)
                } else {
                    let errorInteractor = SearchInteractorError.getSearchListError("No data")
                    seal.reject(errorInteractor)
                }
                
            }).catch({ (error) in
                let errorInteractor = SearchInteractorError.getSearchListError(error.localizedDescription)
                seal.reject(errorInteractor)
            })
        }
    }
    
    func getSearchDetail(by id: String) -> Promise<SearchDetailItem> {
        return Promise<SearchDetailItem> { seal in
            repository.getSearchDetail(by: id).done({ (json) in
                if let searchDetailItem = SearchDetailItem(JSON: json) {
                    seal.fulfill(searchDetailItem)
                } else {
                    let errorInteractor = SearchInteractorError.getSearchDetailError("JSON Malformed")
                    seal.reject(errorInteractor)
                }
            }).catch({ (error) in
                let errorInteractor = SearchInteractorError.getSearchDetailError(error.localizedDescription)
                seal.reject(errorInteractor)
            })
        }
    }
}
