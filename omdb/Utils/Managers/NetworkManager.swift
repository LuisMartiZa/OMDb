//
//  NetworkManager.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 19/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    //shared instance
    static let shared = NetworkManager()
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager()
    
    func startNetworkReachabilityObserver() {
        reachabilityManager?.listener = { status in
            switch status {
                
            case .notReachable, .unknown :
                print("The network is not reachable")
                Wireframe.shared.showLostConnectionAlert()
            case .reachable(.ethernetOrWiFi), .reachable(.wwan):
                print("The network is reachable over the WiFi connection")
            }
        }
        
        // start listening
        reachabilityManager?.startListening()
    }
}
