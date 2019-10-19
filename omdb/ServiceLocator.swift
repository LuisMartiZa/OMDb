//
//  ServiceLocator.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import UIKit

class ServiceLocator {
    static let shared = ServiceLocator()
    
    private init() {}
    
    private func provideMainStoryboard() -> BaseStoryboard {
        return BaseStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    // Provide View
    func provideMainNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: provideSearchView())
    }
    
    func provideSearchView() -> SearchViewController {
        let view: SearchViewController = provideMainStoryboard().instantiateViewController("SearchViewController")
        let presenter = SearchPresenter(view: view, interactor: provideSearchInteractor())
        view.presenter = presenter
        
        return view
    }
    
    func provideDetailSearchView(data: [String: Any]) -> DetailViewController {
        let view: DetailViewController = provideMainStoryboard().instantiateViewController("DetailViewController")
        let presenter = DetailPresenter(view: view, interactor: provideSearchInteractor(), data: data)
        view.presenter = presenter
        
        return view
    }
    
    func provideSearchInteractor() -> SearchInteractorProtocol {
        return SearchInteractor(repository: SearchRepository())
    }
}
