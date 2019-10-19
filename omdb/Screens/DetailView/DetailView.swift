//
//  DetailView.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import Foundation

protocol DetailView {
    func reloadView(with detailSearch: SearchDetailItem)
    func displayError(_ error: String)
}
