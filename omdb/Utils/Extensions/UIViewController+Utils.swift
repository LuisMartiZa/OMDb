//
//  UIViewController+Utils.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 19/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, body: String) {
        let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
