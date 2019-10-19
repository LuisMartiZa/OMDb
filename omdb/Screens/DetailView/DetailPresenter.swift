//
//  DetailPresenter.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import UIKit

class DetailPresenter: NSObject {
    var view: DetailView!
    var detailInteractor: SearchInteractorProtocol!
    var data: [String: Any]!
    
    convenience init(view: DetailView, interactor: SearchInteractorProtocol, data: [String: Any]) {
        self.init()
        
        self.view = view
        self.detailInteractor = interactor
        self.data = data
    }
    
    func load() {
        if let imdbID = data["filmID"] as? String {
            detailInteractor.getSearchDetail(by: imdbID).done { (searchDetailItem) in
                self.view.reloadView(with: searchDetailItem)
            }.catch { (error) in
                self.view.displayAlert(title: "Error", body: error.localizedDescription)
            }
        }
    }
    
    func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            self.view.displayAlert(title: "Save Error", body: error.localizedDescription)
        } else {
            self.view.displayAlert(title: "Saved", body: "Your image has been saved to your photos.")
        }
    }
}
