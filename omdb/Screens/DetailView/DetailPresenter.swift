//
//  DetailPresenter.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import Foundation

class DetailPresenter {
    var view: DetailView!
    var detailInteractor: SearchInteractorProtocol!
    var data: [String: Any]!
    
    convenience init(view: DetailView, interactor: SearchInteractorProtocol, data: [String: Any]) {
        self.init()
        
        self.view = view
        self.detailInteractor = interactor
        self.data = data
    }
}
