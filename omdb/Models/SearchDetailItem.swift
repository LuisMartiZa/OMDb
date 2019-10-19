//
//  SearchDetailItem.swift
//  omdb
//
//  Created by Luis Martínez Zarza on 18/10/2019.
//  Copyright © 2019 Luis Martínez Zarza. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchDetailItem: SearchItem {
    var releasedDate: String?
    var runtime: String?
    var genre: String?
    var plot: String?
    var website: URL?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        releasedDate    <- map["Released"]
        runtime         <- map["Runtime"]
        genre           <- map["Genre"]
        plot            <- map["Plot"]
        
        // Optional
        if let mapString = map.JSON["website"] as? String {
            website = URL(string: mapString)
        }
    }
}
