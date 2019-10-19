//
//  Wireframe.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import UIKit

class Wireframe {
    var rootViewController: UINavigationController?
    var topViewController: UIViewController?
    
    static let shared = Wireframe()
    
    private init() {}
    
    func presentMainNavigator(window: UIWindow) {
        let mainNavigatorView = ServiceLocator.shared.provideMainNavigation()
        rootViewController = mainNavigatorView
        topViewController = mainNavigatorView.topViewController
        
        mainNavigatorView.view.alpha = 0.0
        window.rootViewController = mainNavigatorView
        
        UIView.transition(with: window, duration: 0.6, options: .transitionCrossDissolve, animations: {
            mainNavigatorView.view.alpha = 1.0
        }, completion: nil)
    }
    
    func pushSearchDetailView(data: [String: Any]) {
        let searchDetailView = ServiceLocator.shared.provideDetailSearchView(data: data)
        rootViewController?.pushViewController(searchDetailView, animated: true)
    }
}
