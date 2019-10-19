//
//  DetailViewController.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    @IBOutlet weak var fullscreenBtn: UIButton!
    
    // MARK: - Variables
    var presenter: DetailPresenter? = nil
    var isHeaderFullscreen: Bool = false {
        didSet {
            if isHeaderFullscreen {
                fullscreenBtn.setImage(#imageLiteral(resourceName: "fullscreenExitIcon"), for: .normal)
            } else {
                fullscreenBtn.setImage(#imageLiteral(resourceName: "fullscreenIcon"), for: .normal)
            }
        }
    }
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
        websiteLabel.text = detailSearch.website?.absoluteString ?? "NO WEB"
    }
    
    // MARK: IBActions
    @IBAction func downloadImageAction(_ sender: Any) {
        if let image = headerImageView.image {
            presenter?.saveImage(image)
        }
    }
    @IBAction func fullscreenAction(_ sender: Any) {
        if isHeaderFullscreen {
            headerView.snp.remakeConstraints { (make) in
                if #available(iOS 11, *) {
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                }
                make.left.right.equalToSuperview()
                make.bottom.equalTo(infoView.snp.top)
                make.height.equalTo(headerView.snp.width).multipliedBy(3/4)
            }
        } else {
            headerView.snp.remakeConstraints { (make) in
                if #available(iOS 11, *) {
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                }
                make.left.right.bottom.equalToSuperview()
            }
        }
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        }, completion: { [weak self] (_) in
            guard let self = self else { return }
            self.isHeaderFullscreen.toggle()
        })
    }
    @IBAction func shareWebsiteAction(_ sender: UILongPressGestureRecognizer) {
        if let websiteURL = presenter?.getWebsiteURL() {
            presentShareView(for: [websiteURL])
        } else {
            showAlert(title: "ERROR", body: "Can't Share 😖")
        }
    }
    
}

extension DetailViewController: DetailView {
    func reloadView(with detailSearch: SearchDetailItem) {
        setupView(detailSearch)   
    }
    
    func displayAlert(title: String, body: String) {
        showAlert(title: title, body: body)
    }
}
