//
//  DetailViewController.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    // MARK: - Variables
    var presenter: DetailPresenter? = nil
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.load()
    }
    
    // MARK: - Other methods
    private func setupView(_ detailSearch: SearchDetailItem) {
        title = detailSearch.title
        if let posterImage = detailSearch.posterImage, let posterURL = URL(string: posterImage) {
            headerImageView.kf.setImage(with: posterURL, placeholder: #imageLiteral(resourceName: "placeholder"), options: [.transition(.flipFromLeft(0.9))])
        }
        titleLabel.text = detailSearch.title
        releasedDateLabel.text = detailSearch.releasedDate
        durationLabel.text = detailSearch.runtime
        genreLabel.text = detailSearch.genre
        plotLabel.text = detailSearch.plot
        websiteLabel.text = detailSearch.website?.absoluteString ?? "Sin web"
    }
}

extension DetailViewController: DetailView {
    func reloadView(with detailSearch: SearchDetailItem) {
        setupView(detailSearch)
    }
    
    func displayError(_ error: String) {
        self.showAlert(title: "Error", body: error)
    }
}
