//
//  SearchTableViewCell.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    func setData(from searchItem: SearchItem) {
        self.titleLabel.text = searchItem.title
        self.yearLabel.text = searchItem.year
        let urlImage = URL(string: searchItem.posterImage!)
        self.posterImageView.kf.setImage(with: urlImage)
    }
}
