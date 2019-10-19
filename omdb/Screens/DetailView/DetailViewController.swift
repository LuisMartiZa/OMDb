//
//  DetailViewController.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, DetailView {
    // MARK: - Variables
    var presenter: DetailPresenter? = nil
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Other methods
    private func setupView() {
        title = "Film"
        
    }
}
