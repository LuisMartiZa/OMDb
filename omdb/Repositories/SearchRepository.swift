//
//  SearchRepository.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

protocol SearchRepositoryProtocol {
    func getSearchList(by text: String) -> Promise<[String:Any]>
    func getSearchDetail(by id: String) -> Promise<[String:Any]>
}

enum SearchRepositoryError: Error {
    case getSearchListError(String)
    case getSearchDetailError
}

class SearchRepository: SearchRepositoryProtocol {
    
    func getSearchList(by text: String) -> Promise<[String:Any]> {
        let url = baseURL.appending("s", value: text)
        
        return Promise<[String:Any]> { seal in
            
            Alamofire.request(url).responseJSON(completionHandler: { (response: DataResponse<Any>) in
                switch response.result {
                case .success:
                    if let json = response.value as? [String:Any] {
                        seal.fulfill(json)
                    } else {
                        seal.reject(SearchRepositoryError.getSearchListError("JSON Malformed"))
                    }
                case .failure(let error):
                    seal.reject(SearchRepositoryError.getSearchListError(error.localizedDescription))
                    break
                }
            })
        }
    }
    
    func getSearchDetail(by id: String) -> Promise<[String : Any]> {
        let url = baseURL.appending("i", value: id)
        
        return Promise<[String:Any]> { seal in
            
            Alamofire.request(url).responseJSON(completionHandler: { (response: DataResponse<Any>) in
                switch response.result {
                case .success:
                    if let json = response.value as? [String:Any] {
                        seal.fulfill(json)
                    } else {
                        seal.reject(SearchRepositoryError.getSearchDetailError)
                    }
                case .failure(_):
                    seal.reject(SearchRepositoryError.getSearchDetailError)
                    break
                }
            })
        }
    }
}
